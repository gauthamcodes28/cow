$(document).ready(function(){

	

$("#upload_Multiple").on('submit',function(e)
	{
		//alert('entered');
		e.preventDefault();
		$.ajax({
				url: 'files_upload.php',
				method: 'POST',
				data:new FormData(this),
				contentType: false,
				processData: false,
				success: function(data) {
				  // alert("Files Uploaded Successfully");
				}
			});
	});
	
});