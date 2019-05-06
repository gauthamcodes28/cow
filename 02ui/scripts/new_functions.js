
 function take_snapshot() {
        Webcam.snap( function(data_uri) {
            $(".image-tag").val(data_uri);
            document.getElementById('results').innerHTML = '<img style="padding-top: 30px;height: 219px;width: 251px;" src="'+data_uri+'"/>';
        } );
    }

function setCookie(cname, cvalue, exdays) {
  var d = new Date();
  d.setTime(d.getTime() + (exdays * 60 * 1000));
  var expires = "expires="+d.toUTCString();
  document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
}

function getCookie(cname) {
  var name = cname + "=";
  var ca = document.cookie.split(';');
  for(var i = 0; i < ca.length; i++) {
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

function checkCookie(name) {
  var user = getCookie(name);
  if (user != "") {
    return true;
  } else {
    user = prompt("Please enter your name:", "");
    if (user != "" && user != null) {
      setCookie("username", user, 365);
    }
  }
}




function followview()

{

	var id=$("#printpid").val();

	

	//to get the latest visist number from pateint_master

	$.ajax({

		url:'../08common/dataprocess.php',

		dataType:'JSON',

		method:'post',

		data:{'patient_id':id,'order_type':'setvisit'},

		success:function(data){

			console.log(data);



			

			var temp="<div class='form-group' style='margin-top:20px;'><select id='selvisit' class='form-control'>";

			for(var i=1;i<=data.visit;i++)

			{

				temp+="<option value='"+i+"'>"+i+"</option>";

			}

			temp+="</select></div>";

			$('#visit_container').html(temp);

		}

	}).done(function(datareturn){

		if(devmode)

		{

			console.log("outer success function start");

			console.log(datareturn.visit);

			console.log("inner success function end");

		}

	$.ajax({

		url:'../08common/dataprocess.php',

		dataType:'JSON',

		data:{'patient_id':id,'visit_number':datareturn.visit,'order_type':'viewmodeexisting'},

		method:'post',

		success:function(data){

				if(devmode){

					console.log(data);

					console.log("start success function");

				}

				var title="Existing Patients Follow Up";

				$("#head_title").children().html(title);

			//Pateint Details

			if(data.profilephoto=='')

				{

					$('#blah').attr('src','docs/sample.jpg');

				}

				else{

					$('#blah').attr("src", "./docs/"+data.patientid+"/"+data.profilephoto);

				}

			if(data.vedapulse=='yes')

				{

					

					$('.vedapulse:first').attr('checked', true);

					

				}

				else{

					$('.vedapulse:last').attr('checked', true);

				}

			

				if(data.gender=='Male'){

				$('.Gender:first').attr('checked', true);

				}

				else{

					

					$('.Gender:last').attr('checked', true);

				}

			

			$("#pname").val(data.pname);

			$("#phone").val(data.phone);

			$("#visit").val(parseInt(data.visit_number)+1);

			//console.log("::"+data.visit_number);

			$("#dob").val(data.dob);

			$("#age").val(data.age);

			$("#vikruthi").val(data.vikruthi);

			$("#location").val(data.branchid);

			

			$("#country").val(data.countryid);

				if(data.countryid == "ind"){

						$("#state").val(data.stateid);

						$('#ostate').parent().hide();

							}

							else{

								$("#ostate").val(data.stateid);

								$('#state').parent().hide();

							}

			

			$("#addredd").val(data.address);

			

			//problem data

			$("#problem").val(data.pdescription);

			$("#ayur").val(data.ayurvedic);

			$("#mod").val(data.modern);

			if(devmode)

			{

				console.log("end success function");

			}

			 //Previous Reports Data

			 var temp="<table class='table custom_table'>"

				temp+="<thead class='thead-dark'><tr><th>S.No</th><th>Name</th><th>Visit</th><th>Date</th><th>Delete</th></thead></tr>";

				temp+="<tbody>";

				for(var i=0;i<data.reports.name.length;i++)

				{	

					temp+="<tr><td>"+i+"</td><td class='file_name'><a href='"+data.reports.name[i]+"' target='_BLANK' >"+data.reports.name[i]+"</a></td><td>"+data.reports.visit[i]+"</td><td>"+data.reports.date[i]+"</td><td><a class='delete_file'>  <span class='glyphicon glyphicon-remove-sign'></span></a></td></tr>";



				}

				temp+="</tbody>";

			 temp+="</table>";

			 $(".view_reports").append(temp);

			

		}//END of AJax Success function

		

		});//end of inside ajax function

	});//end of outer ajax done function

	



}



function viewmode(id,visit=1){

	if(devmode)

	{console.log("Entered viewmode js function");}

	//console.log(id+'&'+visit);



	

	$("#printpid").val(id);

	

	$.ajax({

		url:'../08common/dataprocess.php',

		dataType:'JSON',

		method:'POST',

		data:{'patient_id':id,'visit_number':visit,'order_type':'viewmodeexisting'},

		success:function(data){

			//console.log(data);

			if(devmode)

					console.log("start viewmode success function");

			//console.log(data);

			

			//Pateint Details

			if(data.profilephoto=='')

				{

					$('#blah').attr('src','./docs/sample.jpg');

				}

				else{

					$('#blah').attr("src", "./docs/"+data.patientid+"/"+data.profilephoto);

				}

			if(data.vedapulse=='yes')

				{

					

					$('.vedapulse:first').attr('checked', true);

					

				}

				else{

					$('.vedapulse:last').attr('checked', true);

				}

			

				if(data.gender=='Male'){

				$('.Gender:first').attr('checked', true);

				}

				else{

					

					$('.Gender:last').attr('checked', true);

				}

			

			$("#pname").val(data.pname);

			$("#phone").val(data.phone);

			$("#visit").val(visit);

			$("#email").val(data.email);

			$("#dob").val(data.dob);

			$("#age").val(data.age);

			$("#vikruthi").val(data.vikruthi);

			$("#location").val(data.branchid);

			

			$("#country").val(data.countryid);

				if(data.countryid == "ind"){

						$("#state").val(data.stateid);

						$('#ostate').parent().hide();

							}

							else{

								$("#ostate").val(data.stateid);

								$('#state').parent().hide();

							}

			

			$("#address").val(data.address);

			

			//problem data

			$("#problem").val(data.pdescription);

			$("#ayur").val(data.ayurvedic);

			$("#mod").val(data.modern);

			

			//instructions data

			 // $("#dan").val(data.dantmanjan);

			 $("#pan").val(data.panchakarma);

			 $("#yoga").val(data.yoga);

			 $("#inst").val(data.instructions);

			 $("#stop").val(data.stop);

			 $("#start").val(data.start);

			 $("#other1").val(data.other);

			 

			 //var test=JSON.parse(data);

			 

			 if(data.hasOwnProperty('reports'))

			 {

			 //Previous Reports Data

			 var temp="<table class='table custom_table'>"

				temp+="<thead class='thead-dark'><tr><th>S.No</th><th>Name</th><th>Visit</th><th>Date</th><th>Delete</th></thead></tr>";

				temp+="<tbody>";

				for(var i=0;i<data.reports.name.length;i++)

				{	var t=i+1;

					temp+="<tr><td>"+t+"</td><td class='file_name'><a target='_BLANK' href='./docs/"+data.patientid+"/Reports/"+data.reports.name[i]+"'>"+data.reports.name[i]+"</a></td><td>"+data.reports.visit[i]+"</td><td>"+data.reports.date[i]+"</td><td><a class='delete_file'>  <span class='glyphicon glyphicon-remove-sign'></span></a></td></tr>";

				}

				temp+="</tbody>";

			 temp+="</table>";

			 $(".view_reports").append(temp);

			 $(".delete_file").hide();

			 }

			

			setvisit(visit);
			viewmedicine(visit);

			

			if(devmode)

				console.log("end of ajax success function");

			

		},//END of AJax Success function

		error: function (jqXHR, exception) {

        var msg = '';

        if (jqXHR.status === 0) {

            msg = 'Not connect.\n Verify Network.';

        } else if (jqXHR.status == 404) {

            msg = 'Requested page not found. [404]';

        } else if (jqXHR.status == 500) {

            msg = 'Internal Server Error [500].';

        } else if (exception === 'parsererror') {

            msg = 'Requested JSON parse failed.';

        } else if (exception === 'timeout') {

            msg = 'Time out error.';

        } else if (exception === 'abort') {

            msg = 'Ajax request aborted.';

        } else {

            msg = 'Uncaught Error.\n' + jqXHR.responseText;

        }

       console.log("error from viewmode:"+msg);

		}

	});//end of ajax function

	

	
	

	if(devmode)

	console.log("Exited viewmode js function");

	

}//end of viewmode



function online_patient_view(id,visit=1)

{

	if(devmode)

	console.log("Entered online_patient_view");

console.log(id+'<-id');

	$("#printpid").val(id);

	

	$.ajax({

		url:'../08common/dataprocess.php',

		dataType:'JSON',

		method:'POST',

		data:{'patient_id':id,'visit_number':visit,'order_type':'online_patient_view'},

		success:function(data){

			//console.log(data);

			if(devmode)

					console.log("start viewmode success function");

			console.log(data);

			

			//Pateint Details

			if(data.profilephoto=='')

				{

					$('#blah').attr('src','./docs/sample.jpg');

				}

				else{

					$('#blah').attr("src", "./docs/"+data.patientid+"/"+data.profilephoto);

				}

			if(data.vedapulse=='yes')

				{

					

					$('.vedapulse:first').attr('checked', true);

					

				}

				else{

					$('.vedapulse:last').attr('checked', true);

				}

			

				if(data.gender=='Male'){

				$('.Gender:first').attr('checked', true);

				}

				else{

					

					$('.Gender:last').attr('checked', true);

				}

			

			$("#pname").val(data.pname);

			$("#phone").val(data.phone);

			$("#visit").val(visit);

			

			$("#dob").val(data.dob);

			$("#age").val(data.age);

			$("#vikruthi").val(data.vikruthi);

			$("#location").val(data.branchid);

			

			$("#country").val(data.countryid);

				if(data.countryid == "ind"){

						$("#state").val(data.stateid);

						$('#ostate').parent().hide();

							}

							else{

								$("#ostate").val(data.stateid);

								$('#state').parent().hide();

							}

			

			$("#address").val(data.address);

			$("#email").val(data.email);

			//problem data

			$("#problem").val(data.pdescription);

			$("#ayur").val(data.ayurvedic);

			$("#mod").val(data.modern);

			

		

			 

			 //var test=JSON.parse(data);

			 

			 if(data.hasOwnProperty('reports'))

			 {

				 console.log("Entered reports");

			 //Previous Reports Data

			 var temp="<table class='table custom_table'>"

				temp+="<thead class='thead-dark'><tr><th>S.No</th><th>Name</th><th>Visit</th><th>Date</th><th>Delete</th></thead></tr>";

				temp+="<tbody>";

				for(var i=0;i<data.reports.name.length;i++)

				{	var t=i+1;

					temp+="<tr><td>"+t+"</td><td><a target='_BLANK' href='./docs/"+data.patientid+"/Reports/"+data.reports.name[i]+"'>"+data.reports.name[i]+"</a></td><td>"+data.reports.visit[i]+"</td><td>"+data.reports.date[i]+"</td><td><a class='delete_file'>  <span class='glyphicon glyphicon-remove-sign'></span></a></td></tr>";

				}

				temp+="</tbody>";

			 temp+="</table>";

			 $(".view_reports").append(temp);

			

			 }

			

			setvisit(visit);

			

			if(devmode)

				console.log("end of ajax success function");

			

		},//END of AJax Success function

		error: function (jqXHR, exception) {

        var msg = '';

        if (jqXHR.status === 0) {

            msg = 'Not connect.\n Verify Network.';

        } else if (jqXHR.status == 404) {

            msg = 'Requested page not found. [404]';

        } else if (jqXHR.status == 500) {

            msg = 'Internal Server Error [500].';

        } else if (exception === 'parsererror') {

            msg = 'Requested JSON parse failed.';

        } else if (exception === 'timeout') {

            msg = 'Time out error.';

        } else if (exception === 'abort') {

            msg = 'Ajax request aborted.';

        } else {

            msg = 'Uncaught Error.\n' + jqXHR.responseText;

        }

       console.log("error from viewmode:"+msg);

		}

	});//end of ajax function

	

}//end of online_patient_view



function setvisit(visit=1){

	//this function returs only the visit number from patient master

	if(devmode)

	{

		console.log("start setvisit js function");

	}

	var id=$('#printpid').val();

	console.log(id);

	$.ajax({

		url:'../08common/dataprocess.php',

		dataType:'JSON',

		method:'post',

		data:{'patient_id':id,'order_type':'setvisit'},

		success:function(data){

			console.log(data);

			var temp="<div class='form-group' style='margin-top:20px;'><select id='selvisit' class='form-control'>";

			for(var i=1;i<=data.visit;i++)

			{

				if(i==visit)

					temp+="<option selected value='"+i+"'>Visit:"+i+"</option>";

				else

					temp+="<option value='"+i+"'>Visit:"+i+"</option>";

			}

			temp+="</select></div>";

			

			$('#visit_container').html(temp);

			

		},

		error:function(jqXHR, exception)

		{

			console.log(jqXHR+" and "+exception);

		}

		

	});

	

	if(devmode)

		console.log("end of setvisit js function");

	

	

}

function setheight(){

	$(".inner_table").each(function(){

		// console.log($(this));

		var current = $(this);

		var num_rows = current.children("tbody").children().length;

		// console.log(num_rows);

		

		//console.log(current.children("tbody").children().length);

		var first = current.children("tbody").children("tr:nth-child(1)");



//quantity_td

		first.children(".quantity_td").attr("rowspan",num_rows);

		first.children(".quantity_td").children().css("height",num_rows * 40 +'px');

//when_td

		first.children(".when_td").attr("rowspan",num_rows);

		first.children(".when_td").children().css("height",num_rows * 40 +'px');

//how_td

		first.children(".how_td").attr("rowspan",num_rows);

		first.children(".how_td").children().css("height",num_rows * 40 +'px');



		//console.log(current.children("tbody").children("tr:nth-child(2)"));

	});

	$(".delete-row").hide();

	$(".plus_sign").hide();

	$('.delete_inside_row').hide();

}

//view medicine used to pre-populate the medicine data in view mode after save. 

function viewmedicine(visitpar){

	
	var id = $("#printpid").val();
	console.log("view medicine start");

	var currentvisit=visitpar;

	console.log(currentvisit+"::Visit");

	// $("#medicine_part").html("<i></i>"); //important to replace the content


$.ajax({

		url:'../08common/dataprocess.php',
		dataType:'JSON',
		data:{'order_type':'viewmedicine','pid':id,'visit':currentvisit},
		method:'post',
		success:function(data){
			// console.log(data);
							var temp='';

				for(var i=0;i<data.code.length;i++)
				{
					// console.log("out");
			
					// console.log(data.tid[i]);

					var cnt=1;

											//console.log("inside:"+val);

											temp+='<a class="delete-row" style="color:red;text-decoration: underline;">Delete Type</a>';

											temp+='<h2 class="type_name"><i class="code">'+data.code[i]+'</i><i class="name">'+data.type[i]+'</i></h2>';

									temp+='<div>';

										temp+='<div class="tablewrapper" style="max-width: 100%;max-height: 100%;">';

											temp+='<a  class="plus_sign" style="color:red;text-decoration: underline;" >+Add More</a>';

												temp+='<table  class="responsive inner_table"  width="98%" cellpadding="4" cellspacing="1" border="0">';
												temp+='<thead>';

																	temp+='	 <tr> ';

																	temp+='	 	<td>Billable</td>';

																	temp+='	 	<td>Name</td>';

																	temp+='	 	<td>Given</td>';

																	temp+=' 	<td>Available</td>';

																	temp+=' 	<td>Basic</td>';

																	temp+=' 	<td>Delete</td>';

																	temp+='	 	<td>Quantity</td>';

																	temp+='		<td>When </td>';

																	temp+='		<td>How</td>';

																	temp+='	</tr>';


										temp+='</thead>';			
										temp+='<tbody>';
												
			for(var j=0;j<data.val.visit.length;j++)
			{
				// console.log(data.val.tid[j]+'out->>');
				if(data.code[i]==data.val.code[j])
				{

						// console.log(data.val.tid[j]+'in->>');

					

						temp+='<tr>';
							temp+='<td class="ai_td"  style="display:none;"><input type="number" class="ai" value="'+data.val.ai[j]+'" ></td>';
							if(data.val.bill[j]=='yes')

								temp+='<td class="billable_td"><input class="editable" type="checkbox" checked style="width:20px;" /></td>';

							else

								temp+='<td class="billable_td"><input class="editable " type="checkbox" style="width:20px;" /></td>';

							temp+='<td class="name_td">';

											temp+='<select class=" form-control editable select_name">';

											temp+='<option disabled selected>select</option>';

								for(var k=0;k<data.options.id.length;k++)

								{
								if(data.options.id[k]==data.val.tid[i])
									if(data.options.name[k]==data.val.mname[j])

										temp+='<option selected>'+data.options.name[k]+'</option>';

									else

										temp+='<option>'+data.options.name[k]+'</option>';

								}

							temp+='</select>';

							temp+='</td>';



							temp+='	<td class="given_td"><input class="form-control editable" style="width:100px"  type="number" value="'+data.val.given[j]+'" placeholder="xBasic" step="'+data.val.unit[j]+'"/></td>';

							temp+='<td class="available_td"><input class="form-control editable" style="width:100px"  type="text" value="'+data.val.available[j]+'" placeholder="Available" disabled/></td>';

							temp+='<td class="basic_td"><input class="form-control editable" style="width:80px"   type="text" value="'+data.val.basic[j]+'" placeholder="Basic" disabled/></td>';

							temp+='<td><a class="delete_inside_row">  <span class="glyphicon glyphicon-remove-sign"></span></a></td>';

							

						if(cnt==1)

						{

							temp+='<td class="quantity_td" rowspan="1"><textarea class="form-control editable"  type="text"   name="qty[]" >'+data.val.qnt[j]+'</textarea></td>';

							temp+='<td class="when_td" rowspan="1"><textarea  class="form-control editable" type="text"   name="when[]">'+data.val.when[j]+'</textarea></td>';

							temp+='<td class="how_td" rowspan="1"><textarea class="form-control editable" type="text"   name="how[]" value="With Hot water">'+data.val.how[j]+'</textarea></td>';

						}												

						temp+='</tr>';

						cnt++;

					

				}//to check for the visit number match from pdata.json file and the visit number selected and if(out.name==inside.Type_Name)
			}

											temp+='</table>';

										temp+='</div>';

									temp+='</div>';

			
					
				}//for all the other types 

				//for asava and choornam
				
						

								//console.log(temp);

									$("#accordion").html(temp);	

									$(".editable").prop("disabled",true);

									$( "#accordion" ).accordion({

									    	header: "h2",

									    	collapsible: true,

									    	heightStyle: "content"

									   });	
									$( "#accordion" ).accordion("refresh");

							setheight();//for the quantity,how,when area tags height adjustment..

							

						
			

			//$(".editable").prop("disabled",true);



		},
		error:function(){
			console.log("error viewmedicine");
		}

	});//outer ajax function

}







function delete_file(p)

{

	var s = p.closest("tr");

	

	p.remove();

	s.remove();

	

}

function new_file(){

		var current_count=$('input[type="file"]').length;

		var next_count=current_count+1;

		$("#upload_add_more").append('<tr><td><input type="file" name="images[]"/></td><td><input type="button" class="btn btn-danger " value="delete" onClick="delete_file(this);" /></td></tr>');

		//$("#upload_add_more input").css("padding","3px 3px 5px 0px");

}									

							

		

function search(){

	$("#pro").show();

	var tmp=$("#searchpid").val();

        $.ajax({

           url:"searchpatient.php",

           dataType: 'text',

		   data:{'searchpid':tmp},

           success: function(data){

           var k=data;

            var temp="</br></br><div class='row abc'> <div class='row'><div class='col-sm-4'></div><div class='col-sm-4'></br></div><div class='col-sm-4'></div></div><div class='row'><div class='col-sm-12'><div class='card-body'> <div class='table-responsive'><table class='table table-bordered' id='dataTable' width='100%'' cellspacing='0'><thead><td>Id</td><td>Name</td><td>Phone</td><td>Age</td><td>Country</td><td>State</td></thead><tbody id='myTable'>";

			temp+=k;

			temp+="</tbody></table></div></div></div></div></div>";

			pro.innerHTML=temp;

			$("#dataTable").DataTable()

    }

		   

		});

			

}



function readURL(input) {

            if (input.files && input.files[0]) {

                var reader = new FileReader();



                reader.onload = function (e) {

                    $('#blah')

                        .attr('src', e.target.result)

                        .width(150)

                        .height(100);

                };



                reader.readAsDataURL(input.files[0]);

            }

			

        }

		function hello()

		{

			alert("helo");

		}

		function selectAll(input)

		{

			if(input.checked==true)

			{

				//var temp=document.getElementsByClassName("ads_checkbox");

				//temp.prop("checked",true);

				$( ".ads_checkbox" ).each(function() {

					  $( this ).prop( "checked", true );

					});

			}

		}

		function sleep(milliseconds) {

			

			$(".se-pre-con").show();

		  var start = new Date().getTime();

		  for (var i = 0; i < 1e7; i++) {

			if ((new Date().getTime() - start) > milliseconds){

			  break;

			}

		  }

		  $(".se-pre-con").fadeOut("slow");

}

	