#!/usr/bin/perl
use CGI':standard';
print header();
print start_html(-title=>"6b Program");

open(FILE,'<count.txt');
$count = <FILE>;
$count++;
open(FILE,'>count.txt');
print FILE "$count";
print b("This page has been viewed $count time");
close(FILE);
print end_html();