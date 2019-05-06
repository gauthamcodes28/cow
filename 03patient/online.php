<?php
if (session_status() == PHP_SESSION_NONE){
	session_start();
}
	include '../07config/newdbconfig.php';
	include '../02ui/commonfiles/header.php';
	$root=$_SESSION['root'];
/* 	echo $_SERVER['SERVER_NAME'];
	echo $root; */
?>
<ul class=" list-inline"  >
				
				 
				  
      </ul>

<div class="container-fluid custom_row">
  <div class="container">
	<div class="row">
    <div  class="col-md-12">  
        <ul class=" list-inline"  >
			<li class="pull-left">
				<h2 id="head_title"><span class=" page_title pd_main_title text-primary">Online Consultation</span></h2>
			</li>

			 <li style="" class="pull-right top-buttons">
								<button  style="" class="btn btn-primary"  type="button" id="save">Save</button>
			</li>
		  
      </ul>
   </div>
   </div>
   <div class="se-pre-con"></div>
<style>
 
</style>
<div class="row" style="margin-bottom:20px;">
    <div id="parentHorizontalTab" class="col-md-12" >
	
      <ul id="left_tabs_list" class="resp-tabs-list hor_1"> 
        <li>Patient Details</li>
		<li>Problem</li>
		<li>Previous Reports</li>

      </ul>

      <div class="resp-tabs-container hor_1" >
        <div>
          <div class="row no_margin ">
            <div class="form-horizontal">
              <div class="col-md-6">
					<div class="form-group col-md-12 mb-12">
						  <label for="pname" class="">Name:</label>
						  <input type="text" id="pname" value="" class="form-control  editable ">
					</div>		
					<div class="form-group col-md-12 mb-12">
				
					  <label class="form-check-label">Veda Pulse:</label>
					 <input  class="form-check-input vedapulse editable"  type="radio" name="vedapulse"  value="yes" id="veda1" ><label for="veda1" class="form-check-label">Yes</label>
					<input   class="form-check-input editable vedapulse"  type="radio" name="vedapulse"  value="no" id="veda2" ><label for="veda2" class="form-check-label">No</label>
					</div> 
				<div class="form-group  col-md-12 mb-12">
                  <label for="dob" class="">Date of Birth:</label>
                 
                    <input type="date" id="dob" value=""  class="form-control editable ">
                 
				  
                </div>
				 <div class="form-group  col-md-12 mb-12">
                  <label for="vikruthi" class="">Vikruthi:</label>
                  
                    <input type="text" id="vikruthi" value="" class="form-control editable ">
                  
                </div>
				 <div class="form-group  col-md-12 mb-12">
                  <label class="">Visit Number:</label>
                  
                    <input type="text" id="visit" name="visit" class="form-control" value="1" readonly>
              
                </div>
				<div class="form-group  col-md-12 mb-12">
                  <label for="country" class=" ">Country:</label>
                  
                    <select class="form-control editable " id="country"  name="country">
					<option disabled selected value=""> -- Select Country -- </option>
							<?php

				require("../07config/newdbconfig.php");

				$sql="select * from country";

				$result=mysqli_query($conn,$sql);

				while($row=mysqli_fetch_assoc($result))

				{

					echo '<option value="'.$row['Country_ID'].'">'.$row['Country_Name'].'</option>';

				}

				?>

					</select>



                </div>
				<div class="form-group col-md-12 mb-12 state">
                  <label for="state" class="">State:</label>
                  
                    <select class="form-control editable " id="state"  name="state">
					<option disabled selected value=""> -- Select State -- </option>
					<?php
				require("../07config/newdbconfig.php");
				$sql="select * from state";
				$result=mysqli_query($conn,$sql);
				while($row=mysqli_fetch_assoc($result))
				{
					echo '<option value="'.$row['State_ID'].'">'.$row['State_Name'].'</option>';
				}

				?>
					</select>
                 
                </div>
				<div class="form-group col-md-12 mb-12 ostate">
                  <label for="ostate" class="">Other Country:</label>
                  
                     <input type="text" id="ostate" name="ostate" value="" class="form-control editable " >
                  
                </div>
				<div class="form-group col-md-12 mb-12">
						 <label class="">Address:</label>
						  
							<textarea class="form-control editable " id="address"  style="height:60px;resize:none;"></textarea>
				
				</div>
              </div><!--ENd of col-md-6-->
			  
              <div class="col-md-6">
			  <div class="form-row">
                <div class="form-group col-md-12 mb-12">
                  <label class="">Phone:</label>
                  
                    <input type="text" id="phone"  class="form-control editable ">
                  
                </div>
                <div class="form-group col-md-12 mb-12">
                  <label class="form-check-label ">Gender:</label>
                  
				 <input type="radio" class="Gender editable form-check-input " name="gender"  value="Male" id="maleradio" ><label for="maleradio" class="form-check-label ">Male</label>
				  <input type="radio" class="Gender editable form-check-input " name="gender"  value="Female" id="femaleradio"><label for="femaleradio" class="form-check-label ">Female</label>
                  
                </div>
                <div class="form-group col-md-12 mb-12">
                  <label class="">Age:</label>
                  
                    <input type="text" id="age" class="form-control editable " value="" >
                 

                </div>
                <div class="form-group col-md-12 mb-12">
                  <label for="location" class=" ">Location:</label>

               
                <select class="form-control editable" value="" id="location">
				<?php
				include('../07config/newdbconfig.php');
				$sql="select * from branch_master";
				$result=mysqli_query($conn,$sql);
				echo '<option selected disabled value="">--Select Location--</option>';
				while($row=mysqli_fetch_assoc($result))
				{
					echo "<option value=".$row['Branch_ID'].">".$row['Branch_Name']."</option>";
				}
				?>

                </select>

             
                </div>
                <div class="form-group col-md-12 mb-12">
                  <label class="control-label">ID:</label>                
                     <input type="text" id="printpid" name="printpid" class="form-control" readonly>
                </div>		
				<div class="form-group col-md-12 mb-12">
                  <label class="control-label">E-Mail:</label>                
                     <input type="email" id="email" name="email" class="form-control">
                </div>		
				<div class="form-group col-md-12 mb-12">
						<label class="">Pic:</label>
						
						<img id="blah" src="./docs/sample.jpg" style="width:150px;height:100px" alt="your image" />
						<input class="editable addon" type="file" id="file"  name="file" onchange="readURL(this);">
						
					</div>

				</div>
              </div>
            </div>
          </div>
		  
		</div>

        <div>
          <div class="row no_margin">
		  <div class="form-row">
            <div class="form-group col-md-12 mb-12">
              
              <label class="control-label">Problem Description:</label>
              <textarea class="form-control editable " id="problem" style="height:60px;resize:none;"></textarea>
              </div>
           
					<div class="form-group col-md-12 mb-12">
					<label class="control-label">Problem Category:</label>
					<ul class="list-inline">
					  <li>
					  <label class="">Ayurvedic</label>
					  

								<select class="form-control editable" id="ayur" name="ayur" >
											<option>ashwagandha</option>
											<option>haritaki</option>
											<option>bibhitaki</option>
											<option>tulasi</option>
											<option>yasitmadhu</option>
							</select>
					  
					  </li>
					  <li>
							<label class="">Modern</label>
							
									<select class="form-control editable" id="mod" name="mod" >
												<option>dolo</option>
												<option>nimdispi</option>
												<option>crocin</option>
												<option>paracetamol</option>
												<option>dcold</option>
									</select>
							  
					  </li>
					 </ul>
					</div>
			</div>
		   
		  </div>
		   <div class="row no_margin">
				<div class="form-row">
					<div class="form-group col-md-12 mb-12">
						<label class="control-label">Diseases::</label>
						<ul class="columns" data-columns="2">	
						<?php 
						$die=['Acne','Acidity','Asthma','Arthritis','Cancer','Constipation','Diabetes','Hairloss','Piles','Psoriasis','Sciatica','Menstrual Prolems','PCOD','Thyroid','Ankylosing Spondylitis','Overweight-Obesity','Kidney stones','Gallbladder stone'];
						
/* 						for($i=0;$i<count($die);$i++){
									echo '<div class="col-sm-3"><div class="checkbox list-inline">
								  <label><input type="checkbox" name="diseases[]" value="'.$die[$i].'">'.$die[$i].'</label>
								</div></div>';
						} */
						for($i=0;$i<count($die);$i++){
									echo '<li><input type="checkbox" name="diseases[]" value="'.$die[$i].'">'.$die[$i].'</li>';
						}
							?>
						</ul>
					</div>
				</div>
			</div>
        </div>
		
		<div>
			 <div class="row no_margin">
				

				<div id="second_files" class="col-lg-12" style="overflow-x:auto;">
					<h3>Files Upload</h3>
						  <form class="" id="upload_Multiple_New" enctype="multipart/form-data">
								<table class="table">
									<thead class="">
										<tr>
											<th>Name</th>
											<th>Upload File</th>
										</tr>
									</thead>
									<tbody id="upload_add_more">
									<tr>
										<td><label>Submit Tongue photo:</label></td>
										<td><input type="file" name="images[]"/></td>
									</tr>
									<tr>
										<td><label>Submit Face Photo:</label></td>
										<td><input type="file" name="images[]"/></td>
									</tr>
									<tr>
										<td><label>Submit Nail's Photo(Hands):</label></td>
										<td><input type="file" name="images[]"/></td>
									</tr>
									<tr>
										<td><label>Submit Photo of affected area if required..</label></td>
										<td><input type="file" name="images[]"/></td>
									</tr>
									<tr>
										<td><label>Submit Medical Reports if available..</label></td>
										<td><input type="file" name="images[]"/></td>
									</tr>
									
									</tbody>
								</table>
							</form>
						
				</div>


      
			</div><!--row no_margin-->
		</div>
		
      </div><!--ENd of hor-tab container-->
	  
    </div><!--ENd of Parent Horizontal tab-->
	
	
	
	</div><!--class row-->
  </div><!--container-->
 </div><!--container-fluid custom_row-->
 </body>
 </html>
 <script>
 function getCookie(cname) {
  var name = cname + "=";
  var decodedCookie = decodeURIComponent(document.cookie);
  var ca = decodedCookie.split(';');
  for(var i = 0; i <ca.length; i++) {
    var c = ca[i];
    while (c.charAt(0) == ' ') {
      c = c.substring(1);
    }
    if (c.indexOf(name) == 0) {
      return c.substring(name.length, c.length);
    }
  }
  return "";
}
	//New Patient details saved to DB
	var devmode=true;
$(function(){
	$('#save').on('click',function(){
	//Section 1
	if(devmode)
	console.log("newsave click started");
	var file=document.getElementById("file").value;
	var pname=document.getElementById("pname").value;
	var phone=document.getElementById("phone").value;
	var dob=document.getElementById("dob").value;
	var gender=$("input[name='gender']:checked").val();
	var branch=document.getElementById("location").value;
	var age=document.getElementById("age").value;
	var vikruthi=document.getElementById("vikruthi").value;
	var vedapulse=$("input[name='vedapulse']:checked").val();
	var visit=document.getElementById("visit").value;
	var country=document.getElementById("country").value;
	var state=document.getElementById("state").value;
	var ostate=document.getElementById("ostate").value;
	var address=document.getElementById("address").value;
	var problem=document.getElementById("problem").value;
	var email=$("#email").val();
	
var flag=true;
//flag validaton start
	if(pname=='')
	{
		alert('Enter Name');
		flag=false;
	}
	 else if(typeof(gender) == 'undefined')
	{
		alert('select gender');
		flag=false;
	}
	 else if(branch=='')
	{
		alert('select location');
		flag=false;
	}
	 else if(age.length==0)
	{
		alert('set the date of birth');
		flag=false;
	}

	else if(typeof(vedapulse) == 'undefined' )
	{
		alert('select vedapulse');
		flag=false;
	}
	else if(country.length==0  )
	{
		alert('select country');
		flag=false;
	} 
	else {
		
		 if(country =='ind' )
		{
			if(state.length==0)
				{
					alert('select state');
					flag=false;
				}
		}
		if(country =='out' )
		{
			if(ostate.length==0)
				{
					alert('empty other state');
					flag=false;
				}
		}
	}
	 if(problem =='')
	{
		flag=false;
		alert("Enter Problem Data");
	}
	
/* 	var pics=false;
	console.log("flag:"+flag+"pics"+pics);
	for(var i=1;i<5;i++)
	{
		if(!$("input[type=file]")[i].files[0]==undefined)
		{
			pics=true;
		}
	}
	console.log("flag:"+flag+"pics"+pics);
	if(flag)
	{
		if(pics)
		{
			flag=true;
			
		}
		else{
			flag=false;
			alert("Add atleast one Image.");
		}
			
	}
	console.log("flag:"+flag+"pics"+pics);
			 */
	if(flag)
	{
		
		//Problem Data
	 var problem=document.getElementById("problem").value;
	 var mod=document.getElementById("mod").value;
	 var ayur=document.getElementById("ayur").value;
	 
	 var checkdiseases = document.getElementsByName('diseases[]');
			var vals = "";
			for (var i=0, n=checkdiseases.length;i<n;i++) 
			{
				if (checkdiseases[i].checked) 
				{
					vals += ""+checkdiseases[i].value+",";
				}
			}
	 //alert(problem+mod+ayur);
	
	
	//as all things  server by ../08common/dataprocess.php to avoid naming conflicts from witht he existing functions we use this variable
	

	var file_data = $("#file").prop("files")[0];   // Getting the properties of file from file field
	var form_data = new FormData();                  // Creating object of FormData class
	form_data.append("file", file_data)              // Appending parameter named file with properties of file_field to form_data
	form_data.append("pname", pname)
	form_data.append("phone", phone)
	form_data.append("dob", dob)
	form_data.append("gender", gender)
	form_data.append("location", branch)
	form_data.append("age", age)
	form_data.append("vikruthi", vikruthi)
	form_data.append("vedapulse", vedapulse)
	form_data.append("visit",visit )
	form_data.append("country", country)
	form_data.append("state", state)
	form_data.append("ostate", ostate)
	form_data.append("address", address)
	form_data.append("mod", mod)
	form_data.append("problem", problem)
	form_data.append("ayur", ayur)
	form_data.append("diseases", vals)
	form_data.append("email", email)
	
	form_data.append("order_type","online_save")

	$.ajax({
        url: "../08common/dataprocess.php",
        data: form_data,
        cache: false,
        processData: false,
        contentType: false,
        type: 'POST',
        success: function (dataofconfirm) {
            // do something with the result
			if(devmode){
			console.log("start of success function");
			console.log(dataofconfirm);
			}
			
			if(devmode){
			console.log("end of success function");
			}
        }
    }).done(function(data){
		//Upload Files code start
		var printpid=getCookie('id');
		//console.log("data from neewsave:"+data);
		var temp='<input type="text" id="files_id" style="display:none" name="files_id" value='+printpid+' />';
		temp+='<input type="text" id="files_visit" style="display:none" name="files_visit" value="1" />';
		temp+='<input type="text" id="order_type" style="display:none" name="order_type" value="uploadfiles" />';
		$("#upload_Multiple_New").append(temp);
		$("#upload_Multiple_New").submit();
		//Upload files code end
		alert("Data Saved Successfully");
		$("#save").hide();
		$(".editable").prop("disabled",true);
		$("#second_files").hide();
	});
	//preloader
	$(".se-pre-con").show();
	
	
	
	

	


	}//End of flag check flag for validations true
	if(devmode)
		console.log("End of newsave click function");
  });//end of newsave
  
 });
 </script>
 <script>
 $(function(){
			//Required Pre Defined Functions
			//Horizontal Tab
        $('#parentHorizontalTab').easyResponsiveTabs({
            type: 'default', //Types: default, vertical, accordion
            width: 'auto', //auto or any width like 600px
            fit: true, // 100% fit in a container
            tabidentify: 'hor_1', // The tab groups identifier
            activate: function(event) { // Callback function if tab is switched
                var $tab = $(this);
                var $info = $('#nested-tabInfo');
                var $name = $('span', $info);
                $name.text($tab.text());
                $info.show();
            }
        });
		
		 // Child Tab
        $('#ChildVerticalTab_1').easyResponsiveTabs({
            type: 'vertical',
            width: 'auto',
            fit: true,
            tabidentify: 'ver_1', // The tab groups identifier
            activetab_bg: '#fff', // background color for active tabs in this group
            inactive_bg: '#F5F5F5', // background color for inactive tabs in this group
            active_border_color: '#c1c1c1', // border color for active tabs heads in this group
            active_content_border_color: '#5AB1D0' // border color for active tabs contect in this group so that it matches the tab head border
        });
		
		
 });
 </script>
<script src="../02ui/scripts/new_form.js"></script>
<script src="../02ui/scripts/new_functions.js"></script>

<?php include '../02ui/commonfiles/footer.php';?>