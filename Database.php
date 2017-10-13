<?php

class Database {
    private static $connection;
    private static $user = 'thur';
    private static $pass = 'secret';

    public static function instance() {
        if (!isset(self::$connection)) {
            self::$connection = new PDO('mysql:host=localhost;dbname=tested', self::$user, self::$pass, array(PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8"));
        }
        return self::$connection;
    }

    public static function query($q, $params = []) {
        $query =  self::$connection->prepare($q);
        $query->execute($params);
        return $query->fetchAll(PDO::FETCH_ASSOC);
    }
}
