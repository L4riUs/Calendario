<?php
    class conexion extends PDO{
        public $conn;
        function __construct(){
            $servername = "localhost";
            $username = "root";
            $password = "";
            $dbname = "agenda";
            try {
                $this->conn = new PDO("mysql:host=$servername;dbname=$dbname;charset=utf8", $username, $password);
                $this->conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
                $this->conn->setAttribute(PDO::MYSQL_ATTR_INIT_COMMAND, "SET NAMES utf8");
                
            } catch(PDOException $e) {
                die("Error en la conexión: " . $e->getMessage());
            }
        }
        
    }
?>