

$(document).ready(function() {


//  Configure a few settings and attach camera

    Webcam.set({
        width: 250,
        height: 250,
        image_format: 'jpeg',
        jpeg_quality: 90
    });
  
    Webcam.attach( '#my_camera' );
  
   




	//to delete the prepopulated file list of the previous documents.. of the patient.
	$(".view_reports").on('click','.delete_file',function(e){
		// console.log("inside delete file");
		// console.log($(this).closest("td").siblings(".file_name").find("a").attr("href"));
		var e = confirm("Are you Sure to delete.");
		if(e)
		{
		var dump_name = $(this).closest("td").siblings(".file_name").find("a").attr("href");
		var data = dump_name.split("/");
		var name = data[data.length-1];
		var id = $("#printpid").val();
		//console.log(name);
		var t = $(this);

			$.ajax({
								url:"../08common/dataprocess.php",
								dataType:"TEXT",
								data:{"order_type":"delete_file","name":name,"id":id},
								method:'POST',
								success:function(data){
									// console.log("inside delete file success");
									// console.log(data);
									t.closest("tr").remove();
								},
								error:function(data)
								{

									console.log("error file delete:"+data);
								}
								
							});
		}
		else
		{
			alert("not deleted.");
		}
	});
	

	 //$( ".ostate" ).hide();
     //$('.js-example-basic-multiple').select2();
	 $("#upload_Multiple_Existing").on('submit',function(e)
	{
		
		//alert('entered');
		e.preventDefault();
		var id=$("#printpid").val();
		var visit=$("#visit").val();
		$.ajax({
				url: '../08common/dataprocess.php',
				method: 'POST',
				data:new FormData(this),
				contentType: false,
				processData: false,
				success: function(data) {
				  // alert("Files Uploaded Successfully");
				  console.log("inside the upload files success function");
				  console.log(data);
					alert("Data has be saved Successfully");
					$("#patient_id").val(id);
					$("#visit_number").val(visit);
					$("#submit").trigger("click");
				}
			});
	});
	
	$("#upload_Multiple_New").on('submit',function(e)
	{
		//alert('entered');
		e.preventDefault();
		$.ajax({
				url: '../08common/dataprocess.php',
				method: 'POST',
				data:new FormData(this),
				contentType: false,
				processData: false,
				success: function(data) {
				  // alert("Files Uploaded Successfully");
				  console.log("inside the upload files success function");
				  console.log(data);
						alert("Data has been saved Successfully.");
						var id=getCookie('id');
						var visit='1';
						$("#patient_id").val(id);
						$("#visit_number").val(visit);
						console.log(id+"&"+visit+"from new save js");
						$("#submit").trigger("click");
				}
			});
	});
	 
$("#addfollow").click(function(){
		var id=$("#printpid").val();
		var visit=$("#visit").val();
		document.cookie="id="+id+";path=/";
		document.location.href="prescription.php?status=followup";
	});
	 
	 
//For Country anad State
$('#country').change(function() {

  if($("#country").val()== "ind") {

  $("#ostate").val("");

  $( ".state" ).show();

  $( ".ostate" ).hide();

  }

  if($("#country").val()=="out") {

  $("#state").val("");

  $( ".state" ).hide();

  $( ".ostate" ).show();

  }

});

		//For Image Preview
			//$("#file").hide();
	$("#blah").click(function(){
				$("#file").trigger("click");
				
			});
			
			
	$("#dob").change(function(){
    	var value=$("#dob").val();
    	 var today = new Date();
    var birthDate = new Date(value);
    var age = today.getFullYear() - birthDate.getFullYear();
    var m = today.getMonth() - birthDate.getMonth();
    if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) 
    {
        age--;
    }
    document.getElementById("age").value=age;

    });
	
	$('.checkall').on('click', function () {
		//console.log($(this));
        var $this = $(this);
		var set=$(this);
		set.closest('#medicine_part').find('.head_type').each(function(){
			//console.log($(this).find('li:first').find('li:first').children());
			var box=$(this).find('li:first').find('li:first').children();
			if(set.prop('checked')==true)
			{
				console.log('checked');
				box.attr('checked','checked');
			}
			else
			{
				console.log('no');
				box.attr('checked',false);
			}
		});
           /*  // Test to see if it is checked
            checked = $this.prop('checked'),
            //Find all the checkboxes
            cbs = $this.closest('table').children('tbody').find('.checkbox');
        // Check or Uncheck them.
        cbs.prop('checked', checked);
        //toggle the selected class to all the trs
        cbs.closest('tr').toggleClass('selected', checked); */
    });
	


  
	
//Select name on change gets data 
$(document).on("change", ".select_name" , function() {
							//alert($(this).val());
							
							//This is the td of the select_tag
							var td=$(this).closest('td');
							var name=td.children().val();
							
							//console.log($(this));
							//console.log(name);
							$.ajax({
								url:"../08common/dataprocess.php",
								dataType:"JSON",
								data:{"order_type":"select_tag_name","name":name},
								method:'POST',
								success:function(data){
									//console.log(data);
									
									//console.log("data returned here");
									var available_td=td.siblings(".available_td").children();
									available_td.val(data.available+data.unit);
									
									//console.log(data.available);
									var basic=td.siblings(".basic_td").children();
									basic.val(data.basic+''+data.unit);
									var given_step=td.siblings(".given_td").children();
									//Step attr for given input field for multiples of basic quantity
									given_step.attr('step',data.basic);
									given_step.val(0);
								},
								error:function(data)
								{
									console.log("error:"+data);
								}
								
							});
							//console.log(how.val(23));
							//var nex=td.next().children();
							//nex.val(21);
						});


	
//New Patient details saved to DB
	$('#save').on('click',function(){
	//Section 1
	var printpid=document.getElementById("printpid").value;
	
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
	var email=document.getElementById("email").value;

	//alert(vedapulse)
	
	//Medicines Data Entry
	
		//All arrays to store the data of each row in sequence
	var ai=[];
	var type_name=[];
	var code_val=[];
	var billable=[];
	var selectname=[];
	var given=[];
	var available=[];
	var basic=[];
	
	//Single value for every type..
	var quantity=[];
	var whenval=[];
	var how=[];
	
	var next;
	//i is for inside table,
	var i=0;
	
	var flag = true;
	
	//console.log($('.given_value'));
	var next;
	// console.log("medicine data");
	//Data Scriptting for new medicine part
	$("#medicine_part  .type_name").each(function(){
		//console.log($(this));
		var h = $(this);
//		console.log(h);
		var type = h.find(".name").text();


		var c = h.find(".code").text();

		
		// console.log(c);

		var inflag=true;//is to avoid the first  tr of the medicine part..


		var t = h.next().children().children("table");
		var first = t.children("tbody").children("tr:nth-child(1)");
		var q = first.find(".quantity_td").children().val();
		var h = first.find(".how_td").children().val();
		var w = first.find(".when_td").children().val();
		//console.log(q+h+w);
	
		t.find("tbody").children("tr").each(function(){
			
				ai[i] = $(this).children(".ai_td").children().val();
				//console.log($(this).children());
				type_name[i] = type;
				code_val[i] = c;
				//console.log($(this).children(".billable_td").children().prop("checked"));
				if($(this).children(".billable_td").children().prop("checked"))
					billable[i]='yes';
				else
					billable[i]='no';

				selectname[i] = $(this).children(".name_td").children().val();
				given[i] = $(this).children(".given_td").children().val();
				quantity[i] = q;
				whenval[i] = w;
				how[i] = h;
				i++;
				

			
		}); //tbody tr each function

		//console.log(h.next().children().children("table"));
		//h.next().
	}); // end of medicinepart
	// console.log(selectname);

	var order = $("#order_type").val();
	
	if(order=='newsave')
	{

	}
	else if(order=='updatesave')
	{

	}
	else if(order=='followsave')
	{

	}


	
	
	
	

//flag validaton start
	// if(pname=='')
	// {
	// 	alert('Enter Name');
	// 	flag=false;
	// }
	//  else if(typeof(gender) == 'undefined')
	// {
	// 	alert('select gender');
	// 	flag=false;
	// }
	//  else if(branch=='')
	// {
	// 	alert('select location');
	// 	flag=false;
	// }
	//  else if(age.length==0)
	// {
	// 	alert('set the date of birth');
	// 	flag=false;
	// }
	//  else if(vikruthi==''  )
	// {
	// 	alert('select vikruthi');
	// 	flag=false;
	// }
	// else if(typeof(vedapulse) == 'undefined' )
	// {
	// 	alert('select vedapulse');
	// 	flag=false;
	// }
	// else if(country.length==0  )
	// {
	// 	alert('select country');
	// 	flag=false;
	// } 
	// else {
		
	// 	 if(country =='ind' )
	// 	{
	// 		if(state.length==0)
	// 			{
	// 				alert('select state');
	// 				flag=false;
	// 			}
	// 	}
	// 	if(country =='out' )
	// 	{
	// 		if(ostate.length==0)
	// 			{
	// 				alert('empty other state');
	// 				flag=false;
	// 			}
	// 	}
	// }
	// if(selectname.length==0)
	// {
	// 	flag=false;
	// 	alert('no medicine selected');
	// }
	
	
			
	flag=true;	
			
	if(flag)
	{
			var ai_val=ai.join();
			var type=type_name.join();
			var cde = code_val.join();
			var bill=billable.join();
			var name=selectname.join();
			var give=given.join();
			var aval=available.join();
			var bas=basic.join();
			var qty=quantity.join();
			var wh=whenval.join();
			var hw=how.join();
			//console.log(type+bill);
//alert(type_name+billable+selectname+given+available+basic+quantity+whenval+how);
	//console.log(type_name+billable+selectname+given+available+basic+quantity+whenval+how);
	//ENd of Medicine data Entry
	
	
		//Problem Data
	 var problem=document.getElementById("problem").value;
	 var mod=document.getElementById("mod").value;
	 var ayur=document.getElementById("ayur").value;
	 //alert(problem+mod+ayur);
	 //INSTRUCTIONS
	 var dan=document.getElementById("dan").value;
	 var pan=document.getElementById("pan").value;
	 var yoga=document.getElementById("yoga").value;
	 var inst=document.getElementById("inst").value;
	 var stop=document.getElementById("stop").value;
	 var start=document.getElementById("start").value;
	 var other1=document.getElementById("other1").value;
	 var other2=document.getElementById("other2").value;
	 //alert(dan+pan+yoga+inst+stop+start+other1+other2);
	
	//as all things  server by ../08common/dataprocess.php to avoid naming conflicts from witht he existing functions we use this variable


	var file_data = $('#file')[0].files[0];   // Getting the properties of file from file field
	var form_data = new FormData();                  // Creating object of FormData class
	form_data.append("image", file_data)              // Appending parameter named file with properties of file_field to form_data
	form_data.append("printpid", printpid)
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
	form_data.append("email", email)
	form_data.append("type_name",type)
	form_data.append("code",cde)
	form_data.append("ai",ai_val)
	form_data.append("billable",bill)
	form_data.append("selectname",name)
	form_data.append("given",give)
	form_data.append("available",aval)
	form_data.append("basic",bas)
	form_data.append("quantity",qty)
	form_data.append("how",hw)
	form_data.append("whenval",wh)
	form_data.append("mod", mod)
	form_data.append("problem", problem)
	form_data.append("ayur", ayur)
	form_data.append("dan", dan)
	form_data.append("pan", pan)
	form_data.append("yoga", yoga)
	form_data.append("inst", inst)
	form_data.append("start", start)
	form_data.append("stop", stop)
	form_data.append("other1", other1)
	form_data.append("other2", other2)
	form_data.append("order_type",order)

	$.ajax({
        url: "../08common/dataprocess.php",
        data: form_data,
        cache: false,
        processData: false,
        contentType: false,
        type: 'POST',
        success: function (data) {
            // do something with the result
            console.log(data);
			// if(devmode){
			console.log("start of success function");
			// //console.log(dataofconfirm);
			// }
			
			// if(devmode){
			// console.log("end of success function");
			// }
			
			//Upload Files code start
		if(data.flag)
		{
			var printpid=getCookie('id');
			console.log("data from newsave:"+data);
			var temp='<input type="text" id="files_id" name="files_id" value='+printpid+' />';
			temp+='<input type="text" id="files_visit" name="files_visit" value='+visit+' />';
			temp+='<input type="text" id="order_type" name="order_type" value="uploadfiles" />';
			$("#upload_Multiple_New").append(temp);
			$("#upload_Multiple_New").submit();
			//Upload files code end
		}
		else
		{
			alert("Failure");
		}
			


        },
        error:function(){
        	console.log("Error:Save");
        }
    });
	//preloader
	$(".se-pre-con").show();
	
	
	
	

	


	}//End of flag check flag for validations true
	if(devmode)
		console.log("End of newsave click function");
  });//end of save


		//Add Type  Row WHen selected the select box for the type name
var code =0;
$(".add-row").click(function(){
			if(devmode)
			{
				console.log("start add-row js function");
			}
		var val = [];
		var i=0;
		var flag=1;
            var name = $("#sel1").val();
		
			
			// $("#medicine_part h2").each(function(){
			// 	if(name == $(this).text())
			// 		flag=0;
			// 	//console.log(this);
			// });
			
			
			

				//console.log(name);
				$.ajax({
					url:'../08common/dataprocess.php',
					dataType:"JSON",
					method:"POST",
					data:{"order_type":"new_type_row","name":name},
					success:function(data){
						//Returns the options values for the row to be appended 
						//console.log(data);
						code++;
						var temp="";
						temp+='<a class="delete-row" style="color:red;text-decoration: underline;">Delete Type</a>';
				temp+='<h2 class="type_name" > <i class="name">'+name+'</i> <i class="code">'+code+'</i></h2>';
temp+='<div>';
	temp+='<div class="tablewrapper" style="max-width: 100%;max-height: 100%;">';
		temp+='<a  class="plus_sign" style="color:red;text-decoration: underline;" >+Add More</a>';
		temp+='		<table  class="responsive inner_table"  width="98%" cellpadding="4" cellspacing="1" border="0">';
					temp+='<thead>';
					temp+='	 	<th>Billable</th>';
					temp+='	 	<th>Name</th>';
					temp+='	 	<th>Given</th>';
						temp+=' 	<th>Available</th>';
						temp+=' 	<th>Basic</th>';
						temp+=' 	<th>Delete</th>';
					temp+='	 	<th>Quantity </th>';
					temp+='		<th>When</th>';
					temp+='		<th>How</th>';
					temp+='	</thead>';
					temp+='<tbody>';
					temp+='	<tr>'; 
					temp+='<td class="ai_td" style="display:none;"><input type="number" class="ai" value="0" ></td>';
					temp+='		<td class="billable_td"><input class="editable form-control" type="checkbox" style="width:20px;" /></td>';
					temp+='	 	<td class="name_td">';
					temp+='	 		<select class="form-control editable select_name">';
					temp+='	 			<option disabled selected>select</option>';
									for(var i=0;i<data.length;i++)
													{
														temp+='<option>'+data[i]+'</option>';
													}
					temp+='	 		</select>';
					temp+='	 	</td>';
					temp+='	 	<td class="given_td"><input class="form-control editable" style="width:100px"  type="number" value="" placeholder="xBasic" step=""/></td>';
					temp+='	 	<td class="available_td"><input class="form-control editable" style="width:100px"  type="text" value="" placeholder="Available" disabled/></td>';
					temp+='	 	<td class="basic_td"><input class="form-control editable" style="width:80px"   type="text" value="" placeholder="Basic" disabled/></td>';
					temp+='	 	<td></td>';

					temp+='	 	<td class="quantity_td" rowspan="1"><textarea class="form-control editable"  type="text"   name="qty[]" ></textarea></td>';
					temp+='		<td class="when_td" rowspan="1"><textarea  class="form-control editable" type="text"   name="when[]"></textarea></td>';
					temp+='		<td class="how_td" rowspan="1"><textarea class="form-control editable" type="text"   name="how[]" value="With Hot water"></textarea></td>';
					temp+='	</tr>';
				temp+='</tbody>';
					
				temp+='</table>';
			temp+='</div>';
temp+='</div>';

						$("#medicine_part").find("#accordion").append(temp);
					$( "#accordion" ).accordion( "refresh" );
					
					}
				});
		
	if(devmode)
			{
				console.log("ENd add-row js function");
			}
        });//End OF Add-Row	
	
	//Add sub medicine row
$('#medicine_part').on('click','.plus_sign',function(plus){
	//console.log("plus");

	//var type = "Ark";
	//console.log(type);
	var current=$(this);
	//console.log(current.parent().parent().siblings(".type_name").text());
	var type = current.parent().parent().prev().find(".name").text();
	//var str=type.toString();
	//console.log(str);
	//console.log(type);
	//console.log($(this).closest('td').siblings('.insidetable').find('tbody'));
			  $.ajax({
					   url:"../08common/dataprocess.php",
					   dataType:"TEXT",
					   method:"POST",
					   data:{"subname":type,"order_type":"plus_sign_add"},
					   success: function(data){
						 // console.log(data);

						 var first = current.siblings(".inner_table").children("tbody").children("tr:nth-child(1)");
//Setting the rowspan and height of the element
// console.log(first);
						 var newset;
						 var temp;
				//for quantity td
						 temp = first.children(".quantity_td").attr("rowspan");
						 //console.log(temp);
						 newset = +temp+1;
						 first.children(".quantity_td").attr("rowspan",newset);

						 temp = first.children(".quantity_td").children("textarea").css("height");
						 newset = parseInt(temp)+40;
						 first.children(".quantity_td").children().css("height",newset+'px');

				//for when td
						 temp = first.children(".when_td").attr("rowspan");
						 //console.log(temp);
						 newset = +temp+1;
						first.children(".when_td").attr("rowspan",newset);

						 temp = first.children(".when_td").children("textarea").css("height");
						 newset = parseInt(temp)+40;
						first.children(".when_td").children().css("height",newset+'px');
				//for how td
						 temp = first.children(".how_td").attr("rowspan");
						 //console.log(temp);
						 newset = +temp+1;
						 first.children(".how_td").attr("rowspan",newset);

						 temp = first.children(".how_td").children("textarea").css("height");
						 newset = parseInt(temp)+40;
						 first.children(".how_td").children().css("height",newset+'px');



						 //console.log(temp);
						 //console.log(current.siblings(".inner_table").children("tbody").children("tr:nth-child(2)").children(".set_size").attr("rowspan","2"));
						 current.siblings(".inner_table").append(data);

						//current.closest('.head_type').find('.inner_table').find('tbody').append(data);
						//console.log(data);
						 },
						 error:function(){
						 	console.log("plus_sign error");
						 }

					});
			 //console.log(type);
			});
	//END Add sub medicine row
	
// Find and remove selected table rows
        $("#medicine_part").on("click",".delete-row",function(){
			
    //         $("#medicine_part").find('input[name="type_checked"]').each(function(){
				// //console.log(this);
    //         	if($(this).is(":checked")){
    //                 $(this).parents("ul").remove();
    //             }
    //         });
    	$(this).next().remove();
    	$(this).next().remove();
    	$(this).remove();

    	
    //	console.log("delete type");
        });
	
	//delete sub-medicine row
	$('#medicine_part').on('click','.delete_inside_row',function(){
	//console.log("Clicked Delete");
	//console.log(this);
	//console.log($(this).closest("tr").siblings("tr:nth-child(2)"));
	var current = $(this).closest("tr").siblings("tr:nth-child(2)");
	 		
	 		//Setting the rowspan and height
						 var newset;

				//for when td
						 var temp = current.children(".when_td").children().attr("rowspan");
						 //console.log(temp);
						 newset = +temp-1;
						 current.children(".when_td").children().attr("rowspan",newset);

						 temp = current.children(".when_td").children().css("height");
						 newset = parseInt(temp)-40;
						 current.children(".when_td").children().css("height",newset+'px');
				//for quantity td
						 var temp = current.children(".quantity_td").children().attr("rowspan");
						 //console.log(temp);
						 newset = +temp-1;
						 current.children(".quantity_td").children().attr("rowspan",newset);

						 temp = current.children(".quantity_td").children().css("height");
						 newset = parseInt(temp)-40;
						 current.children(".quantity_td").children().css("height",newset+'px');
				//for how td
						 var temp = current.children(".how_td").children().attr("rowspan");
						 //console.log(temp);
						 newset = +temp-1;
						 current.children(".how_td").children().attr("rowspan",newset);

						 temp = current.children(".how_td").children().css("height");
						 newset = parseInt(temp)-40;
						 current.children(".how_td").children().css("height",newset+'px');
						 


	$(this).closest('tr').remove();
	});

	
} );//Ready Function END


