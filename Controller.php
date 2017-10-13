<?php

use Database as DB;
use GuzzleHttp\Client;
use Psr\Http\Message\ResponseInterface;
use GuzzleHttp\Exception\RequestException;
use GuzzleHttp\Pool;
use GuzzleHttp\Psr7\Request;
use GuzzleHttp\Promise;

class Controller {
    private $espbClient;

    const API_USER = 'api_stats_msg';
    const API_PASS = 'fdad56ae288bff3183906f96db0d47d2';

    const HTACCESS_USER = 'Arthur';
    const HTACCESS_PASS = 'fgtUik8ljP73';

    private $user;
    private $session;
    private $results = [];

    public function __construct() {
        $this->espbClient = new Client([
            'base_uri' => 'http://espaceforce.espacebusiness.com',
            'timeout'  => 2.0,
        ]);
    }

    public function clients() {
        return DB::query("SELECT acc_id, acc_name FROM accounts WHERE acc_name is not null and acc_name <> '' ORDER BY acc_name ");
    }

    //retrieve all campaigns and products for the specified client
    public function getClient($id) {
        $result = [];

        $result['products'] = DB::query('SELECT prod_id, prod_name FROM account_products WHERE acc_id=:id', [
            ':id' => $id
        ]);

        $result['campaigns'] = DB::query("SELECT DISTINCT camp_id, camp_name FROM campaigns "
            ." JOIN campaign_messages USING(camp_id) "
            ." JOIN messages USING(msg_id) "
            ." JOIN orders USING (ord_id) WHERE acc_id=:id",
            [
                ':id' => $id
        ]);

        return $result;
    }

    public function messages($product, $campaign) {
        $query = "SELECT msg_id, m.msg_name, DATE_FORMAT(start, '%d/%m/%Y') as start, fichier, sent, aboutis, aboutis/fichier*100 as tx_aboutis,opened, opened/fichier*100 as tx_opened, clicks, clicks/fichier*100 as tx_clicks "
            // .",nb_coupons, nb_coupons/fichier*100 as tx_coupons"
            .' FROM messages m '
            .' LEFT JOIN ('
                .' SELECT msg_id,SUM(pf_comptage) as fichier FROM plan_fichiers GROUP BY msg_id'
            .') as fichiers USING (msg_id)'
            .' LEFT JOIN ('
                .' SELECT msg_id, MIN(emv_email_send_dts) AS start, SUM(emv_email_send) AS sent, SUM(emv_email_aboutis) AS aboutis, SUM(emv_email_opened) as opened, SUM(emv_email_clicks) AS clicks'
                .' FROM emv_emails GROUP BY msg_id'
            .') AS emv USING (msg_id)'
            // .' JOIN ('
            //     .' SELECT msg_id, count(*) as nb_coupons FROM coupons LEFT JOIN message_coupons USING(cpn_id) WHERE cpn_stt_id=1 GROUP BY msg_id'
            // .') AS coup USING(msg_id)'
            ;
        $params = [];

        if ($product != 'null') {
            $query .= ' WHERE prod_id=:prod';
            $params[':prod'] = intval($product);
        }
        if ($campaign != 'null') {
            $query .= ' JOIN campaign_messages USING (msg_id) WHERE camp_id=:camp';
            $params[':camp'] = intval($campaign);
        }
        // return $query;

        return DB::query($query, $params);
    }

    private function connectEspb() {
        $res = $this->espbClient->request('GET', '/api/api_connect.php', [
            'query' => [
                'user_name' => self::API_USER,
                'user_pwd'  => self::API_PASS
            ],
            'auth' => [self::HTACCESS_USER, self::HTACCESS_PASS]
        ]);
        $user = simplexml_load_string($res->getBody()->getContents());
        $this->user = (string)$user->CONNECT[0]['USER_ID'];
        $this->session = (string)$user->CONNECT[0]['SESSION_ID'];
    }

    private function getSendQty($msgId) {
        if (!$this->user || !$this->session) {
            $this->connectEspb();
        }
        $res = $this->espbClient->request('GET', '/api/api_envois_existants.php', [
            'query' => [
                'user_id'    => $this->user,
                'session_id' => $this->session,
                'message'    => $msgId
            ],
            'auth' => [self::HTACCESS_USER, self::HTACCESS_PASS]
        ]);
        $sendings = simplexml_load_string($res->getBody()->getContents());
        return intval((string)$sendings->RETURN[0]['QUANTITE']);
    }

    private function getUnsubscribedQty($msgId) {
        if (!$this->user || !$this->session) {
            $this->connectEspb();
        }
        $res = $this->espbClient->request('GET', '/api/api_stats_desabos_ann.php', [
            'query' => [
                'user_id'    => $this->user,
                'session_id' => $this->session,
                'message'    => $msgId
            ],
            'auth' => [self::HTACCESS_USER, self::HTACCESS_PASS]
        ]);
        $sendings = simplexml_load_string($res->getBody()->getContents());
        return intval((string)$sendings->RETURN[0]['QUANTITE']);
    }

    public function getAllAdditionnalInfos($msgId) {
        $coupons = DB::query("SELECT count(*) as nb_coupons FROM coupons LEFT JOIN message_coupons USING(cpn_id) WHERE cpn_stt_id=1 AND msg_id=:id", [
            ':id' => $msgId
        ])[0]['nb_coupons'];
        return [
            'msg_id'       => $msgId,
            'unsubscribes' => $this->getUnsubscribedQty($msgId),
            'envois'       => $this->getSendQty($msgId),
            'coupons'      => intval($coupons)
        ];
    }

    public function getEspbInfos($msgIds) {
        $results = [];
        $msgIds = explode(' ', $msgIds);

        $this->connectEspb();

        //ASYNC
        // $results = [];
        // $unsubRequests = function ($msgIds, $user, $session, $htuser, $htpass) {
        //     foreach ($msgIds as $msgId) {
        //         yield new Request('GET', "/api/api_stats_desabos_ann.php?user_id={$user}&session_id={$session}&message={$msgId}", [
        //             'auth' => [$htuser, $htpass],
        //             'Authorization' => 'Basic ' . base64_encode("$htuser:$htpass")
        //         ]);
        //     }
        // };
        // $pool = new Pool($this->espbClient, $unsubRequests($msgIds, $this->user, $this->session, self::HTACCESS_USER, self::HTACCESS_PASS), [
        //     'concurrency' => 10,
        //     'fulfilled' => function ($response, $index, $msgIds) {
        //         $sendings = simplexml_load_string($response->getBody()->getContents());
        //         echo json_encode([
        //             'index'        => intval($msgIds[$index]),
        //             'unsubscribes' => intval((string)$sendings->RETURN[0]['QUANTITE'])
        //         ]) . ',';
        //     },
        //     'rejected' => function ($reason, $index) {},
        // ]);
        // $promise = $pool->promise();


        // //SYNCH
        foreach ($msgIds as $msgId) {
            $results[$msgId] = [
                'unsubscribes' => $this->getUnsubscribedQty($msgId),
                'envois'       => $this->getSendQty($msgId)
            ];
        }

        return $results;
    }
}
