<?php

include ("../02ui/commonfiles/header.php");
	include '../07config/newdbconfig.php';
$id=$_GET['id'];
$code=$_GET['code'];
echo $id;
echo $code;
$sql="update patient_master set Verified=1 where Patient_ID like '".$id."' and Verified=".$code;
//echo $sql;
if(mysqli_query($conn,$sql))
{
	
}

if(mysqli_query($conn,$sql))
{
	// echo "Success Confirmed";
	//Mail Functionality  
		  include('../02ui/commonfiles/phpmailer/PHPMailerAutoload.php');
		  $mail = new PHPMailer;
		  $mail->Host = 'smtp.dallas142.org';  //Sets the SMTP hosts
		  $mail->Port = 587;        //Sets the default SMTP server port
		  $mail->SMTPAuth = true;       //Sets SMTP authentication. Utilizes the Username and Password variables
		  $mail->SMTPSecure = 'tls';       //Sets connection prefix. Options are "", "ssl" or "tls"
		  $mail->Username = 'gauthamr.silumula@chidhagni.com';     //Sets SMTP username
		  $mail->Password = 'Gautham@28';     //Sets SMTP password
		  
		  
		  $mail->setFrom('gauthamr.silumula@chidhagni.com','Gautham');     //Sets the From email address for the message
		  
		  $mail->addAddress($email);//Adds a "To" address
		  $mail->addReplyTo('gauthamr.silumula@chidhagni.com','Gautham');
		 
		  $mail->WordWrap = 50;       //Sets word wrapping on the body of the message to a given number of characters
		  $mail->IsHTML(true);       //Sets message type to HTML    
		  $mail->Subject = "Activation";    //Sets the Subject of the message
		  $mail->Body = "<html>Please Click on the below Link for Activation </br>  http://".$_SERVER['SERVER_NAME'].$root."08common/confirm.php?id=".$patient_id."&code=".$code." ";    //An HTML or plain text message body
		  if($mail->Send())        //Send an Email. Return true on success or false on error
		  {
		   echo 'Success Mail';
		  }
		  else
		  {
		   echo 'Failure Email Sent';
		  }
		  
	?>

<script>
	alert("Account Activated You can Login with Username:email and Password is your dob 'ddmmyyyy'.");
	document.location.href="/index.php";
</script>
	<?php
}
else
{
?>


<script>
	alert("Invalid URL");
	document.location.href="/index.php";
</script>	
<?php
	// echo "Invalid URL ";
	
}

include('../02ui/commonfiles/footer.php');

?>