#!/usr/bin/perl
print "content-type:text/html\n\n";
use CGI':standard';
$name=param("name");
@a=("hi","how u doing","hello","welcome");
$rndm=rand(4);
print "<html><head><title>Greeting message</title></head>";
print "<body>";
print "hi $name your greeting message is $a[$rndm]";
print "</body></html>";