<?php 	include '../02ui/commonfiles/header.php';?>


<form style="display:none" id="query_send_id" action="<?php echo $root;?>03patient/prescription.php?status=online" method="post" enctype="multipart/form-data">
	<input type="text" name="online_id" id="online_id" placeholder="Patient ID" value=""/>
	<input type="number" name="online_visit" id="online_visit" placeholder="Visit Number" value=""/>
	
	<input type="submit" name="submit" value="Submit" id="submit_online" />
</form>


<div class="container-fluid custom_row">
  <div class="container">
<!-- =======Home body content start ============ --> 
        	
            	<div class="product_detail_heading">
                    <h2><span class=" page_title pd_main_title text-primary"></span></h2>
                </div>
            
      <div class="col-sm-12 col-lg-12 well">
       <div class="form-row">
							
							<div class="form-group col-md-3 mb-3">
										<label for="sid" class="">Patient ID:</label>
										<input type="text" class="form-control" id="spid" name="spid" value="">
							</div>		
							<div class="form-group col-md-3 mb-3">
								<label for="phone" class="">Phone:</label>
								<input type="text" class="form-control" id="phone" name="phone" value="" >
							 
							</div>		
							<div class="form-group col-md-3 mb-3">
								<label for="pname" class="">Name:</label>
								<input type="text" class="form-control" id="pname" name="pname"  value="">
							  
							</div>	
		</div>
						<div class="form-row">
							<div class="form-group col-md-3 mb-3">
								<label  for="dob" class="">DOB:</label>
								<input type="date" class="form-control " id="dob" name="dob"  >
							 
							</div>		
							<div class="form-group col-md-3 mb-3">
								<label for="location" class="">Location:</label>
								
								<select class="form-control " value="" id="location">
								<option selected value="">--Location--</option>
								<?php
								include 'newdbconfig.php';
								$sql="select * from branch_master";
								$result=mysqli_query($conn,$sql);
								
								while($row=mysqli_fetch_assoc($result))
								{
									echo "<option value=".$row['Branch_ID'].">".$row['Branch_Name']."</option>";
								}
								?>
								  
								</select>
							  
							</div>		
							<div class="form-group col-md-3 mb-3">
								<label for="ayurvedic" class="">Ayurvedic:</label>
								
								<select class="form-control editable " value="" id="ayurvedic">
								<option selected value="">--Ayurvedic--</option>
								<?php
								include 'newdbconfig.php';
								$sql="select * from ayurvedic";
								$result=mysqli_query($conn,$sql);
								
								while($row=mysqli_fetch_assoc($result))
								{
									echo "<option value=".$row['ACategory_ID'].">".$row['ACategory_Name']."</option>";
								}
								?>
								  
								</select>
							  
							</div>		
						</div>
					<div class="form-row">
							<div class="form-group col-md-3 mb-3">
								<label for="modern" class="">Modern:</label>
								<select class="form-control" value="" id="modern">
								<option selected value="">--Modern--</option>
								<?php
								include 'newdbconfig.php';
								$sql="select * from modern";
								$result=mysqli_query($conn,$sql);
								
								while($row=mysqli_fetch_assoc($result))
								{
									echo "<option value=".$row['Mod_ID'].">".$row['Mod_Name']."</option>";
								}
								?>
								  
								</select>
							  
							</div>		
							 
					</div>
					<div class="form-row">
							<div class="form-group col-md-3 mb-3">
								<label for="modern" class="">Mode:</label>
								<select class="form-control" value="" id="mode">
								<option selected value="">--mode--</option>
								<option value="online">Online</option>  
								<option value="offline">Offline</option>  
								</select>
							</div>
					</div>
				<div class="clearfix"></div>
				
				<div class="form-row">
					<div class="col-md-12">
					<hr>
				<button type="Submit" class="btn btn-primary pull-right"   id="searchkeys" name="submit" onclick="search()">Search</button>
					</div>
				</div>
				
						
		</div>
		
												
						
			
           
    
	
        <div class="col-lg-12" style="margin-bottom: 20px;" id="pro">
        	
        </div>
    </div>
</div>  

<?php include '../02ui/commonfiles/footer.php';?>

<script>
$("#pro").hide();
$('.pd_main_title').html('Search For Online Patients By Criteria');


function search(){
	
	$("#pro").show();
	
	
	var spid=document.getElementById("spid").value;
	var pname=document.getElementById("pname").value;
	var dob=document.getElementById("dob").value;
	var phone=document.getElementById("phone").value;
	var location=document.getElementById("location").value;
	var mode=$("#mode").val();
	
	
		var order_type='searchexistingquery';
	
		
	
	    $.ajax({
           url:"../08common/dataprocess.php",
           dataType: 'text',
		   method: 'post',
		   data:{'spid':spid,'pname':pname,'dob':dob,'phone':phone,'location':location,'mode':mode,'order_type':order_type},
           success: function(data){
           var k=data;
            var temp="<div class='table-responsive col-lg-12 col-md-12 col-sm-12 col-xs-12' style='margin-bottom=20px;'><table class='table table-bordered'  id='dataTable' width='100%' cellspacing='0'><h3><span class=\"pd_main_title text-primary\">Search Results: </span></h3> <thead><th>Id</th><th>Name</th><th>Phone</th><th>Age</th><th>Country</th><th>State</th><th>Mode</th></thead><tbody style=\"background-color:white;\">";
			temp+=k;
			temp+="</tbody></table></div>";
			pro.innerHTML=temp;
			$("#dataTable").DataTable()
			}
		   
		});
	
	
	
}


$(function(){
	
	$('#pro').on('click','.query_id',function(){
		var id=$(this).parent().siblings('.view_id').text();
		//var mode=$(this).parent().siblings('.mode');
		//console.log(id+'<-id');
			$('#online_id').val(id);
			$('#online_visit').val('1');
			
			$("#submit_online").trigger('click');
		
		//console.log($(this).parent().siblings('.view_id').text());
	});
	
});
</script>