/* $(window).on('load',(function() {
    // page is fully loaded, including all frames, objects and images
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

		
})); *//* 
$(document).ready(function() {
//For Search Criterias
$("#myInput").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#myTable tr").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
    });
  });
   $("#searchpid").on("keyup", function() {
	    //alert($("#searchbutton").val());
	   $("#searchbutton").trigger("click");
   });
}); */
$(document).ready(function(){
  $('#login-trigger').click(function(){
	  alert("new click");
    $(this).next('#login-content').slideToggle();
    $(this).toggleClass('active');          
    
    if ($(this).hasClass('active')) $(this).find('span').html('&#x25B2;')
      else $(this).find('span').html('&#x25BC;')
    })
});