<?php

if (session_status() == PHP_SESSION_NONE) {

    session_start();

}



include ('../07config/newdbconfig.php');



if(isset($_SESSION['root']))

	$root=$_SESSION['root'];

else 

	$root="";





//echo $_SERVER['PHP_SELF'];

?>

<html>

<head>

<meta charset="utf-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<meta name="viewport" content="width=device-width , initial-scale=1" />

<meta http-equiv="X-UA-Compatible" content="chrome=1">

<title>EHR Panchagavya</title>



<!-- Accordian Styles -->

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<!-- accordian styles end -->



<!--Index Libraries-->

<link rel="stylesheet" type="text/css" href="<?php echo $root;?>02ui/css/bootstrap.min.css">

<link rel="stylesheet" type="text/css" href="<?php echo $root;?>02ui/css/font-awesome.css">

<link rel="stylesheet" type="text/css" href="<?php echo $root;?>02ui/css/slick.css">

<link rel="stylesheet" type="text/css" href="<?php echo $root;?>02ui/css/slick-theme.css">

<link rel="stylesheet" type="text/css" href="<?php echo $root;?>02ui/css/custom.css">

<link rel="stylesheet" type="text/css" href="<?php echo $root;?>02ui/css/media.css">

<link rel="stylesheet" type="text/css" href="<?php echo $root;?>02ui/css/new_nav_edited.css">



<script type="text/javascript" src="<?php echo $root;?>02ui/scripts/jquery-3.2.1.min.js"></script>

<script type="text/javascript" src="<?php echo $root;?>02ui/scripts/bootstrap.min.js"></script>

<script type="text/javascript" src="<?php echo $root;?>02ui/scripts/jquery-scrolltofixed.js"></script>

<script type="text/javascript" src="<?php echo $root;?>02ui/scripts/jquery.devrama.slider.js"></script>

<script type="text/javascript" src="<?php echo $root;?>02ui/scripts/slick.js"></script>

<!--Index Libraries End-->



<!--Accordians Start-->

  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>

  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<!--Accordians End-->





<!--Vertical tabs-->

<link  class="add_root" rel="stylesheet" type="text/css" href="<?php echo $root;?>02ui/css/easy-responsive-tabs.css">

<script class=""  type="text/javascript" src="<?php echo $root;?>02ui/scripts/easyResponsiveTabs.js"></script>

<!--Vertical tabs End-->









<!--Testing Links-->

<link rel="stylesheet" type="text/css"  href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css"  />

<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>

<!--End of testing Scripts-->







<!--Data Tables-->

<link  class="add_root" rel="stylesheet" type="text/css" href="<?php echo $root;?>02ui/css/datatables.css">

<link  class="add_root" rel="stylesheet" type="text/css" href="<?php echo $root;?>02ui/css/dataTables.bootstrap.css">

<link  class="add_root" rel="stylesheet" type="text/css" href="<?php echo $root;?>02ui/css/responsive.dataTables.css">

<link class="add_root"  href="<?php echo $root;?>02ui/scripts/datatables/dataTables.bootstrap4.css" rel="stylesheet">





<script class=""  type="text/javascript" src="<?php echo $root;?>02ui/scripts/datatables.js"></script>

<script class=""  type="text/javascript" src="<?php echo $root;?>02ui/scripts/dataTables.bootstrap.js"></script>

<!--Data Tables END-->

<!-- webcam start -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/webcamjs/1.0.25/webcam.min.js"></script>
<!-- webcam end -->


</head>

<body>

<div class="top_strip"></div>

<div class="top_bar">

  <div class="container">

    <div class="top_right">

	<?php

	if(isset($_SESSION['user_name']))

	{

	?>

	  <div class="number_div" style="margin-right:0px;"> <span class="num_left"><i class="fa fa-sign-in"></i></span> <span class="num_right"><a href="#" onclick="checksignout();" >Logout</a></span> </div>

	<?php

	}else{

		?>

		<div class="number_div" style="margin-right:0px;"> <span class="num_left"><i class="fa fa-sign-in"></i></span> <span class="num_right"><a href="#" data-toggle="modal" data-target="#LoginModal">Login</a></span> </div> 

		<?php

	}

	?>  

      <div class="number_div"> <span class="num_left"><i class="fa fa-phone"></i></span> <span class="num_right">

        <p> +91 9004656749</p>

        </span> </div>

      <div class="number_div pull-left" style="margin-left:0px;"> <span class="num_left"><i class="fa fa-envelope"></i></span> <span class="num_right">

        <p>info@cowcure.com</p>

        </span> </div>

		<?php

		if(isset($_SESSION['user_name']))

		{

		?>

		 <div class="number_div pull-left">  <span class="num_right">

        <b><p>Welcome Doctor</p></b>

        </span> </div>

		<?php

		}?>

    </div>

    <div style="clear:both;"></div>

  </div>

</div>





<div class="container-fluid primary_nav_fuild"  style="clear:both;">

  <div class="container">

    <nav class="navbar navbar-default "> 

      

      <!-- Brand and toggle get grouped for better mobile display -->

      <div class="navbar-header">

        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false"> <span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span> </button>

        <a class="navbar-brand" href="<?php echo $root;?>index.php"><img src="<?php echo $root;?>02ui/images/ehr-logo.png"></a>

        <div class="logo_title">

          <div class="pull-left">

            <div class="logo_sub_text1 row">

              <h3>Kamdhenu Panchagavya<br>

                Ayurved Kendra</h3>

            </div>

          </div>

        </div>

      </div>

      

      <!-- Collect the nav links, forms, and other content for toggling -->

      <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">

        <ul class="nav navbar-nav navbar-right">

           <li><a href="<?php echo $root;?>index.php" class=""><i class="fa fa-home"></i> Home</a></li>



            <?php

			if(isset($_SESSION['user_name']))

			{

		  ?>

          <li class="dropdown">

          <a href="#" class="dropdown-toggle " data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-wheelchair"></i> Patients <span class="caret"></span></a>

          <ul class="dropdown-menu">

            <li><a class="" href="<?php echo $root;?>03patient/prescription.php?status=new">Add New</a></li>

            <li><a href="<?php echo $root;?>03patient/search.php">Search Existing</a></li>

           

          </ul>

		  </li>

		  <?php

			}

		  ?>

		  <?php

			if(isset($_SESSION['user_name']))

			{



		  ?>

        <li class="dropdown">

          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-home"></i> Stock <span class="caret"></span></a>

			<ul class="dropdown-menu">

            <li><a href="<?php echo $root;?>05stock/stock.php?status=new">Make Update</a></li>

			<li><a href="<?php echo $root;?>05stock/stock.php?status=credit">Check Credit History</a></li>

			<li><a href="<?php echo $root;?>05stock/stock.php?status=debit">Check Debit History</a></li>

            <li><a href="<?php echo $root;?>05stock/stock.php?status=available">Check Stock Available</a></li>

            </ul>

        </li>

		<?php

			}

		?>

     <li class="dropdown">

          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-home"></i> Services <span class="caret"></span></a>

          <ul class="dropdown-menu">

		  <?php

			if(isset($_SESSION['user_name']))

			{

		  ?>

		  <li><a href="<?php echo $root;?>03patient/searchonline.php">Online Consultation</a></li>

            

			<?php

			}

			else

			{

			?>

			<li><a href="<?php echo $root;?>03patient/online.php">Online Consultation</a></li>

			<?php

			}

			?>

            <li><a href="<?php echo $root;?>09services/packages.php">Packages</a></li>



          </ul>

     </li>

     <li class="dropdown">

          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-home"></i>Resources <span class="caret"></span></a>

          <ul class="dropdown-menu">

            <li><a href="<?php echo $root;?>10resources/videos.php">Videos</a></li>

           <li><a href="<?php echo $root;?>10resources/certificates.php">Training And Certificates</a></li>

          </ul>

     </li>

     <li class="dropdown">

          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-home"></i> About Us <span class="caret"></span></a>

          <ul class="dropdown-menu">

            <li><a href="<?php echo $root;?>11about/testimonials.php">Testimonials</a></li>

            <li><a href="<?php echo $root;?>11about/staff.php">Enquiry Form</a></li>

			

          </ul>

     </li>

     

    <li><a href="<?php echo $root;?>08common/contact.php"><i class="fa fa-map-marker"></i> Contact Us</a></li>

	<?php

		if(isset($_SESSION['user_name']))

		{

			?>

			<li class="visible-xs"><a href="#" onclick="checksignout();" ><i class="fa fa-sign-in"></i>Logout</a></li>

	<?php

		}else{

	  ?>

			<li class="visible-xs"><a href="login.html" data-toggle="modal" data-target="#LoginModal"><i class="fa fa-sign-in"></i> Login</a></li>

		<?php

		}

		?>

        </ul>

      </div>

      <!-- /.navbar-collapse --> 

      

    </nav>

  </div>

</div>



<?php

include("../04login/login.php");

?>



<!--Active Class Scripts-->

<script type="text/javascript">



       



    $(document).ready(function () {

	

	/* 	$('.add_root').each(function(){

				var a=$(this).attr('href');



				$(this).attr('href',o+set+a);

	

				}); */

				

		//Scripts or active class  for current pages

		var h=this.location.href;

		var o=this.location.origin;	

		var place=h.replace(o,'');

		//console.log(place);

		$('a[href="' + place + '"]').addClass('active');

		$('a[href="' + place + '"]').closest('ul').siblings('a').addClass('active');

		

		var path=window.location.pathname;

		//console.log(window.location.pathname);

		var s=path.split("/");

		var name=s[s.length-1];

		

	/* 	//console.log(name);

		var check=false;

		setTimeout(function(){

			

			$("a").each(function(){

				

				check=$(this).hasClass("active");

				

				if(check)

				{

					console.log($(this).attr('href'));

					return false;

				}

				//console.log($(this).attr('href'));

			});

			

			}, 3000);

		 */

		 

	/* 	$('a').each(function(){

			var val=$(this).attr('href');

			//console.log(val);

			var tip=val.split("/");

			//console.log(tip);

			if(tip[tip.length-1].indexOf(name)>=0){

				//console.log(name+"<-selected");

				$(this).closest('ul').siblings('a').addClass('active');

				$(this).addClass("active");

				//console.log($(this));

				return false;

			}

		

		//	if(val.indexOf('prescription.php')>0)

			//	console.log(val);

		//console.log(tip[tip.length-1]);

		}); */

		

		//console.log(name);

		

		/* console.log($('a[href="'+place+'"]').attr('href')+'<-href');

		

		console.log(window.location.pathname);

		console.log(window.location.origin);

		console.log(window.location.href); */

		//console.log($('a[href="' + place + '"]').closest('ul').siblings('a').addClass('active'));

			

			//console.log($('.testing').attr('href',set+a));



		/* $('a').each(function() {

			if ($(this).is('[href*="prescription"')) {

				alert("Contains questionmark");

			}

		});

		 */

		

    });



    function checksignout(){

	var e = confirm("Are you sure to Logout?");



	if(e==true)

	{

		document.location.href="/index.php";

	}

}

</script> 







<style>

body{

	text-size-adjust: auto;

}





@-moz-document url-prefix(){

	body{

		font-size : 130%;

	}

}

	</style>

