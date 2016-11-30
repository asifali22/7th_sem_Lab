<html>
<body>
<form action=" <?=$self?> " method="POST">
<p>
NAME:<input type=text name="name"><br><br>
EMAIL:<input type=text name="eml"><br><br>
Address Line 1:<input type=text name="ad1"><br><br>
Address Line 2:<input type=text name="ad2"><br><br>
</p>
<input type="submit" value="submit">
</form>

<?php
$self=$_SERVER['PHP_SELF'];
$dbh=mysql_connect('localhost','root','admin123') or die(mysql_error());
mysql_select_db('test')or die(mysql_error());

if(isset($_POST['name']))
{
    $name=$_POST['name'];
    $eml=$_POST['eml'];
    $address1=$_POST['ad1'];
    $address2=$_POST['ad2'];
    
    if($name!="" && $eml==""&&$address1==""&&$address2==""){
      $querySelect="select * from student where name = '$name';";
      $result1=mysql_query($querySelect) or die(mysql_error());
      if(mysql_num_rows($result1)!=0){
	      echo "<table border><tr><th>Name</th><th>Email</th><th>Address 1</th><th>Address 2</th></tr>";		
	      while($row = mysql_fetch_array($result1, MYSQL_ASSOC)){
	      echo "<tr><td>".$row["name"]."</td><td>".$row["email"]."</td><td>".$row["address1"]."</td><td>".$row["address2"]."</td></tr>";		
	      }
	      echo "</table>";
        }else{
	      echo "No data for <b>".$name."</b>";
      }
  }else if($name!=""&&$eml!=""&&$address1!=""&&$address2!=""){
    $query="insert into student values('$name','$eml','$address1','$address2')";
    $result=mysql_query($query) or die(mysql_error());
    if($result)
	   echo "\nData inserted successfully\n";	
  }else
      echo "One or more field(s) is empty";
}

mysql_close($dbh);
?>
</body>
</html>             
