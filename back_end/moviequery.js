var express = require('express')
var app = express();
var mysql = require('mysql');

var con = mysql.createConnection({
  host: "localhost",
  user: "isaiah",
  password: "PASSword",
  database : 'md',
});

con.connect(function(err) {
  if (err) throw err;
  con.query("SELECT name FROM movie", function (err, result) {
    if (err){
    	throw err;
    }
    else {
    	console.log(result);
    	result //How to transfer this to app.js without it resulting in unidentified
	}
  });
  con.end();
});


/*
app.get('/yourpage',function(req,res){

    //On request of this page initiating sql query. Assumes that the object initialization is done above.
    con.query(
    selectQuery,
    function select(error, results, fields) {
        if(error) {
            console.log(error);
            mySqlClient.end();
            //render the template with error to be alerted
            res.render('tempaltefile',{data:null,error:error});                
        }

        if(results.length > 0) {
            //console.log(results);
            //render the template with fetched data
            res.render('tempaltefile',{data:results,error:null});
        } else {
            //console.log('No data');
            //render the template with empty data alert
            res.render('tempaltefile',{data:null,error:"no data"});
        }
        mySqlClient.end();
    });

});
*/