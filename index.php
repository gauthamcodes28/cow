<!doctype html>

<script>
/*

*/


/* function getCookie(cname) {

  var name = cname + "=";

  var decodedCookie = decodeURIComponent(document.cookie);

  var ca = decodedCookie.split(';');

  for(var i = 0; i <ca.length; i++) {

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



var url = window.location.pathname;

var filename = url.substring(url.lastIndexOf('/')+1);

//console.log(filename);

var sun=url.replace(filename,'');

//console.log(sun);

document.cookie="path="+sun;

console.log(getCookie('path'));



var pathArray = location.pathname.split("/");

			var appPath = pathArray[1];

			//console.log("/"+appPath+"/");

			var set='/'+appPath+'/';

			//console.log(set); */

</script>

<?php 



session_start(); 

if(isset($_GET['status']) && $_GET['status']=='signout')

{

		// remove all session variables



		session_start();
unset($_SESSION['user_name']);
		session_unset(); 



		// destroy the session 



		session_destroy(); 

		 header('location:index.php');	

}

if(isset($_SESSION['root']))

	$root=$_SESSION['root'];

else 

	$root="";





?>



<html>

<head>

<meta charset="utf-8">

<meta name="viewport" content="width=device-width, initial-scale=1" />

<title>EHR Panchagavya</title>

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



<script>var devmode=true;</script>

<script>

function checksignout()

{

	var e=confirm("Are you sure to Signout?");



	if(e==true)

		document.location.href = "<?php echo $root;?>index.php?status=signout";





}

</script>

</head>

<style>



</style>

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

</br>





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

            <li><a href="<?php echo $root;?>11about/enquiryform.php">Enquiry Form</a></li>

			<li><a href="<?php echo $root;?>11about/staff.php">Doctors</a></li>

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

<?php include('04login/login.php')?>



<!-- =======Home body content start ============ -->



	<!-- ======slider start ======== -->



<div class="slider-div" >

  <div class="example-animation">

    <div data-lazy-background="02ui/images/slide1.png">

      <!-- <div data-pos="['0%', '110%', '35%', '10%']" data-duration="700" data-effect="move">

                    <span class="main_title">Product 1</span>

                </div>

                <div data-pos="['-30%', '25%', '50%', '12%']" data-duration="700" data-effect="move">

                    <span class="tagLine">Product 1 tag line</span>

                </div>

                <div data-pos="['56%', '-40%', '58%', '10%']" data-duration="700" data-effect="move">

                    <a href="about.html" class="terms banner_readmore">Read More...</a>

                </div>-->



    </div>

    <div data-lazy-background="02ui/images/slide2.png">

      <!--<div data-pos="['0%', '110%', '35%', '10%']" data-duration="700" data-effect="move">

                    <span class="main_title">Health Product 2</span>

                </div>

                <div data-pos="['-30%', '25%', '50%', '12%']" data-duration="700" data-effect="move">

                    <span class="tagLine">Product 2 tag line</span>

                </div>

                <div data-pos="['56%', '-40%', '58%', '10%']" data-duration="700" data-effect="move">

                    <a href="hajj.html" class="terms banner_readmore">Read More...</a>

                </div>-->



    </div>

    <div data-lazy-background="02ui/images/slide3.png">

      <!-- <div data-pos="['0%', '110%', '35%', '10%']" data-duration="700" data-effect="move">

                   <span class="main_title">Product 3</span>

                </div>

                <div data-pos="['-30%', '25%', '50%', '12%']" data-duration="700" data-effect="move">

                    <span class="tagLine">Product 3 tag line</span>

                </div>

                <div data-pos="['56%', '-40%', '58%', '10%']" data-duration="700" data-effect="move">

                    <a href="umrah.html" class="terms banner_readmore">Read More...</a>

                </div>-->



    </div>

  </div>

</div>

<!-- ======slider end ======== -->
<style>
  .wrapper {
  column-count: 2;
  column-gap: 50px;
  padding: 50px;
}
.star {
  float: left;
  width: 100%;
  shape-margin:20px;
  margin-right: 20px;
  margin-bottom: 20px;
}
p {
  
}
.panel-heading{
  /*color: #65af16;  */
}
.panel-default>.panel-heading {
  background-color: #65af16;  
}

</style>
<div class="container" style="" >

<div class="row">

</div>

<div class="row">

      <div class="col-md-9">
<div class="wrapper">
  <img src="<?php echo $root;?>02ui/images/index.jpg" alt="" class="star">
      

      <div class="clearfix"></div>

<!-- Login Modal -->
  <h2 class="page_title ">What is Panchagavya?</h2>


    

		<p class="home_body_content text-center"><i>गव्यम पवित्रम च रसायनम च पथ्यं च ह्रद्द्यबलम बुद्धिदंस्यात |आयुः प्रदम रक्त विकार हारी त्रिदोष ह्रद्रोग विषापहं स्यात ॥</i></p>

		<p class="home_body_content text-center">Gavya(or the things derived from cow) is great elixir, proper diet, pleasing to heart, giver of mental and physical strength, enhances longevity. It removes all blood disorders. It balances bile, mucous and airs. Remover of heart diseases and effect of poison.</p>

		<p class="home_body_content text-center"><i>यत्वगस्थि गतम पापम देहे तिष्ठती मामके । </i><i>प्राशनात पञ्चगव्यस्य दहम्त्वग्नि रिवेंधनम ॥  </i></p>

		<p class="home_body_content text-center">From skin to bones, what ever sins (diseases) are in my body, are destroyed by panchagavya just as fire destroys fuel<span id="more-30"></span></p>

		<p class="home_body_content text-center">Panchagavya is a classic collective name of five products obtained from cow viz milk, curd, ghee, urine and dung.Medicinal uses of Panchagavya and its individual ingredients including cow urine are mentioned in the authoritative books of Ayurveda. Its therapeutic uses in Ayurveda include Krimi Roga, Kushtha, Kandu, Shoola, Gulma, Udara Roga, Anaha, Shotha, Pandu, Kamala, Vasti Roga, Kasa, Shavasa, Atisara, Mutraroga etc. Cow urine is ingredient of several Ayurvedic formulations and also used as adjuvant with medicinal formulations and for pharmaceutical processing called Shodhana (Purification) and Bhavana (Triturition) of medicinal materials.</p>

		<p class="home_body_content text-center">Panchagavya Therapy means use of Panchgavya (as explained above) in curing diseases which is an integral part of Ayurveda without which no treatment would be that effective.</p>

		<p class="home_body_content text-center">We have experience of treating more than 3000 patients in India &amp; abroad, through use of Panchgavya. Diseases like Cancer, Diabetes, Blood pressure, Psoriasis, Skin diseases, Asthma, Chronic body pain, Gynecological problems, Infertility, Kidney diseases, Digestive disorders,  etc. have been successfully cured. Many of the chronic illness cases have been cured within months with Panchgavya.<!--more--></p>

		<p class="home_body_content text-center">Ayurveda mentions of Sadhya &amp; Asadhya Rogas &#8211; Curable &amp; Incurable diseases.  As per our experience, with use of Panchgavya even if the disease is not cured fully but the patient is able to live much better than before. Diagnosis is the 1st step of treating any disease. By Pulse Diagnosis or Naadi Pariksha an expert Vaidya can know the stage of a disease and can foretell about the curability of disease. We follow the traditional manual Pulse diagnosis method as well as electronic Pulse diagnosis as an aid which generates a full report by which a patient is able to know whats happening in his body as per Ayurveda.</p>

		<p class="home_body_content text-center">If you are interested to learn more about Naadi Pariksha &amp; Panchgavya therapy enroll for our Online course here&#8230;!</p>
</div> <!-- wrapper -->

	</div>

	<div class="col-md-3">
    
    <div class="panel panel-default">

      <div class="panel-body"><a target="_BLANK" href="http://www.cowcure.com/vrindavan-eco-farms/" ><img src="<?php echo $root;?>02ui/images/panel1.jpg" alt="" class="star"></a></div>
    </div>
    
    <div class="panel panel-default">
      <div class="panel-heading">Recent Posts</div>
      <div class="panel-body">
          <ul class="list-centered">
              <li>
                  December 2018 Schedule November 30, 2018
              </li>
              <li>
                Farm Produce available- Tur Dal, Green Moong Dal, Amla Candy, Amla Juice January 12, 2018
              </li>
          </ul>
      </div>
    </div>

    <div class="panel panel-default">
      <div class="panel-heading">Book Appointment</div>
        <a target="_BLANK" href="" ><img src="<?php echo $root;?>02ui/images/book_appointment.png" alt="" class="star"></a>
    </div>

  </div> <!-- col-md-3 -->

	</div>

</div><!--End Of COntainer Tag-->



<hr ></hr>



<!-- =======Home body content end ============ -->



    	

   

<!-- =======Footer content start ============ -->

<?php
include './02ui/commonfiles/footer.php';
?>
<!-- =======Footer content end ============ -->











<!-- =======script for main slider start ============ -->

<script type="text/javascript">

            $(document).ready(function(){

                $('.example-animation').DrSlider(

				{

					 width: undefined,

					height: undefined,

					userCSS: false,

					transitionSpeed: 1000,

					duration: 6000,

					showNavigation: false,

					classNavigation: undefined,

					navigationColor: '#9F1F22',

					navigationHoverColor: '#D52B2F',

					navigationHighlightColor: '#DFDFDF',

					navigationNumberColor: '#000000',

					positionNavigation: 'in-right-bottom',

					navigationType: 'circle',

					showControl: true,

					classButtonNext: undefined,

					classButtonPrevious: undefined,

					controlColor: '#FFFFFF',

					controlBackgroundColor: '#000000',

					positionControl: 'left-right',

					transition: 'fade-in',

					showProgress: false,

					progressColor: '#797979',

					pauseOnHover: true,

					onReady: undefined

				}); //Yes! that's it!

				

				

				

            });

			$(function(){

						  //sessionStorage.removeItem("reloading");

							var h=this.location.href;

							//console.log(this.location.origin);

							var o=this.location.origin;

							

							var place=h.replace(o,'');

							//console.log(place);

							$('a[href="' + place + '"]').addClass('active');

							$('a[href="' + place + '"]').closest('ul').siblings('a').addClass('active');

							//console.log($('a[href="' + place + '"]').closest('ul').siblings('a').addClass('active'));

					});

        </script>

<!-- =======script for main slider end ============ -->



</body>

</html>

