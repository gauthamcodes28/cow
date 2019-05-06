var dataSet = [
    [ "Tiger Nixon", "123456789", "Hyderabad", "5421"],
    [ "Garrett Winters", "987654321", "Mumbai", "8422"],
    [ "Ashton Cox", "741852963", "Pune", "1562"],
	[ "Tiger Nixon", "123456789", "Hyderabad", "5421"],
    [ "Garrett Winters", "987654321", "Mumbai", "8422"],
    [ "Ashton Cox", "741852963", "Pune", "1562"],
	[ "Tiger Nixon", "123456789", "Hyderabad", "5421"],
    [ "Garrett Winters", "987654321", "Mumbai", "8422"],
    [ "Ashton Cox", "741852963", "Pune", "1562"],
	[ "Tiger Nixon", "123456789", "Hyderabad", "5421"],
    [ "Garrett Winters", "987654321", "Mumbai", "8422"],
    [ "Ashton Cox", "741852963", "Pune", "1562"],
	[ "Tiger Nixon", "123456789", "Hyderabad", "5421"],
    [ "Garrett Winters", "987654321", "Mumbai", "8422"],
    [ "Ashton Cox", "741852963", "Pune", "1562"],
	[ "Tiger Nixon", "123456789", "Hyderabad", "5421"],
    [ "Garrett Winters", "987654321", "Mumbai", "8422"],
    [ "Ashton Cox", "741852963", "Pune", "1562"],
	[ "Tiger Nixon", "123456789", "Hyderabad", "5421"],
    [ "Garrett Winters", "987654321", "Mumbai", "8422"],
    [ "Ashton Cox", "741852963", "Pune", "1562"],
	[ "Tiger Nixon", "123456789", "Hyderabad", "5421"],
    [ "Garrett Winters", "987654321", "Mumbai", "8422"],
    [ "Ashton Cox", "741852963", "Pune", "1562"],
	[ "Tiger Nixon", "123456789", "Hyderabad", "5421"],
    [ "Garrett Winters", "987654321", "Mumbai", "8422"],
    [ "Ashton Cox", "741852963", "Pune", "1562"],
	[ "Tiger Nixon", "123456789", "Hyderabad", "5421"],
    [ "Garrett Winters", "987654321", "Mumbai", "8422"],
    [ "Ashton Cox", "741852963", "Pune", "1562"]
    
];
 
$(document).ready(function() {
    $('#example').DataTable( {
        data: dataSet,
        columns: [
            { title: "Name" },
            { title: "Phone" },
            { title: "Date Of Birth" },
            { title: "Address" }
        ],
		 responsive: true
    } );
} );