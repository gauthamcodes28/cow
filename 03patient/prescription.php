<?php
if (session_status() == PHP_SESSION_NONE){
	session_start();
}

	include '../07config/newdbconfig.php';
	include '../02ui/commonfiles/header.php';


if($_GET['status']=='new' || $_GET['status']=='view')
 {
	 echo '<script src="../02ui/scripts/new_functions.js"></script>';
 }

	?>

<script>
//Turn on dev mode to see the execution flow
var devmode=true;
$('.top-buttons').hide();
	$(document).ready(function(){
			$('.top-buttons').hide();
			//to print all the sequence of execution for the functions..
			
	});
</script>



<?php
if(!isset($_SESSION['user_name']))
{
	echo '<script>$(function(){if(devmode){console.log("exit at session var");}});</script>';
	echo '<script>document.location.href="'.$root.'index.php";';
	echo '</script>';
}
else if(!isset($_GET['status']))
{
	echo '<script>$(function(){if(devmode){console.log("exit at status var");}});</script>';
	echo '<script>document.location.href="'.$root.'index.php";</script>';
}
//New
	else if($_GET['status']=='new')
	{
			echo '<script>$(function(){
					if(devmode)
					{console.log("new mode");}
							var title="New Patient Details Entry";
					$("#order_type").val("newsave");
					$("#save").closest("li").show();
					$("#visit_container").hide();
					$("#head_title").children().html(title);
			});</script>';
			
			//Buttons to show
	}//end of new
//View
else if($_GET['status']=='view')
	{
		
		if(!isset($_POST['patient_id'])|| !isset($_POST['visit_number']))
		{
			echo '<script>';
			echo 'alert("session might expire redirecting to existing patients");
			document.location.href="'.$root.'03patient/search.php"';
			echo '</script>';
		}
		
		//receives post data from new save of the patientID
		$id=$_POST['patient_id'];
		$visit=$_POST['visit_number'];
		
		
		//Defining variables
		echo '<script>	
					var ul=["Patient Details","Problem & Medication","Instruction","Previous Reports"];
					var title="View Existing Patient Details";
			</script>';
		
			
		//Appending the variables 
			echo '<script>$(function(){
				$("#order_type").val("updatesave");
				$("#head_title").children().html(title);
				$("#visit_container").show();';
				
		//function call
			echo 'viewmode("'.$id.'","'.$visit.'");';
			echo '$(".editable").prop("disabled",true);';
			echo '$("#editview").closest("li").show();';
			echo '$("#addfollow").closest("li").show();';
			echo '$("#printpdf").closest("li").show();';
			echo '$("#printinvoice").closest("li").show();';
			echo ' $("#add_medicines").hide();';
			echo 'var visit=$("#visit").val();';
			echo '$("#selvisit").val(visit);
				//console.log($("#selvisit"));
				$("#second_files_head").hide();
				$("#second_files").hide();
				';
			echo '});
			</script>';
		echo '<script>$(function(){ if(devmode){console.log("view mode");}});</script>';
				
	}//end of view
//Followup
	else if($_GET['status']=='followup')
	{
		echo '<script>$(function(){var id=getCookie("id");$("#printpid").val(id);followview();
			$("#followsave").closest("li").show();
			$("#canceledit").closest("li").show();
			
			setvisit();
			
			});</script>';
		echo '<script>$(function(){if(devmode){console.log("follow up mode");}
			$("#order_type").val("followsave");
			});</script>';
		echo '<script src="'.$root.'02ui/scripts/new_form.js"></script>
				  <script src="'.$root.'02ui/scripts/new_functions.js"></script>';
	}
	else //($_GET['status']=='online')
	{
		$id="";
		if(!isset($_POST['online_id']))
		{
			
			echo '<script>';
			echo 'alert("session might expire redirecting to existing patients");
			document.location.href="'.$root.'03patient/searchonline.php"';
			echo '</script>';
		}
		else{
			$id=$_POST['online_id'];
		}
		
		
		
		
		echo '
		<script>
		$(function(){
			var title="Online Patient Details";
			$("#head_title").children().html(title);
			online_patient_view("'.$id.'");
			$("#updatesave").closest("li").show();
			
		});
		</script>
		';
		echo '<script src="'.$root.'02ui/scripts/new_form.js"></script>
				  <script src="'.$root.'02ui/scripts/new_functions.js"></script>';
	}
	if($_GET['status']=='view')
	{
		echo "
		<script>
		$(function(){
			console.log('second');
			$('.plus_sign').hide();
			$('.delete-row').hide();
			$('.delete_inside_row').hide();
			});
		</script>";
	}

?>
<script>
 $("#alert_message").hide();

$(function(){
			//Required Pre Defined Functions
			//Vertical Tab
			/* $('#parentVerticalTab').easyResponsiveTabs({
            type: 'vertical', //Types: default, vertical, accordion
            width: 'auto', //auto or any width like 600px
            fit: true, // 100% fit in a container
            closed: 'accordion', // Start closed if in accordion view
            tabidentify: 'hor_1', // The tab groups identifier
            activate: function(event) { // Callback function if tab is switched
                var $tab = $(this);
                var $info = $('#nested-tabInfo2');
                var $name = $('span', $info);
                $name.text($tab.text());
                $info.show();
            }
        }); */
$(".delete-row").hide();
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
		
$('#editview').on('click',function(){
				//All arrays to store the data of each row in sequence
			
		//Code to display the Upload Files for visit number start
		var visit=$('#visit').val();
		//$("<h5>Upload Files for Visit"+visit+"</h5>").insertBefore('#second_files');
		
		//Code to display the Upload Files for visit number end
		
		 $(".editable").prop("disabled",false);
		 $("#save").closest('li').show();
		 $("#addfollow").closest('li').hide();
		 $("#printpdf").closest('li').hide();

		 //$(".medkill").show();
		 $("#canceledit").closest('li').show();
		 $('#second_files_head').show();
		$('#second_files').show();
		$('#editview').closest('li').hide();
		$("#printinvoice").closest('li').hide();
		$("#add_medicines").show();
		$('.plus_sign').show();
		$(".delete_inside_row").show();
		$(".checkall").closest("div").show();
		$(".delete-row").show();
		$('.delete_inside_row').show();
		$(".delete_file").show();
   });
 
$("#canceledit").click(function(){
	<?php 
	if($_GET['status']=="view")
	{
		
	?>
	document.location.reload();
	$(".delete-row").hide();
	  $(".editable").prop("disabled", true);
	  $("#canceledit").closest('li').hide();
	  $("#printpdf").closest('li').show();
	   $("#printinvoice").closest('li').show();
	   $("#addfollow").closest('li').show();
	   $("#updatesave").closest('li').hide();
	   $('#second_files_head').hide();
		$('#second_files').hide();
      $('#editview').closest('li').show();
	  $("#add_medicines").hide();
	  $(".plus_sign").hide();
	  $('.delete_inside_row').hide();
	  $(".delete_file").hide();//means the previous files upoaded by patient.

	 <?php
	}
	else if($_GET['status']=="followup")
	{
		?>
	document.location.href="search.php";
	<?php
	}
	 ?>
   });

   $('#visit_container').on('change','#selvisit',function(){
	 var id=$("#printpid").val();
	 var visit=$('#selvisit').val();
	  if(devmode)
	  {
	  console.log('start on change  selvisit js function'); 
	 console.log(id+'&'+visit);  
	  }
	  viewmode(id,visit);
	   $("#alert_message").show();
	   setTimeout(function() {
				$("#alert_message").fadeOut(1500);
			},3000);

	if(devmode)
		console.log("exit on change selvisit js function");
   });
 
});
	
</script>
<script>

$(function(){
	//TO align the buttons 
	
	
	$('.top-buttons').children().css("margin-top","20px");
	$(window).resize(function() {
    if( $(this).width() <= 576 ) {
      //$('.top-buttons').children().css("margin-top","20px");
    }
	else if( $(this).width() <= 768 ) {
     // $('.top-buttons').children().css("margin-top","20px");
    }
	else if( $(this).width() <= 992 ) {
      //$('.top-buttons').children().css("margin-top","20px");
    }
	else
	{
		 $('.top-buttons').children().css("margin-top","20px");
	}
});
	
});
</script>




<form style="display:none" id="send_id" action="<?php echo $root?>03patient/prescription.php?status=view" method="post" enctype="multipart/form-data">
<input type="text" name="patient_id" id="patient_id" placeholder="Patient ID"/>
<input type="text" name="visit_number" id="visit_number" placeholder="Visit Number"/>
<input type="submit" name="submit" value="Submit" id="submit" />
</form>


<div class="container-fluid custom_row">
  <div class="container">

   <div class="se-pre-con"></div>
		<div class="row">
	    <div  class="col-md-12">  
	        <ul class=" list-inline"  >
				<li class="pull-left">
					<h2 id="head_title"><span class=" page_title pd_main_title text-primary"></span></h2>
				</li>
			
				<li id="visit_container" class="pull-left">
					
				</li>
				<li>
					<h5 id="alert_message" class="alert alert-success" style="display:none;" >Data Updated..</h5>
				</li>

					<li  class="pull-right top-buttons"  id="visit-container">
					</li>
		
	      </ul>
	   </div>
   </div>

<div class="row" style="margin-bottom:20px;">
    <div id="parentHorizontalTab" class="col-md-12" >
	
      <ul id="left_tabs_list" class="resp-tabs-list hor_1"> 
        <li>Patient Details</li>
		<li>Problem & Medication</li>
	
		<li>Instruction</li>
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
				include '../07config/newdbconfig.php';
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
                     <input type="email" id="email" name="email" class="editable form-control">
                </div>
				<div class="form-group col-md-12 mb-12">
						<label class="">Pic:</label>
					<div class="row">
						<div class="col-md-6" id="my_camera"></div>
						<div class="col-md-6" style=" width: 250;height: 250;" id="results"></div>
					</div>
						 <input type=button value="Take Snapshot" onClick="take_snapshot()">
                		 <input type="hidden" name="image" id="file" class="image-tag">
                		  
						<!-- <img id="blah" src="./docs/sample.jpg" style="width:150px;height:100px" alt="your image" /> -->
						<!-- <input class="editable addon" type="file" id="file"  name="file" onchange="readURL(this);"> -->
						
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
			<label for="sel1" class="">Medication Details:</label>
              <div class="form-inline" id="add_medicines" >
                <select class="form-control editable " id="sel1">
				<?php
				include '../07config/newdbconfig.php';
				$sql="select * from medicine_type";
				$result=mysqli_query($conn,$sql);

				while($row=mysqli_fetch_assoc($result))
				{
					echo "<option>".$row['Type_Name']."</option>";
				}
				?>

                </select>
				
                <button type="button" class="add-row btn btn-primary btn-md editable ">Add Medicines</button>
                <button type="button" id="delete" class="delete-row btn btn-danger btn-md editable ">Delete Selected Medicines</button>

              </div>
            </div>
			</div>
			 <div class="table-responsive col-lg-12" id="medicine_part">
				<!-- <fieldset id="checkall_button">
					<div class="form-check col-md-12 mb-12">
						<input type='checkbox' name='save' value="Delete" class="checkall form-check-input">
						<label class="form-check-label">Check All</label>
					</div>
				</fieldset> -->

				
				<!--Add add-row  Medicine from the scripts/newform.js function on click-->
				<!-- <a class="plus_sign"><span class="glyphicon glyphicon-plus"></span></a> -->
				<div id="accordion">



				</div><!-- Accordian Div -->
			</div><!--  End of medicine part -->
          

          </div>
        </div>
        <div>
          <div class="row no_margin">
		  <div class="form-row">
            <div class="form-group col-md-12 mb-12">
             
                <textarea class="form-control editable " id="dan" readonly style="height:60px;resize:none;">Use Dantmanjan only Don't use Toothpaste.Use Brush only if equired..&#13;&#10;Use Angarakshak Soap:- Avoid foam based soap.</textarea>
              
            </div>
			
              <div class="form-group col-md-12 mb-12">
                <label class="control-label">Panchkarma Treatment  :</label>
                <textarea class="form-control editable " id="pan"  style="height:60px;resize:none;"></textarea>
              </div>
            
            
              <div class="form-group col-md-12 mb-12">
                <label class="control-label">Yoga :</label>
                <textarea class="form-control editable " id="yoga" style="height:60px;resize:none;"></textarea>
              </div>
           
			
              <div class="form-group col-md-12 mb-12">
                <label class="control-label">Instructions:</label>
                <textarea class="form-control editable " id="inst"  style="height:60px;resize:none;"></textarea>
              </div>
           
           
              <div class="form-group col-md-12 mb-12">
                <label class="control-label">Instruction start :</label>
                <textarea class="form-control editable " id="start"  style="height:60px;resize:none;">Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau </textarea>
              </div>
            
           
              <div class="form-group col-md-12 mb-12">
                <label class="control-label">Instruction stop :</label>
                <textarea class="form-control editable " id="stop"  style="height:60px;resize:none;">Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.</textarea>
              </div>
            
              <div class="form-group col-md-12 mb-12">
                <label class="control-label">Others 1:</label>
                <textarea class="form-control editable " id="other1"  style="height:60px;resize:none;"></textarea>
              </div>
            
              <div class="form-group col-md-12 mb-12">
                <label class="control-label">Others 2:</label>
                <textarea class="form-control editable " id="other2"  style="height:60px;resize:none;"></textarea>
              </div>
            
			</div>
          </div>

        </div>
	</form><!--End of Add_Form Div tag-->
		<div>
			 <div class="row no_margin">
				<?php
				if($_GET['status']=="new")
				{
				?>

				<div id="second_files" class="col-lg-6 col-md-6 col-sm-12 col-xs-12" style="overflow-x:auto;">						
						<input type="button" class="btn btn-primary pull-left" onClick="new_file()" value="Add More Files"/>
						  <form class="" id="upload_Multiple_New" enctype="multipart/form-data">
								<table class="table">
									<thead class="">
										<tr>
											<th>Upload File</th>
											<th>Delete File</th>
										</tr>
									</thead>
									<tbody id="upload_add_more">
										<td><input type="file" name="images[]"/></td>
										<td><input type="button" class="btn btn-danger" value="delete" onClick="delete_file(this);" /></td>
									</tbody>
								</table>
							</form>
						
				</div>


				<?php
				}
				else if($_GET['status']=='followup')
				{
					?>
					
			<div class="view_reports col-lg-6 col-md-6 col-sm-12 col-xs-12">
				 <div class="" >
					<ul class="list-inline">
						<li><h3>Uploaded Reports</h3></li>
					</ul>
				  </div>
			</div>
				
         <div  class="col-lg-6 col-md-6 col-sm-12 col-xs-12" style="overflow-x:auto;">
                 <div class="" id="second_files_head">
				  <ul class="list-inline">
						<li><h3>Upload Files</h3></li><li><input  type="button" class="btn btn-primary pull-left" onClick="new_file()" value="Add More Files"/></li>
				  </ul>
				 </div>
				<div id="second_files" class="">
						
						  <form class="" id="upload_Multiple_Existing" enctype="multipart/form-data">
								<table class="table">
									<thead class="">
										<tr>
											<th>Upload File</th>
											<th>Delete File</th>
										</tr>
									</thead>
									<tbody id="upload_add_more">
										<td><input type="file" name="images[]"/></td>
										<td><input type="button" class="btn btn-danger" value="delete" onClick="delete_file(this);" /></td>
									</tbody>
								</table>
								
							</form>
						
					</div>
				</div>
					<?php
				}
        else if(($_GET['status']=='view')||($_GET['status']=='online')){
?>
             
			  <div class="view_reports col-lg-6 col-md-6 col-sm-12 col-xs-12">
				 <div class="" >
					<ul class="list-inline">
						<li><h3>Uploaded Reports</h3></li>
					</ul>
				  </div>
				</div>
			<div  class="col-lg-6 col-md-6 col-sm-12 col-xs-12" style="overflow-x:auto;">
                 <div class="" id="second_files_head">
				  <ul class="list-inline">
						<li><h3>Upload Files</h3></li><li><input  type="button" class="btn btn-primary pull-left" onClick="new_file()" value="Add More Files"/></li>
				  </ul>
				 </div>
				<div id="second_files" class="">
						
						  <form class="" id="upload_Multiple_Existing" enctype="multipart/form-data">
								<table class="table">
									<thead class="">
										<tr>
											<th>Upload File</th>
											<th>Delete File</th>
										</tr>
									</thead>
									<tbody id="upload_add_more">
										<td><input type="file" name="images[]"/></td>
										<td><input type="button" class="btn btn-danger" value="delete" onClick="delete_file(this);" /></td>
									</tbody>
								</table>
								
							</form>
						
					</div>
				</div>
              
           
		
	
<?php

        }
				?>
      
			</div><!--row no_margin-->
		</div>

      </div><!--ENd of hor-tab container-->
	  
    </div><!--ENd of Parent Horizontal tab-->
	
	
	
	</div><!--class row-->

		<input type="text" id="order_type"  >
		<div class="row" style="margin-bottom: 5px;">
	    <div  class="col-md-12">  
	        <ul class=" list-inline"  >

					<li  class="pull-right top-buttons"  id="visit-container">
					</li>
					 <li style="display:none;" class="pull-right top-buttons">
						<button  style="" class="btn btn-primary"  type="button" id="editview">Edit</button>
					 </li>
					  <li style="display:none;" class="pull-right top-buttons">
							   <button  style=";" class="btn btn-primary"  type="button" id="addfollow">Add Follow Up Consultation</button>
					  </li>
					  <li style="display:none;" class="pull-right top-buttons">
								  <button  style="" class="btn btn-primary"  type="button" id="canceledit">Cancel</button>
					  </li>
					  <li style="display:none;" class="pull-right top-buttons">
									<button  style="" class="btn btn-primary"  type="button" id="printpdf">Print PDF</button>
					  </li>
						<li style="display:none;" class="pull-right top-buttons">
									<button  style="" class="btn btn-primary"   type="button" id="printinvoice">Print Invoice</button>
					  </li>
					 
					  <li style="display:none;" class="pull-right top-buttons">
									<button  style="" class="btn btn-primary"  type="button" id="save">Save</button>
					  </li>	
	      </ul>
	   </div>
   </div>

  </div><!--container-->
 </div><!--container-fluid custom_row-->
 
 <form style="display:none" id="print_form" target="_BLANK" action="<?php echo $root?>03patient/print.php"  method="post" enctype="multipart/form-data">
<input type="text" name="print_id" id="print_id" placeholder=""/>
<input type="text" name="print_visit" id="print_visit" placeholder=""/>
<input type="text" name="print_type" id="print_type" placeholder=""/>
<input type="text" name="print_months" id="print_months" value="1" placeholder=""/>
<input type="submit" name="print_submit" value="Submit" id="print_submit" />
</form>


 <script>
 $(function(){

	$("#printpdf").on("click",function(){
		var id=$("#printpid").val();
		var visit=$("#visit").val();
		var type="printpdf";
		$("#print_id").val(id);
		$("#print_visit").val(visit);
		$("#print_type").val(type);
		$("#print_submit").trigger("click");
	});


	$("#printinvoice").on("click",function(){
		var id=$("#printpid").val();
		var visit=$("#visit").val();
		var type="printinvoice";
		$("#print_id").val(id);
		$("#print_visit").val(visit);
		$("#print_type").val(type);
		
		
		var months = prompt("For How Many Months?", "");
		while(months == null || months == "")
		{
			if (months == null || months == "") {
		    months = prompt("For How Many Months?", "");
		  } else {
		    break;
		  }
		}

		//form is submitted here
		
		$("#print_months").val(months);
		$("#print_submit").trigger("click");

		var payment_status;
			payment_status=confirm("Will The Payment be done.??");

				if(payment_status)
				{
			
					var id=$("#printpid").val();
					var visit=$("#visit").val();
					$.ajax({
						async:false,
						url:"../08common/dataprocess.php",
						dataType:"TEXT",
						data:{"order_type":"deduct_medicines","patient_id":id,"visit":visit},
						method:"POST",
						success:function(data){
							//console.log("Success:");
							//console.log(data);
						},
						error:function(error){
							if(devmode)
								console.log("Error: at medicines deduct");
						}
					});
					alert("Stock Deducted");
				}
				else
				{
					alert("No Stock Deducted");
				}
			
	
	});
 });
 </script>
 <?php
 if($_GET['status']=='new' || $_GET['status']=='view')
 {
	 echo '<script src="../02ui/scripts/new_form.js"></script>';
 }
 ?>
 <style>
 @media screen and (min-width: 480px) {
  body {
    .top-buttons{
		margin-top:0px;
		margin:0px;
		font-size:10px;
	}
  }
}
</style>

<script>
  $( function() {
    

    $( "#accordion" ).accordion({
    	header: "h2",
    	collapsible: true,
    	heightStyle: "content"
    });


});


</script>
 <?php include '../02ui/commonfiles/footer.php';?>