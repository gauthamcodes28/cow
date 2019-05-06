 var dataSet = [
    [ "<input type='checkbox'>", "<textarea class='form-control' style='height:40px;'>Hello World</textarea>", "<textarea class='form-control' style='height:40px;'></textarea>","<textarea class='form-control' style='height:40px;'></textarea>","<textarea class='form-control' style='height:40px;'></textarea>","<textarea class='form-control' style='height:40px;'></textarea>"],
	[ "<input type='checkbox'>", "<textarea class='form-control' style='height:40px;'></textarea>", "<textarea class='form-control' style='height:40px;'></textarea>","<textarea class='form-control' style='height:40px;'></textarea>","<textarea class='form-control' style='height:40px;'></textarea>","<textarea class='form-control' style='height:40px;'></textarea>"],
	[ "<input type='checkbox'>", "<textarea class='form-control' style='height:40px;'></textarea>", "<textarea class='form-control' style='height:40px;'></textarea>","<textarea class='form-control' style='height:40px;'></textarea>","<textarea class='form-control' style='height:40px;'></textarea>","<textarea class='form-control' style='height:40px;'></textarea>"],
	[ "<input type='checkbox'>", "<textarea class='form-control' style='height:40px;'></textarea>", "<textarea class='form-control' style='height:40px;'></textarea>","<textarea class='form-control' style='height:40px;'></textarea>","<textarea class='form-control' style='height:40px;'></textarea>","<textarea class='form-control' style='height:40px;'></textarea>"],
	[ "<input type='checkbox'>", "<textarea class='form-control' style='height:40px;'></textarea>", "<textarea class='form-control' style='height:40px;'></textarea>","<textarea class='form-control' style='height:40px;'></textarea>","<textarea class='form-control' style='height:40px;'></textarea>","<textarea class='form-control' style='height:40px;'></textarea>"],
	[ "<input type='checkbox'>", "<textarea class='form-control' style='height:40px;'></textarea>", "<textarea class='form-control' style='height:40px;'></textarea>","<textarea class='form-control' style='height:40px;'></textarea>","<textarea class='form-control' style='height:40px;'></textarea>","<textarea class='form-control' style='height:40px;'></textarea>"],
	[ "<input type='checkbox'>", "<textarea class='form-control' style='height:40px;'></textarea>", "<textarea class='form-control' style='height:40px;'></textarea>","<textarea class='form-control' style='height:40px;'></textarea>","<textarea class='form-control' style='height:40px;'></textarea>","<textarea class='form-control' style='height:40px;'></textarea>"],
	[ "<input type='checkbox'>", "<textarea class='form-control' style='height:40px;'></textarea>", "<textarea class='form-control' style='height:40px;'></textarea>","<textarea class='form-control' style='height:40px;'></textarea>","<textarea class='form-control' style='height:40px;'></textarea>","<textarea class='form-control' style='height:40px;'></textarea>"],
	[ "<input type='checkbox'>", "<textarea class='form-control' style='height:40px;'></textarea>", "<textarea class='form-control' style='height:40px;'></textarea>","<textarea class='form-control' style='height:40px;'></textarea>","<textarea class='form-control' style='height:40px;'></textarea>","<textarea class='form-control' style='height:40px;'></textarea>"]
    
]; 

//var dataSet=[["hello","guru","tre","f","v","s"],["hello","guru","tre","f","v","s"]];
 
$(document).ready(function() {
    $('#medication_table').DataTable( {
        data: dataSet,
		"paging":   false,
        "ordering": false,
        "info":     false,
		"bFilter":false,
        columns: [
            { title: "<input type='checkbox'>" },
            { title: "Type" },
			{ title: "Name" },
            { title: "Quantity" },
            { title: "When to take" },
			{ title: "How to take" }
        ],
		 responsive: true
    } );
} );