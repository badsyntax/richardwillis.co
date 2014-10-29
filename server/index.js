var path = require('path');
var express = require('express');

var config = require('./config');
var routes = require('./routes');
var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

// Setup view helpers
var helpers = require('express-helpers')();
Object.keys(helpers).forEach(function(key) {
  if (typeof helpers[key] === 'function') {
    app.locals[key] = helpers[key];
  }
});

app.use('/', routes);

var server = app.listen(config.get('port'), function() {
  console.log('Listening on port %d', server.address().port);
});

module.exports = app;
