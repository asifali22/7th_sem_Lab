#!/usr/bin/perl
use CGI':standard';
print header();
print start_html(-title=>"time");
($s,$m,$h)=localtime(time);
print "The time is: $h:$m:$s";
print end_html();