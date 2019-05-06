
<?php

error_reporting(E_ALL);
ini_set("display_errors", 1);

include ("../02ui/commonfiles/header.php");
?>

<script type='text/javascript'>
function refreshCaptcha(){
	var img = document.images['captchaimg'];
	img.src = img.src.substring(0,img.src.lastIndexOf("?"))+"?rand="+Math.random()*1000;
	
	//alert(img.src);
}
</script>

<!-- =======Home body content start ============ -->
  <!--==========================-->
  <!-- Start contact Area -->
  <div id="contact" class="contact-area">
    <div class="contact-inner area-padding">
      <div class="contact-overly"></div>
      <div class="container ">
      <h5  class="page_title">Contact Us</h5>
        <div class="row">
       <!-- Start  contact -->
          <div class="col-md-6 col-sm-6 col-xs-12">
          
            
               <!--<div id="sendmessage">Your message has been sent. Thank you!</div>-->
              <div id="errormessage"></div>
              
              <div class="col">
                <div class="form-group">
                   <label for="name">Name</label>
                  <input type="text" name="name" class="form-control" id="name" placeholder="Your Name" data-rule="minlen:4" data-msg="Please enter at least 4 chars" />
                  <div class="validation"></div>
                </div>
              </div>

              <div class="col">
                <div class="form-group">
                  <label for="email">Email</label>
                  <input type="email" class="form-control" name="email" id="email" placeholder="Your Email" data-rule="email" data-msg="Please enter a valid email" />
                  <div class="validation"></div>
                </div>
               </div>

              <div class="col">
                <div class="form-group">
                  <label for="subject">Subject</label>
                  <input type="text" class="form-control" name="subject" id="subject" placeholder="Subject" data-rule="minlen:4" data-msg="Please enter at least 8 chars of subject" />
                  <div class="validation"></div>
                </div>
               </div>
              <div class="col">
                <div class="form-group">
                   <label for="message">Message</label>
                  <textarea class="form-control" id="message" name="message" rows="5" data-rule="required" data-msg="Please write something for us" placeholder="Message"></textarea>
                  <div class="validation"></div>
                </div>
              </div>

              <div class="col">
                 <div class="form-group">
                  <label> Validation code:</label>
                  <input id="captcha_code" name="captcha_code" type="text">
                  <br>
                  <div><img src="../02ui/scripts/captcha/captcha.php?rand=<?php echo rand();?>" id='captchaimg'></div><br>
                  <p>Can't read the image? click <a href=""><span onclick='refreshCaptcha();'>here</span></a> to refresh.</p>
                </div>
              </div>

               <button type="button" class="btn btn-primary pull-right" id="send">Send Message</button>
            
          
       
          </div>

          <!-- Start Google Map -->
          <div class="col-md-5 col-sm-5 col-xs-12">
            <!-- Start Map -->
            <iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d7532.990252423315!2d76.771188!3d19.260823!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x53ad60f97b670c55!2sKamdhenu+Panchgavya+Ayurved+Kendra!5e0!3m2!1sen!2sin!4v1543583259195" width="460" height="450" frameborder="0" style="border:0" allowfullscreen></iframe><!-- End Map -->
          </div>
          <!-- End Google Map -->

   
          <!-- End Left contact -->
          
        </div> <!-- row -->
      </div>
    </div>
  </div>
  <!-- End Contact Area -->
  
<hr></hr>
<?php
include('../02ui/commonfiles/footer.php');


?>
<script>
$(function(){
	var devmode=true;
	$('#send').on('click',function(){
		var flag=true;
		
		var fromval=$("#email").val();
		var subject=$("#subject").val();
		var message=$("#message").val();
		var name=$("#name").val();
		
		if(fromval=='')
		{
			flag=false;
			alert("Empty from address");
		}
		else if(subject=='')
			{
			flag=false;
			alert("Empty subject");
		}
		else if(message=='')
			{
			flag=false;
			alert("Empty message");
		}
		else if(name=='')
			{
			flag=false;
			alert("Empty name");
		}
		
	if(flag)
	{
	    var code=$("#captcha_code").val();
	    $.ajax({
                     async: false,
					   url:"./dataprocess.php",
					   dataType:"JSON",
					   method:"POST",
					   data:{"code":code,"order_type":"capcha_validate"},
					   success: function(data){
						   	//console.log(data);
						   	if(data.val)
						   	{
        						  flag=true;
						   	}
						   	else
						   	{
						   	    alert("Wrong capcha");
						   	    flag=false;
						   	}
						 }

			});
			
	}
	
if(flag)
{
	$.ajax({
		async: false,
        url: "../08common/dataprocess.php",
		dataType:"TEXT",
        data: {"order_type":"contact_details","from_address":fromval,"subject":subject,"name":name,"message":message},
        method:"post",
		success: function (dataofconfirm) {
            // do something with the result
			if(devmode){
			console.log("start of success function");
			console.log(dataofconfirm);
			}
			alert("Data Saved We will contact you within 24hrs.");
			document.location.reload();
			if(devmode){
			console.log("end of success function");
			}
        }
    });
}
	});
});
</script>