<?php

require_once('../Controller.php');
require_once('../Database.php');
require_once('../vendor/autoload.php');

$db = Database::instance();


//ROUTER
if (!empty($_GET) && isset($_GET['path'])) {
    $path = explode('/', $_GET['path']);
    //API
    if ($path[0] == 'api') {
        $controller = new Controller;
        header('Content-Type: application/json');
        switch ($path[1]) {
            case 'clients':
                if (count($path) > 2) {
                    $response = $controller->getClient(intval($path[2])); // GET /clients/id
                } else {
                    $response =  $controller->clients(); // GET /clients
                }
                break;
            case 'messages': // GET /messages/product/:id1/campaign/:id2
                if (count($path) == 4 && $path[2] == 'espb-infos') {
                    $response = $controller->getEspbInfos($path[3]);
                }
                if (count($path) == 4 && $path[2] == 'all-infos') {
                    $response = $controller->getAllAdditionnalInfos($path[3]);
                }
                if (count($path) == 6 && $path[2] == 'product' && $path[4] == 'campaign') {
                    $response = $controller->messages($path[3], $path[5]);
                }
                break;
            default:
                break;
        }
        // echo $response;
        echo json_encode($response);
    } else {
        require '../views/layout.php';
    }
} else {
    require '../views/layout.php';
}
