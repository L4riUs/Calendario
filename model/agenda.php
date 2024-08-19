<?php
require_once ('conexion.php');
class agenda extends conexion{
    private $id;
    private $fechaElaboracion;
    private $evento;
    private $fechaVencimiento;
    private $estado;
    
    public function __construct(
        $id = null,
        $fechaElaboracion = null,
        $evento = null,
        $fechaVencimiento = null,
        $estado = null
    ) {
        $this->id = $id;
        $this->fechaElaboracion = $fechaElaboracion;
        $this->evento = $evento;
        $this->fechaVencimiento = $fechaVencimiento;
        $this->estado = $estado;
        parent::__construct();
    }    
    public function search($fechaVencimiento){
        $search_sql = "SELECT * FROM agenda WHERE fechaVencimiento = $fechaVencimiento";
        $stmt = $this->conn->prepare($search_sql);
        $stmt->execute();
        return $stmt->fetchAll();
    }
    public function count($fechaVencimiento) {
        $search_sql = "SELECT COUNT(*) AS total FROM agenda WHERE fechaVencimiento = $fechaVencimiento";
        $stmt = $this->conn->prepare($search_sql);
        $stmt->execute();
        return $stmt->fetchColumn();
    }
    public function insert($fechaElaboracion, $evento, $fechaVencimiento, $estado){
        $insert_sql = "INSERT INTO agenda (fechaElaboracion, evento, fechaVencimiento, estado) VALUES(:fechaElaboracion, :evento, :fechaVencimiento, :estado)";
        $stmt = $this->conn->prepare($insert_sql);
        $stmt->bindParam(':fechaElaboracion', $fechaElaboracion);
        $stmt->bindParam(':evento', $evento);
        $stmt->bindParam(':fechaVencimiento', $fechaVencimiento);
        $stmt->bindParam(':estado', $estado);
        $stmt->execute();
    }
    public function update($id, $fechaElaboracion, $evento, $fechaVencimiento, $estado){
        $update_sql = "UPDATE agenda SET fechaElaboracion = :fechaElaboracion, evento = :evento, fechaVencimiento = :fechaVencimiento, estado = :estado WHERE id = :id;";
        $stmt = $this->conn->prepare($update_sql);
        $stmt->bindParam(':id', $id);
        $stmt->bindParam(':fechaElaboracion', $fechaElaboracion);
        $stmt->bindParam(':evento', $evento);
        $stmt->bindParam(':fechaVencimiento', $fechaVencimiento);
        $stmt->bindParam(':estado', $estado);
        $stmt->execute();
    }
    public function desactive($id){
        $desactive_sql = "UPDATE agenda SET estado = 0 WHERE id=:id";
        $stmt = $this->conn->prepare($desactive_sql);
        $stmt->bindParam(':id', $id);
        $stmt->execute();
    }
}
?>