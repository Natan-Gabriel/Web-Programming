<?php
   $dbhost = 'localhost:3036';
   $dbuser = 'root';
   $dbpass = 'password';
   
   $conn = mysql_connect($dbhost, $dbuser, $dbpass);
   
   if(! $conn ) {
      die('Could not connect: ' . mysql_error());
   }
   
   $sql = 'SELECT id, name FROM cities';
   mysql_select_db('db');
   $retval = mysql_query( $sql, $conn );
   
   if(! $retval ) {
      die('Could not get data: ' . mysql_error());
   }
   
   while($row = mysql_fetch_assoc($retval)) {
      echo "EMP ID :" . $row['id'] . "<br>";
   }
   
   //echo "Fetched data successfully\n";
   
   mysql_close($conn);
?>

