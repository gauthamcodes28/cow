<?php 
require("../07config/newdbconfig.php");
//order_type is used as to differentiate the ajax call request
error_reporting(E_ALL);
ini_set("display_errors",1);

$mail_username='gauthamr.silumula@chidhagni.com'; //Sets SMTP username
$mail_password='Gautham@28';    //Sets SMTP password
$root=$_SESSION['root'];


if(isset($_POST['order_type']))
{
	if($_POST['order_type']=='viewmedicine')
	{

		$patient_id = $_POST['pid'];
		$v_id = $_POST['visit'];

		$sql="SELECT DISTINCT p.mcode,t.Type_Name FROM patient_medicine p,medicine_type AS t WHERE t.Type_ID=p.Medicine_Type_ID AND  p.Patient_ID LIKE '".$patient_id."' and p.Visit_Number=".$v_id;

		// echo $sql;
		
		$result=mysqli_query($conn,$sql);
		$mcode=array();
		$mtype=array();

		$i=0;
		while($row=mysqli_fetch_assoc($result))
		{
			$mcode[$i]=$row['mcode'];
			$mtype[$i]=$row['Type_Name'];
			$i++;
		}
		$data['code']=$mcode;
		$data['type']=$mtype;
		

		$code=array();
		$tname=array();
		$tid=array();
		$ai=array();
		$g=array();
		$v=array();
		$tn=array();
		$mn=array();
		$bill=array();
		$basic=array();
		$available=array();
		$qnt=array();
		$when=array();
		$how=array();
		$unit=array();
		
		//$s="SELECT * FROM patient_medicine p where p.Patient_ID LIKE '".$patient_id."' and p.Visit_Number=".$v_id;

		$s="select *  from patient_medicine p join medicine m,medicine_type t where p.Patient_ID like '".$patient_id."' and  p.Visit_Number=".$v_id." and p.Medicine_Name=m.Medicine_Name and p.Medicine_Type_ID=t.Type_ID ";
		$r=mysqli_query($conn,$s);

		$i=0;
		while($row=mysqli_fetch_assoc($r))
		{

			$code[$i]=$row['mcode'];
			$ai[$i]=$row['id'];
			$g[$i]=$row['Given'];
			$v[$i]=$row['Visit_Number'];
			$tid[$i]=$row['Type_ID'];
			$tname[$i]=$row['Type_Name'];
			$mn[$i]=$row['Medicine_Name'];
			$bill[$i]=$row['Billable'];
			$basic[$i]=$row['Basic'];
			$available[$i]=$row['Available'];
			$qnt[$i]=$row['Quantity'];
			$when[$i]=$row['Whenval'];
			$how[$i]=$row['How'];
			$unit[$i]=$row['Unit'];
			$i++;
		}

		$val['code']=$code;
		$val['ai']=$ai;
		$val['given']=$g;
		$val['visit']=$v;
		$val['tid']=$tid;
		$val['tname']=$tname;
		$val['mname']=$mn;
		$val['bill']=$bill;
		$val['basic']=$basic;
		$val['available']=$available;
		$val['qnt']=$qnt;
		$val['when']=$when;
		$val['how']=$how;
		$val['unit']=$unit;


		$data['val']=$val;
		

		//getting all medicnnes data
		
		$result=mysqli_query($conn,$sql);

		// echo $sql;
		
		
		

		$options=array();
		$i=0;
		$na=array();
		$mid=array();
		$sql="select * from medicine";
		$result=mysqli_query($conn,$sql);
		while($row=mysqli_fetch_assoc($result))
		{
			$na[$i]=$row['Medicine_Name'];
			$mid[$i]=$row['Medicine_Type_ID'];
			$i++;

		}
		$options['name']=$na;
		$options['id']=$mid;

		$data['options']=$options;

		echo json_encode($data);
	}
	if($_POST['order_type']=='delete_file')
	{
			$val = $_POST["name"];
			$id = $_POST["id"];
			$files = glob('../03patient/docs/EHR1/Reports/*'); // get all file names
			var_dump($files);
		//delete entry in db
	  	$sql="delete  from patient_reports where Patient_ID like '".$id."' and File_Name like '".$val."'";
	  	// echo $sql;
	  	if(mysqli_query($conn,$sql))
	  		echo 'Success';
	  	else
	  		echo 'fail'.mysqli_error($conn);

		foreach($files as $file){ // iterate files
			  if(is_file($file))
			  {

			  

			  
			  	$data=explode("/",$file);
			  	$name = $data[sizeof($data)-1];
			  	if($name==$val)
			  	{
			  		//delete file from folder
			  		unlink($file);


			  	}
			  	// var_dump($data[sizeof($data)-1]);
			  }
			}
	}
	if($_POST['order_type']=='sign_out')
	{
		 session_start();
		    $_SESSION = array();
		    session_destroy();
		    echo 'Session was destroyed';
	}
	if($_POST['order_type']=='login_validate')
	{
		$uname=$_POST['user'];
		$pass=$_POST['pass'];
		//$data["status"]=false;
			$sql="select * from userprofile where Name like '$uname' and Password like '$pass'";
			$result=mysqli_query($conn,$sql);
			if(mysqli_num_rows($result)==0)
			{
				 $data["status"]=false;
			}
			else
			{
				session_start();
				$_SESSION['user_name']=$uname;
				$data["status"]=true;
			}
			echo json_encode($data);
	}
	
	if($_POST['order_type']=='newsave' || $_POST['order_type']=='updatesave' || $_POST['order_type']=='followsave')
	{
		
	//$target_dir = "images/";
	
	//require('fpdf.php');
		$patient_id=$_POST['printpid'];
		$pname=$_POST['pname'];
		$phone=$_POST['phone'];
		
		$dob=$_POST['dob'];
		$gender=$_POST['gender'];
		$location=$_POST['location'];//branch of the hospital
		$age=$_POST['age'];
		$vikruthi=$_POST['vikruthi'];
		$vedapulse=$_POST['vedapulse'];
		$visit=$_POST['visit'];
		$country=$_POST['country'];
		$state=$_POST['state'];
		$ostate=$_POST['ostate'];//get id  of othet state
		//$file=$_FILES["fileToUpload"]["name"];
		$file="";
		$address=$_POST['address'];
		$email=$_POST['email'];
		
		
		//Variables used for inserting data in database
		$state_id="";
		$country_id=$country;
		$country_name="";
		$state_name="";
		$location_id="";
		
		
		
		
		//For Other country
		//sel4 is state,sel3 is country
		if(!empty($ostate))
		{
			$state_id=$ostate;
			$state_name=$ostate;
		
		
		}
		
		
		//For Indian country
		//ostate is ither state means other country
		if(empty($ostate))
		{	

		$state_id=$state;//tg

		}
	if(isset($_FILES['file']['name']))
		$filename=basename($_FILES['file']['name']);
	
	//To retrive the last patient_id entered.
	$checkset=rand();

		if($_POST['order_type']=='newsave')
			{
				$sql="insert into patient_master (Branch_ID,Country_ID,State_ID,Email,DOB,Age,Visit_Number,PName,Phone,Gender,Vikruthi,Veda_Pulse,Profile_Photo,Address,Mode,isdelete,Verified,Time) 
		values ('$location','$country_id','$state_id','$email','$dob','$age',".$visit.",'$pname',$phone,'$gender','$vikruthi','$vedapulse','$filename','$address','offline',$checkset,0,now())";
			}

	else if($_POST['order_type']=='updatesave'){

		if(isset($_FILES['file']['name']))
			{
				$file_flag=true;
				$filename=basename($_FILES['file']['name']);
				$sql="update patient_master set Email='".$email."', Branch_ID='".$location."',Country_ID='".$country_id."',State_ID='".$state_id."',DOB='".$dob."',Age='".$age."',PName='".$pname."',Phone=".$phone.",Gender='".$gender."',Vikruthi='".$vikruthi."',Veda_Pulse='".$vedapulse."',Profile_Photo='".$filename."',Address='".$address."',isdelete=1 where Patient_ID='".$patient_id."'";
			}
			else{
				//check for file exists or not
				$file_flag=false;

				$sql="update patient_master set Email='".$email."', Branch_ID='".$location."',Country_ID='".$country_id."',State_ID='".$state_id."',DOB='".$dob."',Age='".$age."',PName='".$pname."',Phone=".$phone.",Gender='".$gender."',Vikruthi='".$vikruthi."',Veda_Pulse='".$vedapulse."',Address='".$address."',isdelete=1 where Patient_ID='".$patient_id."'";
			
			}

	}
		//echo $sql;
		//echo "<br><br>query <br>".$sql."<br><br>";

	if(mysqli_query($conn,$sql))
	{
		$data["master"]=true;
		$data["flag"]=true;
		//if flag true upload profile pic works

		// echo " insert master true";
	}
	else{
		$data["flag"]=false;
		$data["master"]="master false".mysqli_error($conn);
		// echo "insert master false".mysqli_error($conn);
	}
	/* mysqli_query($conn,$sql);
	
	 */
 
	

		if($_POST['order_type']=='newsave')
		{
		
			//Set Cookie for ViewMode to access id
			setcookie("id",$checkset,time()+300000,"/");
			//Retrive data
			$result=mysqli_query($conn,"select Patient_ID from patient_master where isdelete=".$checkset);
			mysqli_query($conn,"update patient_master set isdelete=1 where isdelete=".$checkset);
			$row2 =mysqli_fetch_assoc($result);
			$patient_id=$row2['Patient_ID'];
			
			//echo "Patient ID is ===".$patient_id;


			//Set Cookie for ViewMode to access id
			setcookie("id",$patient_id,time()+300000,"/");
			
			
			//Profile Pic
			$img = $_POST['image'];
			if(is_dir("../03patient/docs/".$patient_id))
			{}
			else{
				mkdir("../03patient/docs/".$patient_id);	
			}
			
		    $folderPath = "../03patient/docs/".$patient_id;
		  
		    $image_parts = explode(";base64,", $img);
		    $image_type_aux = explode("image/", $image_parts[0]);
		    $image_type = $image_type_aux[1];
		  
		    $image_base64 = base64_decode($image_parts[1]);
		    $fileName = uniqid() . '.png';
		  
		    $file = $folderPath . $fileName;
		    if(file_put_contents($file, $image_base64)){
		    	$data["profile"]="success";
		    }
		    else{
		    	$data["profile"]="failure";
		    }
		  
		    // print_r($fileName);


			//Make Directory of ID NAmed
			
			// $uploaddir = '../03patient/docs/'.$patient_id.'/';
			// $uploadfile = $uploaddir . basename($_FILES['file']['name']);

			// if (move_uploaded_file($_FILES['file']['tmp_name'], $uploadfile)) {
			// 	$data["file"]="valid file";
			//   // echo "File is valid, and was successfully uploaded.\n";
			// } else {
			// 	$data["file"]="Upload failed";

			//    // echo "Upload failed";
			// }


		}


	/* move_uploaded_file($_FILES['file']['tmp_name'], $uploadfile);
	 */
	
		//Medicine Details Entry
		$ai_val=$_POST['ai'];
		$ty=$_POST['type_name'];
		$cd=$_POST['code'];
		$bill=$_POST['billable'];
		$n=$_POST['selectname'];
		$give=$_POST['given'];
		$avai=$_POST['available'];
		$bas=$_POST['basic'];
		$qty=$_POST['quantity'];
		$when=$_POST['whenval'];
		$hw=$_POST['how'];
		
		$ai=explode(",", $ai_val);
		$type=explode(",",$ty);
		$code=explode(",", $cd);
		$billable=explode(",",$bill);
		$name=explode(",",$n);
		$given=explode(",",$give);
		$available=explode(",",$avai);
		$basic=explode(",",$bas);
		$quantity=explode(",",$qty);
		$whenval=explode(",",$when);
		$how=explode(",",$hw);
		
		$val=array();

		//echo $ty.$bill.$n.$give.$avai.$when.$hw;
		for($i=0;$i<sizeof($type);$i++){
			$sql2="select Type_ID from medicine_type where Type_Name like '".$type[$i]."'";
			// echo $sql2;
			$result2=mysqli_query($conn,$sql2);
			$row2=mysqli_fetch_assoc($result2);

			if($_POST['order_type']=='newsave')
			{
				$sql="CALL patient_medicine_data('$patient_id',".$visit.",".$row2['Type_ID'].",'".$name[$i]."','".$billable[$i]."','".$given[$i]."','".$quantity[$i]."','".$whenval[$i]."','".$how[$i]."','new',0,".$code[$i].");";
			}
			else if($_POST['order_type']=='updatesave')
			{
				if(empty($ai[$i]))
				{
					$sql="CALL patient_medicine_data('$patient_id',".$visit.",".$row2['Type_ID'].",'".$name[$i]."','".$billable[$i]."','".$given[$i]."','".$quantity[$i]."','".$whenval[$i]."','".$how[$i]."','new',0,".$code[$i].");";
				}
				else
				{
				$sql="CALL patient_medicine_data('$patient_id',".$visit.",".$row2['Type_ID'].",'".$name[$i]."','".$billable[$i]."','".$given[$i]."','".$quantity[$i]."','".$whenval[$i]."','".$how[$i]."','update',".$ai[$i].",".$code[$i].");";
				}
			}
				
				// echo $sql;
				if(mysqli_query($conn,$sql))
				{
					// echo "success";
					$val[$i]="success medicine".$type[$i];
				}
				else{
					$val[$i]=$type[$i]."fail:".mysqli_error($conn);
					// echo "Failed:  ".mysqli_error($conn);
				}
				/* mysqli_query($conn,$sql); */
		}

		$data["medicine"]=$val;

//Medicine Details Entry END		

//Problem Description
$problem=$_POST['problem'];
$mod=$_POST['mod'];
$ayur=$_POST['ayur'];

if($_POST['order_type']=='newsave')
{
$sql="insert into patient_problem (Patient_ID,Visit_Number,PDescription,Ayurvedic,Modern)
 values ('".$patient_id."',".$visit.",\"".$problem."\",\"".$ayur."\",\"".$mod."\")";
}
else if($_POST['order_type']=='updatesave')
{
	$sql="update patient_problem set Visit_Number='".$visit."',PDescription='".$problem."',Ayurvedic='".$ayur."',Modern='".$mod."' where Patient_ID='".$patient_id."' and Visit_Number='".$visit."'";	
}


 if(mysqli_query($conn,$sql)){
 	// echo "Problem success";
 	$data["problem"]="success";
 }
	
else{
	$data["problem"]="fail:".mysqli_error($conn);
	// echo "problem Fail: ".mysqli_error($conn);
}

/*  mysqli_query($conn,$sql);
  */
//Instructions Data
$dan=$_POST['dan'];
$pan=$_POST['pan'];
$inst=$_POST['inst'];
$yoga=$_POST['yoga'];
$stop=$_POST['stop'];
$start=$_POST['start'];
$other1=$_POST['other1'];
$other2=$_POST['other2'];
//$pan="Pan Details";
$day=Date("Y/m/d");


if($_POST['order_type']=='newsave')
{
$sql="insert into patient_instruction (Patient_ID,Visit_Number,Branch_ID,Visit_Date,Dantmanjan,Panchakarma,yoga,Instructions,Stop,Start,Other1,Other2)
 values ('".$patient_id."',".$visit.",\"".$location."\",\"".$day."\",\"".$dan."\",\"".$pan."\",\"".$yoga."\",\"".$inst."\",\"".$stop."\",\"".$start."\",\"".$other1."\",\"".$other2."\")";
}
else if($_POST['order_type']=='updatesave')
{
$sql="update patient_instruction set Visit_Number='".$visit."',Branch_ID='".$location."',Visit_Date='".$day."',Dantmanjan='".$dan."',Panchakarma='".$pan."',yoga='".$yoga."',Instructions='".$inst."',Stop='".$stop."',Start='".$start."',Other1='".$other1."',Other2='".$other2."' where Patient_ID='".$patient_id."' and Visit_Number='".$visit."'";
}

 if(mysqli_query($conn,$sql)){
 	// echo "instructions success";
 	$data["instruction"]="success";
 }
else{
	$data["instruction"]="Fail: ".mysqli_error($conn);
}
	
	/* mysqli_query($conn,$sql); */
	$data["patient_id"]=$patient_id;
	$data["order_type"]=$_POST['order_type'];

	echo json_encode($data);
	
}//end of save type


	
	if($_POST['order_type']=='searchexistingquery')
	{
		
$spid=$_POST['spid'];
$name=$_POST['pname'];
$dob=$_POST['dob'];
$phone=$_POST['phone'];
$location=$_POST['location'];

	$sql="select * from patient_master where isdelete=0 ";
	if($name!=""){
	$sql .= " and PName like '%$name%'";	
	}
	if($dob!=""){
	$sql .= " and DOB='$dob'";	
	}
	if($spid!=""){
	$sql .= " and Patient_ID='$spid'";	
	}
	if($phone!=""){
	$sql .= " and Phone=$phone";	
	}
	if($location!=""){
	$sql .= " and Branch_ID='$location'";	
	}
	
	//$sql .="  order by substring(Patient_ID,4,6)*1 ";
	
	//echo $sql;
	/*
	if($mod1!=""){
	$que="select * from moderntablets where modname='$mod1'";
	$res=mysqli_query($conn,$que);
	$mod2=mysqli_fetch_assoc($res);
	$sql .= " and modid='".$mod2['modid']."'";
	}
	*/
$result= mysqli_query($conn,$sql);
if(!mysqli_num_rows($result)==0)
	$state_id="";
	while($row=mysqli_fetch_assoc($result)){
		//For Country Name
		$temp=$row['Country_ID'];
		$sql1="select Country_Name from country where Country_ID='$temp'";
		$result1=mysqli_query($conn,$sql1);
		$row1=mysqli_fetch_assoc($result1);
		
		
		
		
		//For State Name
		$temp=$row['State_ID'];
		$sql1="select State_Name from state where State_ID='$temp'";
		$result1=mysqli_query($conn,$sql1);
		$row2=mysqli_fetch_assoc($result1);
		$state_id=$row2['State_Name'];
		
		if($row['Country_ID']=="out")
		$state_id=$row['State_ID'];
		
		
		echo '
		<tr><td class="view_id">'.$row['Patient_ID'].'</td><td style="color:red;"><a class="query_id">'.$row['PName'].'</a></td><td>'.$row['Phone'].'</td><td>'.$row['Age'].'</td>
		<td>'.$row1['Country_Name'].'</td><td>'.$state_id.'</td><td class="mode">'.$row['Mode'].'</td></tr>';
		}
	}//end of search existing order
	if($_POST['order_type']=='searchexisting')
	{
		
$spid=$_POST['spid'];
$name=$_POST['pname'];
$dob=$_POST['dob'];
$phone=$_POST['phone'];
$location=$_POST['location'];
$mode=$_POST['mode'];

	$sql="select * from patient_master where isdelete>0 ";
	if($name!=""){
	$sql .= " and PName like '%$name%'";	
	}
	if($dob!=""){
	$sql .= " and DOB='$dob'";	
	}
	if($spid!=""){
	$sql .= " and Patient_ID='$spid'";	
	}
	if($phone!=""){
	$sql .= " and Phone=$phone";	
	}
	if($location!=""){
	$sql .= " and Branch_ID='$location'";	
	}
	if($mode!=""){
	$sql .= " and Mode like '$mode'";	
	}
	//$sql .="  order by substring(Patient_ID,4,6)*1 ";
	
	//echo $sql;
	/*
	if($mod1!=""){
	$que="select * from moderntablets where modname='$mod1'";
	$res=mysqli_query($conn,$que);
	$mod2=mysqli_fetch_assoc($res);
	$sql .= " and modid='".$mod2['modid']."'";
	}
	*/
$result= mysqli_query($conn,$sql);
if(!mysqli_num_rows($result)==0)
	$state_id="";
	while($row=mysqli_fetch_assoc($result)){
		//For Country Name
		$temp=$row['Country_ID'];
		$sql1="select Country_Name from country where Country_ID='$temp'";
		$result1=mysqli_query($conn,$sql1);
		$row1=mysqli_fetch_assoc($result1);
		
		
		
		
		//For State Name
		$temp=$row['State_ID'];
		$sql1="select State_Name from state where State_ID='$temp'";
		$result1=mysqli_query($conn,$sql1);
		$row2=mysqli_fetch_assoc($result1);
		$state_id=$row2['State_Name'];
		
		if($row['Country_ID']=="out")
		$state_id=$row['State_ID'];
		
		
		echo '
		<tr><td class="view_id">'.$row['Patient_ID'].'</td><td style="color:red;"><a class="name_anchor">'.$row['PName'].'</a></td><td>'.$row['Phone'].'</td><td>'.$row['Age'].'</td>
		<td>'.$row1['Country_Name'].'</td><td>'.$state_id.'</td><td class="mode">'.$row['Mode'].'</td></tr>';
		}
	}//end of searchexistingquery order
	
	
	if($_POST['order_type']=='viewmodeexisting')
	{
		
		
		$id=$_POST['patient_id'];
		$visit=$_POST['visit_number'];
		
		//Patient Details
		//echo "New Mode".$id;
		$sql="select * from patient_master where Patient_ID='".$id."'";
		$result=mysqli_query($conn,$sql);
		$row=mysqli_fetch_assoc($result);
		$data["patientid"]= utf8_encode ($row['Patient_ID']);
		$data["branchid"]=utf8_encode ($row['Branch_ID']);
		$data["countryid"]=utf8_encode ($row['Country_ID']);
		$data["stateid"]=utf8_encode ($row['State_ID']);
		$data["email"]=utf8_encode ($row["Email"]);
		$data["dob"]=utf8_encode ($row['DOB']);
		$data["age"]=utf8_encode ($row['Age']);
		$data["pname"]=utf8_encode ($row['PName']);
		$data["visit_number"]=utf8_encode ($row['Visit_Number']);
		$data["phone"]=utf8_encode ($row['Phone']);
		$data["gender"]=utf8_encode ($row['Gender']);
		$data["vikruthi"]=utf8_encode ($row['Vikruthi']);
		$data["vedapulse"]=utf8_encode ($row['Veda_Pulse']);
		$data["profilephoto"]=utf8_encode ($row['Profile_Photo']);
		$data["address"]=utf8_encode ($row['Address']);
		$data["mode"]=utf8_encode ($row['Mode']);
		
		//PROBLEM DESC data
		$sql2="select * from patient_problem where Patient_ID='".$id."' and Visit_Number=".$visit;
		$result=mysqli_query($conn,$sql2);
		$row=mysqli_fetch_assoc($result);
		
		$data["pdescription"]=utf8_encode ($row['PDescription']);
		$data["ayurvedic"]=utf8_encode ($row['Ayurvedic']);
		$data["modern"]=utf8_encode ($row['Modern']);
		
		//instruction data
		$sql1="select * from patient_instruction where Patient_ID='".$id."' and Visit_Number=".$visit;
		$result=mysqli_query($conn,$sql1);
		$row=mysqli_fetch_assoc($result);
		
		$data["visitdate"]=utf8_encode ($row['Visit_Date']);
		$data["dantmanjan"]=utf8_encode ($row['Dantmanjan']);
		$data["panchakarma"]=utf8_encode ($row['Panchakarma']);
		$data["yoga"]=utf8_encode ($row['Yoga']);
		$data["instructions"]=utf8_encode ($row['Instructions']);
		$data["stop"]=utf8_encode ($row['Stop']);
		$data["start"]=utf8_encode ($row['Start']);
		$data["other1"]=utf8_encode ($row['Other1']);
		
		//Reports data
		$sql2="select * from patient_reports where Patient_ID='".$id."' order by Visit";
		$result2=mysqli_query($conn,$sql2);
		
		$reports=array();
		$i=0;
		if(!mysqli_num_rows($result2)==0)
		{
		while($row2=mysqli_fetch_assoc($result2))
		{
			$reports["name"][$i]=utf8_encode ($row2['File_Name']);
			$reports["visit"][$i]=utf8_encode ($row2['Visit']);
			$reports["date"][$i]=utf8_encode ($row2['Date']);
			$i+=1;
		}
		$data["reports"]=$reports;
		}
		$data["id"]=$id;
		//print_r($data);
		echo json_encode($data);
		
	}
	

	
	if($_POST['order_type']=='setvisit')
	{
		
		$id=$_POST['patient_id'];
		$sql="select Visit_Number from patient_master where Patient_ID like '".$id."' ";
		$result=mysqli_query($conn,$sql);
		$row=mysqli_fetch_assoc($result);
		$data["visit"]=$row['Visit_Number'];
		echo json_encode($data);
	}
	
	if($_POST['order_type']=='followsave')
	{
 		$target_dir = "images/";
		
		$patient_id=$_POST['followid'];
		$pname=$_POST['pname'];
		$phone=$_POST['phone'];
		$dob=$_POST['dob'];
		$gender=$_POST['gender'];
		$location=$_POST['location'];//branch of the hospital
		$age=$_POST['age'];
		$vikruthi=$_POST['vikruthi'];
		$vedapulse=$_POST['vedapulse'];
		$visit=$_POST['visit'];
		$country=$_POST['country'];
		$state=$_POST['state'];
		$ostate=$_POST['ostate'];//get id  of othet state
		//$file=$_FILES["fileToUpload"]["name"];
		$file="";
		$address=$_POST['address'];
		$email=$_POST['email'];
		
		
		//Variables used for inserting data in database
		$state_id="";
		$country_id=$country;
		$country_name="";
		$state_name="";
		$location_id="";
		
		
		
		
		//For Other country
		//sel4 is state,sel3 is country
		if(!empty($ostate))
		{
			$state_id=$ostate;
			$state_name=$ostate;
		
		
		}
		
		
		//For Indian country
		//ostate is ither state means other country
		if(empty($ostate))
		{	

		$state_id=$state;//tg

		}
	if(isset($_FILES['file']['name']))	
	{
		$filename=basename($_FILES['file']['name']);
		$sql="update patient_master set  Email='".$email."', Visit_Number=".$visit.", Branch_ID='".$location."',Country_ID='".$country_id."',State_ID='".$state_id."',DOB='".$dob."',Age='".$age."',PName='".$pname."',Phone=".$phone.",Gender='".$gender."',Vikruthi='".$vikruthi."',Veda_Pulse='".$vedapulse."',Profile_Photo='".$filename."',Address='".$address."' where Patient_ID='".$patient_id."'";
	}
	else{
		$sql="update patient_master set  Email='".$email."', Visit_Number=".$visit.", Branch_ID='".$location."',Country_ID='".$country_id."',State_ID='".$state_id."',DOB='".$dob."',Age='".$age."',PName='".$pname."',Phone=".$phone.",Gender='".$gender."',Vikruthi='".$vikruthi."',Veda_Pulse='".$vedapulse."',Address='".$address."' where Patient_ID='".$patient_id."'";
	
	}

		//echo "<br><br>query <br>".$sql."<br><br>";

	$result=mysqli_query($conn,$sql);
//End of Patient Data Updation



		
		$visit=$_POST['visit'];

		
		
//Medicine Details Entry

		$ty=$_POST['type_name'];
		$bill=$_POST['billable'];
		$n=$_POST['selectname'];
		$give=$_POST['given'];
		$avai=$_POST['available'];
		$bas=$_POST['basic'];
		$qty=$_POST['quantity'];
		$when=$_POST['whenval'];
		$hw=$_POST['how'];
		
		$type=explode(",",$ty);
		$billable=explode(",",$bill);
		$name=explode(",",$n);
		$given=explode(",",$give);
		$available=explode(",",$avai);
		$basic=explode(",",$bas);
		$quantity=explode(",",$qty);
		$whenval=explode(",",$when);
		$how=explode(",",$hw);
		
		//echo $ty.$bill.$n.$give.$avai.$when.$hw;
		for($i=0;$i<sizeof($type);$i++){
			$sql2="select Type_ID from medicine_type where Type_Name like '".$type[$i]."'";
			echo $sql2;
			$result2=mysqli_query($conn,$sql2);
			$row2=mysqli_fetch_assoc($result2);
				$sql="CALL patient_medicine_data('$patient_id',".$visit.",".$row2['Type_ID'].",'".$name[$i]."','".$billable[$i]."','".$given[$i]."','".$quantity[$i]."','".$whenval[$i]."','".$how[$i]."','new',0);";
				if(mysqli_query($conn,$sql))
				{
					echo "success";
				}
				else
					echo "Failed:  ".mysqli_error($conn);
				/* mysqli_query($conn,$sql); */
		}

//Medicine Details Entry END			
		

//Problem Description
$problem=$_POST['problem'];
$mod=$_POST['mod'];
$ayur=$_POST['ayur'];
$sql="insert into patient_problem (Patient_ID,Visit_Number,PDescription,Ayurvedic,Modern)
 values ('".$patient_id."',".$visit.",\"".$problem."\",\"".$ayur."\",\"".$mod."\")";
mysqli_query($conn,$sql);
 /* if(mysqli_query($conn,$sql))
	echo "problem success";
else
	echo "Fail: ".mysqli_error($conn); */


//Instructions Data
$dan=$_POST['dan'];
$pan=$_POST['pan'];
$inst=$_POST['inst'];
$yoga=$_POST['yoga'];
$stop=$_POST['stop'];
$start=$_POST['start'];
$other1=$_POST['other1'];
$other2=$_POST['other2'];

//Branch_ID retriving from master table
$sql="select Branch_ID from patient_master where Patient_ID='".$patient_id."'";
$result=mysqli_query($conn,$sql);
$row=mysqli_fetch_assoc($result);
$location=$row['Branch_ID'];
$day=Date("Y/m/d");
$sql="insert into patient_instruction (Patient_ID,Visit_Number,Branch_ID,Visit_Date,Dantmanjan,Panchakarma,yoga,Instructions,Stop,Start,Other1,Other2)
 values ('".$patient_id."',".$visit.",\"".$location."\",\"".$day."\",\"".$dan."\",\"".$pan."\",\"".$yoga."\",\"".$inst."\",\"".$stop."\",\"".$start."\",\"".$other1."\",\"".$other2."\")";
mysqli_query($conn,$sql);
/* 
 if(mysqli_query($conn,$sql))
	echo "instructions success";
else
	echo "Fail: ".mysqli_error($conn);
 */
	}//end of followsave
	
	if($_POST['order_type']=='uploadfiles')
	{
		$visit=$_POST['files_visit'];
		$patient_id=$_POST['files_id'];
		
		$file_list=array();
		$cnt=0;
		$round=0;
		//Upload.php
		if(is_array($_FILES))
		{
			$i=0;
			$j=0;
			$dir="../03patient/docs/".$patient_id."/Reports";
			if(!file_exists($dir))//Make Directory of ID NAmed
			mkdir("../03patient/docs/".$patient_id."/Reports");

			foreach($_FILES['images']['name'] as $name=> $value)
			{
				//To test the number of rounds turned
				$round++;
				
				$file_name=$_FILES['images']['name'][$name];
				$allowed_extension = array("jpg","jpeg","png","gif");
				/* if(in_array($file_name[1],$allowed_extension))
				{ */
					$new_name=$file_name;

					$sourcePath = $_FILES["images"]["tmp_name"][$name];
					$targetPath = "../03patient/docs/".$patient_id."/Reports/".$new_name;
					if(move_uploaded_file($sourcePath, $targetPath))
					{
						//echo "success";
						$file_list[$cnt]=$file_name;
						$cnt++;
						$i++;
					}
					else
					{
						//echo "Fail";
						echo $_FILES['images']['error'][$name];
						$j++;
					}
				/* } */
			}
			echo "Success ".$i." and  Fail ".$j."  Rounds turned is ".$round;
			foreach($file_list as $n)
			{
				$date=date("Y-m-d");
				$sql="insert into patient_reports (Patient_ID,File_Name,Visit,Date) values ('".$patient_id."','".$n."','".$visit."','$date');";
				mysqli_query($conn,$sql);
			}

		}
	}//end of uploadfiles 

	if($_POST['order_type']=='stock_row')
	{
		$name=$_POST['name'];

		echo '<tr class="form-group" id="#'.$name.'row">
					<td><input class="checkbox editable  ads_Checkbox" type="checkbox" name="type_checked"/></td>
					<td class="form-group type_td"><label name="type_name" class="control-label">'.$name.'</label></td>
					<td class="select_td">
						<select class="form-control editable select_name">';
			
							//To get the type id
							$sql1="select Type_ID from medicine_type where Type_Name='$name'";
							$result=mysqli_query($conn,$sql1);
							$row1=mysqli_fetch_assoc($result);
							
							//To get the medicines of that type
							$sql2="select Medicine_Name from medicine where Medicine_Type_ID=".$row1["Type_ID"];
							$result=mysqli_query($conn,$sql2);
							echo "<option selected disabled value=\"\">select name</option>";
							while($row2=mysqli_fetch_assoc($result)){
								
								echo "<option>".$row2["Medicine_Name"]."</option>";
							}
						
					echo	'</select>
					</td>
					<td class="net_td">
					<input class="netcontents editable"  type="text" disabled value="" placeholder="">
					</td>
					<td class="multiple_td">
					<input type="number" placeholder="multiple" class="editable" />
					</td>
					<td class="amount_td"><input class="amount editable"  type="text" value="" placeholder="Amount"></td>
					</tr>';  
	}
	
	if($_POST['order_type']=='stock_insert')
	{
		 $typename=explode(",",$_POST['typeval']);//Ark
		 $name=explode(",",$_POST['nameval']);//ALovera
		 $amount=explode(",",$_POST['amountval']);//400
		 $net=explode(",",$_POST['netcontet']);
		 $username=$_POST['username'];//Session Created Username
		 
		 for($i=0;$i<count($name);$i++)
		 {
			
			 //Just for testing Procedure defined for inserting the data
			  $sql="call stock_update('".$typename[$i]."','".$name[$i]."','credit',".$amount[$i].",'".$username."')";
			 if(mysqli_query($conn,$sql))
				 echo "success".$i;
			 else
				 echo "fail".$i; 
			 
		 }
	}
	
	if($_POST['order_type']=='credit_history')
	{
		$sql="select * from stock_transaction where Typeval='credit' order by Timeval desc";
		//echo $sql;
		$result= mysqli_query($conn,$sql);
		while($row=mysqli_fetch_assoc($result)){
			echo '
			<tr><td>'.$row['Type_Name'].'</td><td>'.$row['Medicine_Name'].'</td><td>'.$row['Typeval'].'</td><td>'.$row['Amount'].'</td><td>'.$row['Updated_By'].'</td><td>'.$row['Timeval'].'</td></tr>';
			
		}
	}
	
	if($_POST['order_type']=='debit_history')
	{
		$sql="select * from stock_transaction where Typeval='debit' order by Timeval desc";
		$result= mysqli_query($conn,$sql);
		while($row=mysqli_fetch_assoc($result)){
			echo '<tr><td>'.$row['Updated_By'].'</td><td>'.$row['Type_Name'].'</td><td>'.$row['Medicine_Name'].'</td><td>'.$row['Amount'].'</td><td>'.$row['Timeval'].'</td></tr>';
			
		}
	}
	
	if($_POST['order_type']=='stock_available')
	{
		$sql="select s.Medicine_Name,s.Available,t.Type_Name,m.Basic,m.Unit,m.Net_Content,m.Package_Weight from stock_master s, medicine m,medicine_type t where s.Medicine_Name=m.Medicine_Name and m.Medicine_Type_ID=t.Type_ID;";
		$result= mysqli_query($conn,$sql);
			while($row=mysqli_fetch_assoc($result)){
					
			echo '<tr><td>'.$row['Type_Name'].'</td><td>'.$row['Medicine_Name'].'</td><td>'.$row['Basic'].$row['Unit'].'</td><td>'.$row['Package_Weight'].'grms</td><td>'.$row['Net_Content'].$row['Unit'].'</td><td>'.$row['Available'].$row['Unit'].'</td></tr>';
			
			}
	}
	
	if($_POST['order_type']=='medicine_data')
	{
		$mdata=array();
		$id=$_POST['id'];
		$visit=$_POST['visit'];
		$i=0;
		$sql="select t.Type_Name,p.Medicine_Name,p.Billable,p.Given,p.Quantity,p.Whenval,p.How from patient_medicine p join medicine_type t where t.Type_ID=p.Medicine_Type_ID AND p.Patient_ID like '".$id."' and p.Visit_Number=".$visit."";
		//echo $sql;
		$result=mysqli_query($conn,$sql);
		while($row=mysqli_fetch_assoc($result))
		{
			$mdata["type"][$i]=$row['Type_Name'];
			$mdata["mname"][$i]=$row['Medicine_Name'];
			$mdata["billable"][$i]=$row['Billable'];
			$mdata["given"][$i]=$row['Given'];
			$mdata["quantity"][$i]=$row['Quantity'];
			$mdata["whenval"][$i]=$row['Whenval'];
			$mdata["how"][$i]=$row['How'];
			$i+=1;
		}
		//echo "Hello World";
		echo json_encode($mdata);
	}
	
	if($_POST['order_type']=='new_type_row')
	{
		$data=array();
		$name=$_POST['name'];
		$vals=json_decode(file_get_contents("../03patient/json/medicine_types.json"));
		foreach($vals as $val)
		{
			if($name==$val->name)
			{
				//print_r($val->options);
				$data=$val->options;
				//print_r($data);
			}
				
		}
		echo json_encode($data);
	}
	
	if($_POST['order_type']=="plus_sign_add")
	{
		$name=$_POST['subname'];
		$str = trim(preg_replace('/\s+/',' ', $name)); 
		echo $str;
		$temp='';
	$temp.='<tr>';
				$temp.='<td class="ai_td" style="display:none;"> <input type="number" value="0" class="ai"></td>';
					$temp.='		<td  class="billable_td"><input class="editable form-control" type="checkbox" style="width:20px;" /></td>';
					$temp.='		<td class="name_td">';
					$temp.='		<select class="form-control editable select_name">';
				//To get the type id
				$sql1="select Type_ID from medicine_type where Type_Name like '$str'";
				echo $sql1;
				//$temp.= $sql1;
				$result=mysqli_query($conn,$sql1);
				$row1=mysqli_fetch_assoc($result);
				//echo "Type_ID".$row1['Type_ID'];
				
				//To get the medicines of that type
				$sql2="select Medicine_Name from medicine where Medicine_Type_ID='".$row1["Type_ID"]."'"; 
				echo $sql2;
				//$temp.=$sql2;
				$result=mysqli_query($conn,$sql2);
				$temp.= '<option selected disabled>select</option>';
				while($row2=mysqli_fetch_assoc($result)){
					
					$temp.= '<option>'.$row2["Medicine_Name"].'</option>';
				}
					$temp.='		</select>';
					$temp.='		</td>';
					$temp.='		<td class="given_td"><input class="form-control editable" style="width:100px"  type="number" value="" placeholder="xBasic" step=""/></td>';
					$temp.='		<td class="available_td"><input class="form-control editable" style="width:100px"  type="text" value="" placeholder="Available" disabled/></td>';
					$temp.='		<td class="basic_td"><input class="form-control editable" style="width:80px"   type="text" value="" placeholder="Basic" disabled/></td>';
					$temp.='		<td><a class="delete_inside_row">  <span class="glyphicon glyphicon-remove-sign"></span></a></td>';
					$temp.='</tr>';

					echo $temp;
	}
	
	if($_POST['order_type']=="stock_update_select")
	{
		$name=$_POST['name'];
		$type=$_POST['type'];
		$raw=file_get_contents("../03patient/json/data.json");
		$data=json_decode($raw);
		//print_r($data);
		foreach($data as $val)
		{
			//print_r($val);
			if($val->Type_Name=$type && $val->Medicine_Name==$name)
			{
				$set=array(
				"net" => $val->Net_Content,
				"basic" => $val->Basic,
				"unit" =>$val->Unit
				);
				
				echo json_encode($set);
			}
				
		}
		
		
	}
	
	if($_POST['order_type']=="select_tag_name")
	{
		$name=$_POST['name'];
		//echo $name;
		//echo 'testing...';
		$raw=file_get_contents("../03patient/json/data.json");
		$data=json_decode($raw);
		//print_r($data);
		foreach($data as $val)
		{
			//print_r($val);
			if($val->Medicine_Name==$name)
			{
				$set=array(
				"net" => $val->Net_Content,
				"basic" => $val->Basic,
				"unit" =>$val->Unit,
				"available" =>$val->Available
				);
				
				echo json_encode($set);
			}
				
		}
	}
	
	if($_POST['order_type']=="online_save")
	{
		$pname=$_POST['pname'];
		$phone=$_POST['phone'];
		
		$dob=$_POST['dob'];
		$gender=$_POST['gender'];
		$location=$_POST['location'];//branch of the hospital
		$age=$_POST['age'];
		$vikruthi=$_POST['vikruthi'];
		$vedapulse=$_POST['vedapulse'];
		$visit=$_POST['visit'];
		$country=$_POST['country'];
		$state=$_POST['state'];
		$ostate=$_POST['ostate'];//get id  of othet state
		//$file=$_FILES["fileToUpload"]["name"];
		$file="";
		$address=$_POST['address'];
		$email=$_POST['email'];
		
		
		//Variables used for inserting data in database
		$state_id="";
		$country_id=$country;
		$country_name="";
		$state_name="";
		$location_id="";
		
		
		
		
		//For Other country
		//sel4 is state,sel3 is country
		if(!empty($ostate))
		{
			$state_id=$ostate;
			$state_name=$ostate;
		
		
		}
		
		
		//For Indian country
		//ostate is ither state means other country
		if(empty($ostate))
		{	

		$state_id=$state;//tg

		}
		$checkset=rand();
		$filename=basename($_FILES['file']['name']);
	
		$sql="insert into patient_master (Branch_ID,Country_ID,State_ID,Email,DOB,Age,Visit_Number,PName,Phone,Gender,Vikruthi,Veda_Pulse,Profile_Photo,Address,Mode,isdelete,Time) 
		values ('$location','$country_id','$state_id','$email','$dob','$age',".$visit.",'$pname',$phone,'$gender','$vikruthi','$vedapulse','$filename','$address','online',$checkset,now())";

		//echo "<br><br>query <br>".$sql."<br><br>";

	if(mysqli_query($conn,$sql))
		echo " insert master true";
	else
		echo "insert master false".mysqli_error($conn);
	/* mysqli_query($conn,$sql);
	
	 */
 
	
	
//Set Cookie for ViewMode to access id
setcookie("id",$checkset,time()+300000,"/");

//Retrive data
	
	$result=mysqli_query($conn,"select Patient_ID from patient_master where isdelete=".$checkset);
	mysqli_query($conn,"update patient_master set isdelete=0 where isdelete=".$checkset);
	$row2 =mysqli_fetch_assoc($result);
	$patient_id=$row2['Patient_ID'];
	
	//echo "Patient ID is ===".$patient_id;


//Set Cookie for ViewMode to access id
setcookie("id",$patient_id,time()+300000,"/");

	//Make Directory of ID NAmed
	mkdir("../03patient/docs/".$patient_id);	
	$uploaddir = '../03patient/docs/'.$patient_id.'/';
	$uploadfile = $uploaddir . basename($_FILES['file']['name']);
	
	if (move_uploaded_file($_FILES['file']['tmp_name'], $uploadfile)) {
	  echo "File is valid, and was successfully uploaded.\n";
	} else {
	   echo "Upload failed";
	}
	
	//Problem Description
		$problem=$_POST['problem'].$_POST['diseases'];
		$mod=$_POST['mod'];
		$ayur=$_POST['ayur'];
		//$diseases=$_POST['diseases'];
		
		$sql="insert into patient_problem (Patient_ID,Visit_Number,PDescription,Ayurvedic,Modern)
		 values ('".$patient_id."',".$visit.",\"".$problem."\",\"".$ayur."\",\"".$mod."\")";

		 if(mysqli_query($conn,$sql))
			echo "Problem success";
		else
			echo "problem Fail: ".mysqli_error($conn);


$code=rand();
$sql="update patient_master set Verified=".$code." where Patient_ID like '".$patient_id."'";
mysqli_query($conn,$sql);


        $subject="Confirmation Link";
        $message="Click on the link to activate".$root."08common/confirm.php?id='".$patient_id."'&code=".$code;
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
	
	}//end of online_save
	
	if($_POST['order_type']=="online_patient_view")
	{
		$id=$_POST['patient_id'];
		$visit=$_POST['visit_number'];
		
		//Patient Details
		//echo "New Mode".$id;
		$sql="select * from patient_master where Patient_ID='".$id."'";
		$result=mysqli_query($conn,$sql);
		$row=mysqli_fetch_assoc($result);
		$data["patientid"]=$row['Patient_ID'];
		$data["branchid"]=$row['Branch_ID'];
		$data["countryid"]=$row['Country_ID'];
		$data["stateid"]=$row['State_ID'];
		$data["dob"]=$row['DOB'];
		$data["age"]=$row['Age'];
		$data["pname"]=$row['PName'];
		$data["visit_number"]=$row['Visit_Number'];
		$data["phone"]=$row['Phone'];
		$data["gender"]=$row['Gender'];
		$data["vikruthi"]=$row['Vikruthi'];
		$data["vedapulse"]=$row['Veda_Pulse'];
		$data["profilephoto"]=$row['Profile_Photo'];
		$data["address"]=$row['Address'];
		$data["mode"]=$row['Mode'];
		$data["email"]=$row['Email'];
		
		//PROBLEM DESC data
		$sql2="select * from patient_problem where Patient_ID='".$id."' and Visit_Number=".$visit;
		$result=mysqli_query($conn,$sql2);
		$row=mysqli_fetch_assoc($result);
		
		$data["pdescription"]=$row['PDescription'];
		$data["ayurvedic"]=$row['Ayurvedic'];
		$data["modern"]=$row['Modern'];
		
		
		//Reports data
		$sql2="select * from patient_reports where Patient_ID='".$id."' order by Visit";
		$result2=mysqli_query($conn,$sql2);
		
		$reports=array();
		$i=0;
		if(!mysqli_num_rows($result2)==0)
		{
		while($row2=mysqli_fetch_assoc($result2))
		{
			$reports["name"][$i]=$row2['File_Name'];
			$reports["visit"][$i]=$row2['Visit'];
			$reports["date"][$i]=$row2['Date'];
			$i+=1;
		}
		$data["reports"]=$reports;
		}
		echo json_encode($data);
		
	}
	
	if($_POST['order_type']=="deduct_medicines")
	{
		$id=$_POST['patient_id'];
		$visit=$_POST['visit'];
		
		//All details
		$sql="select * from patient_medicine where Patient_ID like '".$id."' and Visit_Number=".$visit;
		$result=mysqli_query($conn,$sql);
	
		
		while($row=mysqli_fetch_assoc($result))
		{
			if($row['Billable']=='yes')
			{
				//Type_Name
				$sql="select Type_Name from medicine_type where Type_ID=".$row['Medicine_Type_ID'];
				$result2=mysqli_query($conn,$sql);
				$row2=mysqli_fetch_assoc($result2);
				$tname=$row2['Type_Name'];
				$mname=$row['Medicine_Name'];
				
				$amount=$row['Given'];
				
				$sql="select * from medicine where Medicine_Name like '".$mname."'";
				$result4=mysqli_query($conn,$sql);
				$row4=mysqli_fetch_assoc($result4);
				$unit=$row4['Unit'];
				
				//Precedure call
				$sql='call stock_update("'.$tname.'","'.$mname.'","debit",'.$amount.',"'.$id.'");';
				
				if(mysqli_query($conn,$sql))
				{
					echo 'Success:';
				}
					
				else
				{
					echo 'Fail:';
				}
					
			}
		}
		
		$data["status"]="success";
		echo json_encode($data);
	}

	if($_POST['order_type']=="contact_details")
	{
			//email the form to yourself
		$from=$_POST['from_address'];
		$sub=$_POST['subject'];
		$mess=$_POST['message'];
		$name=$_POST['name'];
		$sql="insert into contact_form (Email,Name,Subject,Message,Timeval) values ('$from','$name','$sub','$mess',now());";
		if(mysqli_query($conn,$sql))
			echo "Data Saved..";
		else
			echo "Error Data Save".mysqli_error($conn);
		
		include( '../02ui/commonfiles/phpmailer/PHPMailerAutoload.php');
		  $mail = new PHPMailer;
		  $mail->Host = 'smtp.dallas142.org';  //Sets the SMTP hosts
		  $mail->Port = 587;        //Sets the default SMTP server port
		  $mail->SMTPAuth = true;       //Sets SMTP authentication. Utilizes the Username and Password variables
		  $mail->SMTPSecure = 'tls';       //Sets connection prefix. Options are "", "ssl" or "tls"
		  $mail->Username = 'gauthamr.silumula@chidhagni.com';     //Sets SMTP username
		  $mail->Password = 'Gautham@28';     //Sets SMTP password
		  
		  
		  $mail->setFrom($_POST["from_address"],$_POST['name']);     //Sets the From email address for the message
		  
		  $mail->addAddress('gauthamr.silumula@chidhagni.com');//Adds a "To" address
		  $mail->addReplyTo($_POST['from_address'],$_POST['name']);
		 
		  $mail->WordWrap = 50;       //Sets word wrapping on the body of the message to a given number of characters
		  $mail->IsHTML(true);       //Sets message type to HTML    
		  $mail->Subject = $_POST["subject"];    //Sets the Subject of the message
		  $mail->Body = $_POST["message"];    //An HTML or plain text message body
		  if($mail->Send())        //Send an Email. Return true on success or false on error
		  {
		   echo 'Success Mail';
		  }
		  else
		  {
		   echo 'Failure Email Sent';
		  }
		
	}

	if($_POST['order_type']=='capcha_validate')
	{
			//Recapcha Code Validation
		session_start();
		if(empty($_SESSION['captcha_code'] ) || strcasecmp($_SESSION['captcha_code'], $_POST['code']) != 0){
		  $data['val']=false;
		  echo json_encode($data);
		} else {
			$data['val']=true;
		  echo json_encode($data);
		}
	}

}//end of order type check 

//on change of select_tag
else if(isset($_POST['select_tag_name']))
{
	
	
	$name=$_POST['select_tag_name'];
	//echo $name;
	//echo 'testing...';
	$sql="select * from medicine m, stock_master s where m.Medicine_Name=s.Medicine_Name and  m.Medicine_Name='$name'";
	//echo $sql;
	$result=mysqli_query($conn,$sql);
	$row=mysqli_fetch_assoc($result);
	$data["available"]=$row['Available'];
	$data["basic"]=$row['Basic'];
	$data["unit"]=$row['Unit'];
	echo json_encode($data);
}//END of select name


else if(isset($_GET['searchlist']))
{
	
}


?>