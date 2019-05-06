<?php

session_start();

if(isset($_SESSION['root']))

	$root=$_SESSION['root'];

else 

	$root="";

?>



   

<?php include '../02ui/commonfiles/header.php';



?>

<div class="clearfix"></div>

<div class="container-fluid " style="margin-bottom:20px;">

  <div class="container">

<?php

if(!isset($_SESSION['user_name']))

{

	echo '<script>$(function(){if(devmode){console.log("exit at session var");}});</script>';

	echo '<script>document.location.href='.$root.'"index.php";</script>';

}

else if(!isset($_GET['status']))

{

	echo '<script>$(function(){if(devmode){console.log("exit at status var");}});</script>';

	echo '<script>document.location.href='.$root.'"index.php";</script>';

}

else if($_GET['status']=="new")

{

	echo '<script>$(function(){';

		echo '$(\'#entry_user\').html(\''.$_SESSION['user_name'].'\')';

	echo '});</script>';

		?>

<!--Start Stock Update-->

	<div class="row">

		<div class="col-md-12 stock_update">

					<h3><span class="page_title text-primary">Medicines Stock Update: User Name:-<label id="entry_user"></label></span></h3>

					<p id="status" class="alert alert-success" style="display:none;">

					</p>

					  <div class="form-inline">

						<select class="form-control editable " id="sel1">

						<?php

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

						<button type="button" id="savestock" class="btn btn-primary btn-md  pull-right">Save</button>

						<button type="button" id="reenter" class="btn btn-primary pull-right">Add New</button>

					  </div>

		</div>



			<div class="col-md-12 " id="stock">

					 <div class="table-responsive">

					  <table class="table" id="update_table">

						  <thead><tr><th><input type='checkbox' name='save' value="Delete" class="checkall editable" ></th>

							<th>Medicine Type</th><th>Medicine_Name</th><th>Net Contents</th><th>Quantity No.</th><th>Amount to Add</th></tr></thead>

						  <tbody>

							<!--Comes from script avaialbale in stock.js in scripts folder file-->

						  </tbody>

						</table>

					</div>

			</div>





	</div>

	<script>

	$(document).ready(function(){

		

		$("#update_table").on("change",".select_name",function(){

			//console.log($(this).val());

			var sel=$(this);

			var name=sel.val();

			var type=sel.parent().siblings(".type_td").children().text();

			//console.log(name+type);

			$.ajax({

				url:"../08common/dataprocess.php",

				data:{"order_type":"stock_update_select","name":name,"type":type},

				dataType:"JSON",

				method:"POST",

				success:function(data){

					//console.log(data);

					sel.parent().siblings(".net_td").children().val(data.net+data.unit);

					

				},

				error:function(data){

					console.log("error :"+data);

				}

				

				

			});

		});

		

		$("#update_table").on("change",".multiple_td",function(){

			//console.log($(this));

			var net=parseInt($(this).siblings(".net_td").children().val());

			var multiple=$(this).children().val();

			var unit=$(this).siblings(".net_td").children().val().replace(/\d/g, '');

			$(this).siblings(".amount_td").children().val(net*multiple+unit);

			//console.log(net+multiple);

		});

		

		

	});

	</script>

<!--END Stock Update-->

		<?php

}//end of stock_new



else if($_GET['status']=="credit")

{

	?>

<!--Start Stock credit history-->

<div class="row">

		<div class="col-lg-12 col-sm-12 col-md-12 credit_history">

			<script>

			$(function(){

			$.ajax({

							   url:"../08common/dataprocess.php",

							   data:{'order_type':'credit_history'},

							   method:'POST',

							   success: function(data){

							   var k=data;

							   //console.log(data);

								var temp="<div class='table-responsive'><table class='table table-bordered' id='history_table' width='100%'  cellspacing='0'><h3><span class=\"page_title text-primary\">New Stock History: </span></h3> <thead><td>Medicine Type</td><td>Medicine_Name</td><td>Transaction Type</td><td>Amount</td><td>Updated By</td><td>Time</td></thead><tbody style=\"background-color:white;\">";

								temp+=k;

								temp+="</tbody></table></div>";

								$(".credit_history").html(temp);

								$("#history_table").DataTable();

						}

							   

							}); 

			});

			</script>

		</div>

</div>

<!--End stock credit history-->

	<?php

}

else if($_GET['status']=="debit")

{

	?>

<div class="row">

	<div class="col-lg-12 col-sm-12 col-md-12 debit_history">

		<script>

			$(function(){

			$.ajax({

							   url:"../08common/dataprocess.php",

							   data:{'order_type':'debit_history'},

							   method:'POST',

							   success: function(data){

							   var k=data;

							   //console.log(data);

								var temp="<div class='table-responsive'><table class='table table-bordered' id='history_table' width='100%'  cellspacing='0'><h3><span class=\"page_title text-primary\">Invoice Stock History: </span></h3> ";

								temp+="<thead><th>Patient_ID</th><th>Medicine Type</th><th>Medicine_Name</th><th>Amount</th><th>Time</th></thead>";

								temp+='<tbody style="background-color:white;" >';

								temp+=k;

								temp+="</tbody></table></div>";

								$(".debit_history").html(temp);

								$("#history_table").DataTable();

						}

							   

							}); 

			});

			</script>

	</div>

</div>

	<?php

}

else if($_GET['status']=="available")

{

	?>

<div class="row">

	<div class="col-lg-12 stock_available">

		<script>

		$(function(){

			$.ajax({

						   url:"../08common/dataprocess.php",

						   data:{'order_type':'stock_available'},

						   dataType: 'text',

						   method:'POST',

						   success: function(data){

						   var k=data;

							var temp=" <div class='table-responsive'><table class='table table-bordered' id='available_table' width='100%'' cellspacing='0'><h3><span class=\"page_title text-primary\">Stock Available: </span></h3> <thead><th>Medicine Type</th><th>Medicine_Name</th><th>Basic</th><th>Package Weight</th><th>Net Contents</th><th>Available</th></thead><tbody style=\"background-color:white;\">";

							temp+=k;

							temp+="</tbody></table></div>";

							$(".stock_available").html(temp);

							$("#available_table").DataTable()

					}

						   

						}); 

		});

		</script>

	</div>

</div>

	<?php

}



?>

	</div>

</div><!--End of container -->





<?php include '../02ui/commonfiles/footer.php'; ?>

<!-- Custom Scripts -->

<script src="../02ui/scripts/stock.js"></script>