<?php
	session_start();
	// if program doesnt work, just comment session_register since it is a deprecated function
	session_register("count");
	if(!isset($_SESSION)){
		$_SESSION["count"] =0;
		echo "Initialised";
	}else{
		$_SESSION["count"]++;
	}

	echo "Counter is: ".$_SESSION["count"];
?>