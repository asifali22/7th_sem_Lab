#!/usr/bin/perl
use CGI':standard';
print header();
print start_html(-title=>"5a Program");
print b("Information is show below");
print "<table border=1><tr><td>Env Variable</td>";
print "<td>Env Value</td></tr>";
foreach $a(sort keys %ENV)
{
	print "<tr><td>$a</td><td>$ENV{$a}</td></tr>";
}
print "</table>";
print end_html();