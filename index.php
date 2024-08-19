<?php 
$ruta = isset($_GET['c'])? $_GET['c']: "CInicio/Inicio";

$partes = explode("/", $ruta);

$nomClase = ucfirst($partes['0']);

$metodo = isset($partes['1'])? $partes['1']: "Inicio";

$url = "controller/".$partes['0'].".php";

if (file_exists($url)) {

	require_once $url;

	$instancia = new $nomClase();

	if (method_exists($instancia, $metodo)) {
		
		$instancia->$metodo();
	}else{
		echo "NO EXISTE EL METODO";
	}

}else{
	echo "NO EXISTE EL CONTROLADOR";
}


?>