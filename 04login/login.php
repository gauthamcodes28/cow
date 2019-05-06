<?php
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}
$_SESSION['root']=$root;
?>
<!-- Login Modal -->
<div class="modal fade" id="LoginModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog modal-sm" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Login</h4>
      </div>
      <div class="modal-body">
        <form class="form-horizontal" method="post" action="index.php">

						<div class="form-group" style="margin:0px 0px 15px 0px;">
							<label for="username" class="cols-sm-2 control-label">Username</label>
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-users fa" aria-hidden="true"></i></span>
									<input type="text" autocomplete="username" class="form-control" name="username" id="username"  placeholder="Enter your Username"/>
								</div>
							</div>
						</div>

						<div class="form-group" style="margin:0px 0px 15px 0px;" >
							<label for="password" class="cols-sm-2 control-label">Password</label>
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-lock fa-lg" aria-hidden="true"></i></span>
									<input type="password" autocomplete="current-password" class="form-control" name="password" id="password"  placeholder="Enter your Password"/>
								</div>
							</div>
						</div>
						<div class="form-group" style="margin:0px 0px 15px 0px;">
							<button id="login_submit" type="button" class="btn btn-primary btn-lg btn-block login-button">Login</button>
						</div>

		</form>
      </div>

    </div>
  </div>
</div>
<script>
$(function(){
	$('#login_submit').on('click',function(){
		var devmode=true;
		if(devmode)
		console.log("login submit entered");
		var username=$("#username").val();
		var password=$("#password").val();
		var root=<?php echo '"'.$root.'"';?>;
		//console.log(username+password);
		$.ajax({
			url:"<?php echo $root;?>08common/dataprocess.php",
			dataType:"JSON",
			method:"POST",
			data:{"order_type":"login_validate",
				"user":username,
				"pass":password},
			success:function(data)
			{
				//console.log("Data:"+data);
				if(data.status)
				{
					document.location.href=root+"index.php?status=success";
				}
				else{
					document.location.href=root+"index.php?status=error";
				}
			},
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
				   console.log("error:"+msg);
					}
			
		});
	});
});
</script>