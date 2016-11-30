<?php
	date_default_timezone_set('Asia/Calcutta');
	$months = 60*60*24*60 + time();
	// Just to print time on date, \o\\n is used, you can also use a -
	setCookie('lastVisit', date("G:i \o\\n m/d/y"), $months);
	if(isSet($_COOKIE['lastVisit'])){
		$visit = $_COOKIE['lastVisit'];
		echo "Your last visit was at ".$visit;
	}else
		echo "You have got some cookies";
?>