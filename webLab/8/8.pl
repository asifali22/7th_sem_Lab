#!/usr/bin/perl
use DBI;
use CGI':standard';
print "content-type:text/html\n\n";
$name=param("name");
$age=param("age");
$con=DBI->connect("DBI:mysql:web","sirmvit","cse");
$res=$con->prepare("insert into age_info values('$name','$age')");
$res->execute();
$res1=$con->prepare("select * from age_info");
$res1->execute();
$len=$res1->rows;
print "<html><body bgcolor=lightgreen><center>";
if($len<=0){
	print "No rows found";
}
else{
print "The database table contents shown below<br><br><table border=1>";
print "<tr><td>Name</td><td>Age</td></tr>";
while(@data=$res1->fetchrow_array()){
	print "<tr><td>$data[0]</td><td>$data[1]</td></tr>";
}
print "</table>";
}
print "</center></body></html>";
