
<?php

include "fpdf.php";

require("../07config/newdbconfig.php");

//echo '<title>Invoice</title>';

if(isset($_POST['print_type']))

	{

		//echo "Invoice";

		if($_POST['print_type']=="printpdf")

			$flag=true;

		else

			$flag=false;



		$months=$_POST['print_months'];

		

				

		$patient_id=$_POST['print_id'];

		$visit=$_POST['print_visit'];

		

		//Patient Detials

			$sql="select * from patient_master where Patient_ID  like '".$patient_id."' and Visit_Number=".$visit;

			$result=mysqli_query($conn,$sql);

			$row=mysqli_fetch_assoc($result);

			$name=$row['PName'];

			$vedapulse=$row['Veda_Pulse'];

			$vikruthi=$row['Vikruthi'];

			$gender=$row['Gender'];

			$branch=$row['Branch_ID'];

		//variables for invoice only

		$inv_types=array();

		$inv_medicines=array();

		$inv_price=array();

		$inv_months=array();

		$inv_total=array();

		$inv_given=array();

		$inv_weight=array();





		$type=array();

		$mname=array();

		$billable=array();

		$given=array();

		$basic=array();

		$available=array();

		$basic=array();

		$qnt=array();

		$when=array();

		$how=array();

		$unit=array();

		

		//prescription

		if($flag)

		{

			

			

			//Medicine Data

			

			$medicinename=array();

			$type[0]="Type";

			$mname[0]="Medicine Name";

			$billable[0]="Billable";

			$given[0]="Given";

			$available[0]="Available";

			$basic[0]="Basic";

			$qty[0]="Quantity to Use";

			$when[0]="When to Use";

			$how[0]="How to Use";

		

				//Data to the arrays

				$i=1;

			$sql="select distinct Medicine_Type_ID from patient_medicine where Patient_ID='".$patient_id."' and Visit_Number=".$visit;

			$result=mysqli_query($conn,$sql);

		

			while($row=mysqli_fetch_assoc($result))

			{

				$a="select Type_Name from medicine_type where Type_ID=".$row['Medicine_Type_ID']; 

				//echo $a;

				$r=mysqli_query($conn,$a);

				$s=mysqli_fetch_assoc($r);



					

					

					$type[$i]=$s['Type_Name'];



					$s="select * from patient_medicine where Patient_ID='".$patient_id."' and Visit_Number=".$visit." and Medicine_Type_ID=".$row['Medicine_Type_ID']."";

					$q=mysqli_query($conn,$s);

					

					$mname[$i]='';

					while($w=mysqli_fetch_assoc($q))

					{

						$mname[$i].=$w['Medicine_Name'].",";	

					}

					

					$s="select * from patient_medicine where Patient_ID='".$patient_id."' and Visit_Number=".$visit." and Medicine_Type_ID=".$row['Medicine_Type_ID']." limit 1";

					$result2=mysqli_query($conn,$s);

					$row2=mysqli_fetch_assoc($result2);

					



					// $billable[$i]=$row2['Billable'];

					// $given[$i]=$row2['Given'];

					

					// 		//Available value from stock_master table

					// 		$sql2="select Available from stock_master where Medicine_Name like '".$row2['Medicine_Name']."'";

					// 		$resulltstock=mysqli_query($conn,$sql2);

					// 		$rowstock=mysqli_fetch_assoc($resulltstock);

							

							//Basic value from medicine table

							$sqlmedicine="select * from medicine where Medicine_Name like '".$row2['Medicine_Name']."'";

							//echo $sqlmedicine;

							$resultbasic=mysqli_query($conn,$sqlmedicine);

							$rowbasic=mysqli_fetch_assoc($resultbasic);

					

					// //$available[$i]=$rowstock['Available'];

					// $basic[$i]=$rowbasic['Basic'];

					$qty[$i]=$row2['Quantity'];

					$when[$i]=$row2['Whenval'];

					$how[$i]=$row2['How'];

					$unit[$i]=$rowbasic['Unit'];

					$i++;

				}

				

			//Instructions Data

				$sql="select * from patient_instruction where Patient_ID='".$patient_id."' and Visit_Number=".$visit;

				$result=mysqli_query($conn,$sql);

				$row=mysqli_fetch_assoc($result);

				

				$dan=$row['Dantmanjan'];

				$yoga=$row['Yoga'];

				$inst=$row['Instructions'];

				$stop=$row['Stop'];

				$start=$row['Start'];

				$other1=$row['Other1'];

				$other2=$row['Other2'];

				

			//Problem Data

				$sql="select * from patient_problem where Patient_ID='".$patient_id."' and Visit_Number=".$visit;

				$result=mysqli_query($conn,$sql);

				$row=mysqli_fetch_assoc($result);

				

				$problem=$row['PDescription'];

				$ayur=$row['Ayurvedic'];

				$modern=$row['Modern'];

			

		}

		

		//invoice

		else

		{

			$arkflag=false;

			$asavaflag=false;

setcookie("invoice","true",time()+600000,$root);

			// //ark check for multiple medicines

			$arkcheck="select count(*) as Ark from patient_medicine where Patient_ID='".$patient_id."' and Medicine_Type_ID = 2 and Billable='yes' and Visit_Number=".$visit;

			$arkresult=mysqli_query($conn,$arkcheck);

			$arkrow=mysqli_fetch_assoc($arkresult);





			// //Asava-Arishta check for multiple medicines

			$asavacheck="select count(*) as Asava from patient_medicine where Patient_ID='".$patient_id."' and Medicine_Type_ID = 3 and Billable='yes' and  Visit_Number=".$visit;

			$asavaresult=mysqli_query($conn,$asavacheck);

			$asavarow=mysqli_fetch_assoc($asavaresult);



			if($arkrow["Ark"]>1)

			{

				$arkflag=true;

			}

			

			if($asavarow["Asava"]>1)

			{

				$asavaflag=true;

			}



			// for ark

			// $sql1="select * from patient_medicine where Patient_ID='".$patient_id."' and Medicine_Type_ID=2 and Visit_Number=".$visit;

			// $result1=mysqli_query($conn,$sql1);

			// $one=true;

			// $i=0;

			// $set=false;

			// while($row1=mysqli_fetch_assoc($result1))

			// {

			// 	$set=true;

			// 	if($one)

			// 	{

			// 		$inv_medicines[$i]="Ark/";

					

			// 	}

			// 	$one=false;



			// 	$inv_medicines[$i].=$row1['Medicine_Name'].",";

			// 	// $row1=mysql_fetch_assoc($result1);

			// }

			// if($set)

			// 	$i++;



			// // for asava Asava-Arishta

			// $set=false;

			// $sql1="select * from patient_medicine where Patient_ID='".$patient_id."' and Medicine_Type_ID=3 and Visit_Number=".$visit;

			// $result1=mysqli_query($conn,$sql1);

			// $one=true;

			// while($row1=mysqli_fetch_assoc($result1))

			// {

			// 	$set=true;

			// 	if($one)

			// 	{

			// 		$inv_medicines[$i]="Asava-Arishta/";

					

			// 	}

			// 	$one=false;

			// 	$inv_medicines[$i].=$row1['Medicine_Name'].",";

			// 	// $row1=mysql_fetch_assoc($result1);

			// }

			











			// echo 'Ark'.$sql1;

			//var_dump($inv_medicines);

			$sql="select distinct Medicine_Type_ID from patient_medicine where Patient_ID='".$patient_id."' and Visit_Number=".$visit;

			$result=mysqli_query($conn,$sql);

			$i=0;

			while($row=mysqli_fetch_assoc($result))

			{

				$a="select Type_Name from medicine_type where Type_ID=".$row['Medicine_Type_ID']; 

				//echo $a;

				$r=mysqli_query($conn,$a);

				$s=mysqli_fetch_assoc($r);





				$inv_types[$i]=$s['Type_Name'];

				$inv_medicines[$i]='';

				$sql1="select * from patient_medicine where Patient_ID='".$patient_id."' and Medicine_Type_ID=".$row['Medicine_Type_ID']." and Visit_Number=".$visit;

				$tempresult=mysqli_query($conn,$sql1);

				$cost=0;

				$temp1=0;

				$temp2=0;

				$temp3=0;

				$temp4=0;

				$w=0;

				// if($row['Medicine_Type_ID']!=2 && $row['Medicine_Type_ID']!=3)

					while($row1=mysqli_fetch_assoc($tempresult))

					{

						$inv_medicines[$i].=$row1['Medicine_Name'].",";

				

						//Unit_Price,Basic,Unit,Package_Weight,

						$b="select * from medicine where Medicine_Name='".$row1['Medicine_Name']."'";

						$c=mysqli_query($conn,$b);

						$d=mysqli_fetch_assoc($c);

						$u=$d['Unit'];

						$w+=$row1['Given']*$d['Package_Weight']/$d['Net_Content'];

						// echo "Given:".$row1['Given'];

						// echo "Weight:".$d['Package_Weight'];

						// echo "Contents:".$d['Net_Content'];

						// echo "Total:".$w;

						

						$temp1+=$row1['Given']/$d['Basic']*$d['Unit_Price']*$months;

						$temp3+=$row1['Given'];

						// $inv_total[$i]=$row1['Given']/$d['Basic']*$d['Unit_Price']*$months;

						// $inv_given[$i]=$row1['Given'];

						// $inv_months[$i]=$months;

						// $inv_price[$i]=$d['Unit_Price'];

						$temp2+=$d['Package_Weight'];

						//

						// var_dump($i);

					// var_dump($inv_medicines);	

					}//inner while end

					if($row['Medicine_Type_ID']==2 || $row['Medicine_Type_ID']==3)

					{

						if($arkflag && $row['Medicine_Type_ID']==2){



							$inv_total[$i]=300*$months;

						}

						if($asavaflag && $row['Medicine_Type_ID']==3){



							$inv_total[$i]=250*$months;

						}

							

					}

					else

					{

						$inv_total[$i]=$temp1;		

					}

				

				$inv_given[$i]=$temp3.$u;

				$inv_weight[$i]=$w;

				// var_dump($inv_total);

				// var_dump($inv_weight);

				$i++;

				

			}//outer while end

			

			// var_dump($inv_total);

			// var_dump($inv_medicines);

		}//invoice else

	}





class PDF extends FPDF

{

// Page header

function Header()

{

    // Logo

  //  $this->Image('logo.png',10,6,30);

    // Arial bold 15

    $this->SetFont('Arial','B',10);

    // Move to the right

  //  $this->Cell(80);

     $this->Cell(0,0,"Vaidya Nikhil Namacharya's",0,0,'C');

$this->Ln(5);

$this->Cell(0,0,"Kamdhenu Panchgavya Ayurved Kendra",0,0,'C');

$this->Ln(5);

$this->Cell(0,0,"Mumbai, Bangalore, Hyderabad, Parbhani, Pune",0,0,'C');

$this->Ln(5);

$this->Cell(0,0,"www.CowCure.com/info@CowCure.com",0,0,'C');

$this->Ln(5);

$this->Line(10, 28, 210-20, 28);

}



// Page footer

function Footer()

{

        // Position at 1.5 cm from bottom

	$this->Line(10, 277, 210-20, 277);

    $this->SetY(-15);

    // Arial italic 8

    $this->SetFont('Arial','I',8);

    // Page number

   // $this->Cell(0,10,'Page '.$this->PageNo().'/{nb}',0,0,'C');

    $this->Cell(0,0,"Pulse Diagnosis, Panchgavya & Panchkarma Ayurvedic Solutions for all kinds of Diseases",0,1,'C');

$this->Ln(5);

$this->Cell(0,0,"Inpatient facility available @ Parbhani, Maharashtra. ",0,1,'C');

$this->Ln(5);

$this->Cell(0,0,"CowCure- A Sure Cure from Mother Cow",0,1,'C');

}

//WordWrap

function WordWrap(&$text, $maxwidth)

{

    $text = trim($text);

    if ($text==='')

        return 0;

    $space = $this->GetStringWidth(' ');

    $lines = explode("\n", $text);

    $text = '';

    $count = 0;



    foreach ($lines as $line)

    {

         $words = preg_split('/,/', $line);

        $width = 0;



        foreach ($words as $word)

        {

            $wordwidth = $this->GetStringWidth($word);

            if ($wordwidth > $maxwidth)

            {

                // Word is too long, we cut it

                for($i=0; $i<strlen($word); $i++)

                {

                    $wordwidth = $this->GetStringWidth(substr($word, $i, 1));

                    if($width + $wordwidth <= $maxwidth)

                    {

                        $width += $wordwidth;

                        $text .= substr($word, $i, 1);

                    }

                    else

                    {

                        $width = $wordwidth;

                        $text = rtrim($text)."\n".substr($word, $i, 1);

                        $count++;

                    }

                }

            }

            elseif($width + $wordwidth <= $maxwidth)

            {

                $width += $wordwidth + $space;

                $text .= $word.',';

            }

            else

            {

                $width = $wordwidth + $space;

                $text = rtrim($text)."\n".$word.' ';

                $count++;

            }

        }

        $text = rtrim($text)."\n";

        $count++;

    }

    $text = rtrim($text);

    return $count;

}

function check($text)

{

	$temp=array();

	$temp=explode(",",$text);

	$count=count($temp);

	return $count;

}



function myCell($w,$h,$x,$t){

		$height=$h/3;

		$first=$height+2;

		$second=$height+$height+$height+3;

		$len=strlen($t);

		if($len>62){

			$txt=str_split($t,62);

			$this->SetX($x);

			$this->Cell($w,$first,$txt[0],'','','');

			$this->SetX($x);

			$this->Cell($w,$second,$txt[1],'','','');

			$this->SetX($x);

			$this->Cell($w,$h,'','LTRB',0,'L',0);

			

		}

		else{

			$this->SetX($x);

			$this->Cell($w,$h,$t,'LTRB',0,'L',0);

			

		}

	}

	function myCell1($w,$h,$x,$t){

		$height=$h/3;

		$first=$height+2;

		$second=$height+$height+$height+3;

		$len=strlen($t);

		if($len>50){

			$txt=str_split($t,50);

			$this->SetX($x);

			$this->Cell($w,$first,$txt[0],'','','');

			$this->SetX($x);

			$this->Cell($w,$second,$txt[1],'','','');

			$this->SetX($x);

			$this->Cell($w,$h,'','',0,'L',0);

		}

		else{

			$this->SetX($x);

			$this->Cell($w,$h,$t,'',0,'L',0);

		}

	}

	

/*Indentation and table formation Code Start*/

	//Indentation of tables row values

	

	var $widths;

var $aligns;



function SetWidths($w)

{

    //Set the array of column widths

    $this->widths=$w;

}



function SetAligns($a)

{

    //Set the array of column alignments

    $this->aligns=$a;

}



//For the Heading extra padding bottom I cloned the function and added +1 at line  $h=5*$nb+1;

function RowHead($data)

{

	//Manuall set the x-coordinate-- Gautham

	$this->SetX(10);

	

    //Calculate the height of the row

    $nb=0;

    for($i=0;$i<count($data);$i++)

        $nb=max($nb,$this->NbLines($this->widths[$i],$data[$i]));

    $h=5*$nb+4;//Added the +1 myself Gautham

	

    //Issue a page break first if needed

    $this->CheckPageBreak($h);

    //Draw the cells of the row

    for($i=0;$i<count($data);$i++)

    {

        $w=$this->widths[$i];

        $a=isset($this->aligns[$i]) ? $this->aligns[$i] : 'L';

        //Save the current position

        $x=$this->GetX();

        $y=$this->GetY();

        //Draw the border

        $this->Rect($x,$y,$w,$h);

        //Print the text

        $this->MultiCell($w,5,$data[$i],0,$a);

        //Put the position to the right of the cell

        $this->SetXY($x+$w,$y);

    }

    //Go to the next line

    $this->Ln($h);

}



//For The Rows Inside

function Row($data)

{

	//Manuall set the x-coordinate-- Gautham

	$this->SetX(10);

	

    //Calculate the height of the row

    $nb=0;

    for($i=0;$i<count($data);$i++)

        $nb=max($nb,$this->NbLines($this->widths[$i],$data[$i]));

    $h=5*$nb;//Added the +1 myself Gautham

	

    //Issue a page break first if needed

    $this->CheckPageBreak($h);

    //Draw the cells of the row

    for($i=0;$i<count($data);$i++)

    {

        $w=$this->widths[$i];

        $a=isset($this->aligns[$i]) ? $this->aligns[$i] : 'L';

        //Save the current position

        $x=$this->GetX();

        $y=$this->GetY();

        //Draw the border

        $this->Rect($x,$y,$w,$h);

        //Print the text

        $this->MultiCell($w,5,$data[$i],0,$a);

        //Put the position to the right of the cell

        $this->SetXY($x+$w,$y);

    }

    //Go to the next line

    $this->Ln($h);

}



function CheckPageBreak($h)

{

    //If the height h would cause an overflow, add a new page immediately

    if($this->GetY()+$h>$this->PageBreakTrigger)

        $this->AddPage($this->CurOrientation);

}



function NbLines($w,$txt)

{

    //Computes the number of lines a MultiCell of width w will take

    $cw=&$this->CurrentFont['cw'];

    if($w==0)

        $w=$this->w-$this->rMargin-$this->x;

    $wmax=($w-2*$this->cMargin)*1000/$this->FontSize;

    $s=str_replace("\r",'',$txt);

    $nb=strlen($s);

    if($nb>0 and $s[$nb-1]=="\n")

        $nb--;

    $sep=-1;

    $i=0;

    $j=0;

    $l=0;

    $nl=1;

    while($i<$nb)

    {

        $c=$s[$i];

        if($c=="\n")

        {

            $i++;

            $sep=-1;

            $j=$i;

            $l=0;

            $nl++;

            continue;

        }

        if($c==' ')

            $sep=$i;

        $l+=$cw[$c];

        if($l>$wmax)

        {

            if($sep==-1)

            {

                if($i==$j)

                    $i++;

            }

            else

                $i=$sep+1;

            $sep=-1;

            $j=$i;

            $l=0;

            $nl++;

        }

        else

            $i++;

    }

    return $nl;

}

/*Indentation and table formation Code END*/

//Just copy the above code for tables coloumns alignment.











}//end OF FPDF Function







// Instanciation of inherited class

$pdf = new PDF();

$pdf->AliasNbPages();

$pdf->AddPage();

$pdf->SetFont('Times','B',10);

$pdf->Ln(5);





//prescription

if($flag)

{

	//pateient details

	$pdf->Cell(0,0,"Patient Details:",0,1);

	$pdf->Ln(6);

	$pdf->SetFont('Times','',10);

	$x=$pdf->GetX();

	$pdf->myCell1(40,6,$x,"Patient ID:".$patient_id);

	$x=$pdf->GetX();

	$pdf->myCell1(40,6,$x,"Name: ".$name."");

	$x=$pdf->GetX();

	$pdf->myCell1(40,6,$x,"Sex: ".$gender."");

	$x=$pdf->GetX();

	$pdf->myCell1(40,6,$x,"Date: ".date("d/m/Y")."");

	$x=$pdf->GetX();

	$pdf->Ln(5);

	$x=$pdf->GetX();

	$pdf->myCell1(40,6,$x,"VedaPulse: ".$vedapulse."");

	$x=$pdf->GetX();

	$pdf->myCell1(40,6,$x,"Vikruthi: ".$vikruthi."");

	$x=$pdf->GetX();

	$pdf->myCell1(40,6,$x,"Place: ".$branch."");

	$x=$pdf->GetX();

	$pdf->myCell1(40,6,$x,"Visit No: ".$visit."");

	$x=$pdf->GetX();

	$pdf->Ln(10);

	$pdf->Line(10, 54, 210-20, 54);

	

	

	//Medicine Data

	$x=$pdf->GetX();

	$pdf->SetFont('Times','B',10);

	$pdf->myCell1(40,6,$x,"Medicines Prescribed:");

	$pdf->Ln(10);





	$x=$pdf->GetX();

	$pdf->SetWidths(array(25,35,40,40,40));



	//tHEad

	$pdf->SetFont('Times','B',10);

			$pdf->Row(array($type[0],$mname[0],$qty[0],$when[0],$how[0]));



	//tbody	

			$pdf->SetFont('Times','',10);

			for($i=1;$i<count($type);$i++){

			$pdf->Row(array($type[$i],$mname[$i],$qty[$i],$when[$i],$how[$i]));

			}



	$y=$pdf->GetY();

	$x=$pdf->GetX();

	$pdf->SetY($y+5);

	



	$pdf->Ln(5);

	$x=$pdf->GetX();

	$pdf->SetFont('Times','B',10);

	$pdf->myCell1(40,6,$x,"Instructions:-");



	$pdf->Ln(5);

	$pdf->SetFont('Times','',10);

	$x=$pdf->GetX();

	$pdf->SetX($x+5);

	$pdf->MultiCell(189, 5, "Use Dantmanjan only Don't use Toothpaste. Use Brush only if required.", 0, 1);

	$pdf->SetX($x+5);

	$pdf->MultiCell(189, 5, "Use Angarakshak Soap:- Avoid foam based soap.", 0, 1);

	

	if(!empty($yoga))

	{

			$pdf->SetX($x+5);

			$pdf->MultiCell(189, 5, "Yoga:- ".$yoga, 0, 1);		

			$pdf->SetX($x+5);	

	}

	else

		$pdf->SetX($x+5);



	if(!empty($inst)){

		$pdf->MultiCell(189, 5, $inst, 0, 1);	

		$pdf->SetX($x+5);

	}

	else

		$pdf->SetX($x+5);

	$pdf->MultiCell(189, 5, "Stop:- ".$stop, 0, 1);

	$pdf->SetX($x+5);

	$pdf->MultiCell(189, 5, "Start:- ".$start, 0, 1);

	$pdf->SetX($x+5);



	if(!empty($other1) && !empty($other2))

	$pdf->MultiCell(189, 5, "Other:- ".$other1." ".$other2, 0, 1);



}



else

{

	//Second Column X value

	$x2=$pdf->GetX();

	$x=$pdf->GetX();

	//$pdf->SetX($x);

	$y=$pdf->GetY();

	$pdf->setFont('Times','BU',12);

	$pdf->SetY($y);

	$pdf->myCell1(40,6,80,"INVOICE");

	

	$pdf->setFont('Times','B',12);

	$pdf->Ln(10);

	$pdf->myCell1(40,6,$x,"Bill From");

	

	$pdf->setFont('Times','',12);

	$pdf->myCell1(40,6,$x+110,"Date: ".date("d/m/Y"));

	$pdf->Ln(5);

	

	

	$x=$pdf->GetX();

	$pdf->myCell1(40,6,$x,"Kamdhenu Panchgavya Ayurved Kendra");$pdf->myCell1(40,6,$x+110,"Payment Terms: Online Bank Transfer");

	$pdf->Ln(5);

	$pdf->myCell1(40,6,$x,"Undegaonkar's Complex, In front of Hotel Vinayak,");$pdf->setFont('Times','B',12);$pdf->myCell1(40,6,$x+110,"Balance Due: Rs.");

	

	$pdf->setFont('Times','',12);

	$pdf->Ln(5);

	$pdf->myCell1(40,6,$x,"info@cowcure.com");$pdf->myCell1(40,6,$x+110,"Our Account details-");

	$pdf->Ln(5);

	$pdf->myCell1(40,6,$x,"+91 9004656749");$pdf->myCell1(40,6,$x+110,"Name of Account: Kamdhenu Panchgavya ");

	$pdf->Ln(10);

	

	$pdf->setFont('Times','B',12);

	$pdf->myCell1(40,6,$x,"Bill To");$pdf->myCell1(40,6,$x+110,"Ayurved Kendra");

	$pdf->Ln(5);

	$pdf->setFont('Times','',12);

	$pdf->myCell1(40,6,$x,"Mr./Mrs. ".$name);$pdf->myCell1(40,6,$x+110,"A/c no: 0637102000012218");

	$pdf->Ln(5);

	$pdf->myCell1(40,6,$x,"Medicines Given For ".$months." Months");

	

	$pdf->myCell1(40,6,$x+110,"Bank: IDBI");

	$pdf->Ln(5);

	$pdf->myCell1(40,6,$x+110,"IFSC Code: IBKL0000637");

	$pdf->Ln(5);

	$pdf->myCell1(40,6,$x+110,"Type: Current");

	

	

	$col1="Medicine Type";

	$col2="Medicine Name";

	$col3="Given Quantity";

	$col4="Unit Price";

	$col5="Total(In INR)";

	



	$pdf->Ln(10);

	

	$pdf->SetWidths(array(40,80,30,40));

	// $pdf->SetWidths(array(15,30,15));



	// $pdf->SetFont('Times','B',12);

	$pdf->RowHead(array($col1,$col2,$col3,$col5));

	

	$pdf->SetFont('Times','',10);

	for($i=0;$i<count($inv_medicines);$i++){

		$pdf->Row(array($inv_types[$i],$inv_medicines[$i],$inv_given[$i],"Rs.".$inv_total[$i]));

		 // $pdf->Row(array("one","two","three"));

		}

		// var_dump($inv_medicines);

		// var_dump($inv_given);

		// var_dump($inv_total);

		//For Printing the last  4rows of the invoice table

			$lcol1[$i]="";

			$lcol2[$i]="";

			$lcol3[$i]="";

			$lcol4[$i]="";

			

			$temp=0;

			$temp2=0;

			// var_dump(count($inv_total));

			// var_dump(count($inv_weight));

			for($j=0;$j<count($inv_total);$j++)

			{

				$temp+=$inv_total[$j];

				$temp2+=$inv_weight[$j];

			}

			// var_dump($temp2);

			//col1

			$lcol1[0]='Medicine Amount';

			

			$lcol1[1]="Courier ";

			$lcol1[2]="Total Amount to be Paid";

			

			

			$cntunit=0;

			$cntweight=0;

			//Calculating the Courier Charges Based on Weight

			for($j=0;$j<count($mname);$j++)

			{

				$sql1="select Weight from stock_master where Medicine_Name like '".$medicinename[$j]."'";

				$sql2="select Basic from medicine where Medicine_Name like '".$medicinename[$j]."%' limit 1";

				//echo $sql1;

				//echo $sql2;

				

				$resultweight=mysqli_query($conn,$sql1);

				$resultbasic=mysqli_query($conn,$sql2);

				

				$rowweight=mysqli_fetch_assoc($resultweight);

				$rowbasic=mysqli_fetch_assoc($resultbasic);

				

				$cntunit+=$given[$j]/$rowbasic['Basic'];

				$cntweight+=$rowweight['Weight'];

				//echo $rowweight['Weight'];

				

			}

			

			// echo $temp2;



			//courier charges; //first kg at 100 and next 80per kg

			$temp2-=1000;

			$courier=100;

				// echo $courier;

				// echo $temp2;



			if($temp2>0)

			{

				// echo 'entered';



				$t=floor($temp2/1000);

				// echo $t;

				if($t<1){

					$courier+=80;

				}

				else{

					$courier+=$t*80;

					$temp2/=1000;

						

				}



				

				

			}



			// var_dump($temp2."<-temp2".$num."<-num");



			// var_dump($courier);



			//col4

			/* $packing=100;

			$courier=10; */

			$gtotal=$temp+$courier;

			$lcol4[0]="Rs.".$temp."/-";

			$lcol4[1]="Rs.".$courier."/-";

			$lcol4[2]="Rs.".$gtotal."/-";

			$pdf->SetFont('Times','B',11);

			for($i=0;$i<3;$i++){

				$pdf->Row(array($lcol1[$i],"","",$lcol4[$i]));

				

			}

			

			// $pdf->Cell(180,10,"Total Weight:".$cntweight,0,0);

			// $pdf->Ln(4);

			// $pdf->Cell(180,10,"Total Units:".$cntunit,0,0);

			// $pdf->Ln(4);

			

			$pdf->Cell(180,10,"If weight<1000 then courier charges:Rs.100",0,0);

			$pdf->Ln(4);

			$pdf->Cell(180,10,"Above 1kg Couries charges will be Rs.80/- per Kg.",0,0);

			$pdf->Ln(4);

		

}















		

$pdf->Output();



?>