<?php
	session_start();
	//session_register("count");
	if(!isset($_SESSION)){
		$_SESSION["count"] =0;
		echo "Initialised";
	}else{
		$_SESSION["count"]++;
	}

	echo "Counter is: ".$_SESSION["count"];
?>