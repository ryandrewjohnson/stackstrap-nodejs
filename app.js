var express = require('express');

var app = express();

app.get('/hello.txt', function(req, res){
  "use strict";
  res.send('Hello World hey hey');
});

app.listen(3000);
console.log('Listening on port 3000');
