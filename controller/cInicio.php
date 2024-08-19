<?php
require_once ('Model/agenda.php');

class CInicio {
    public function Inicio() {
        $agenda = new agenda();
        // $fechaVencimiento = $_POST['fechaVencimiento'];
        // $id = $_POST['id'];
        // $result = $agenda->search($fechaVencimiento);
        // $count = $agenda->count($id);

        require_once 'View/inicio.php';
    }
}
?>