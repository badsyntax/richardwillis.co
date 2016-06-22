var path = require('path');
var nconf = require('nconf');

nconf.argv().env().file({
  file: path.join(__dirname, 'app.' + (nconf.get('NODE_ENV') || 'production') + '.json')
});

module.exports = nconf;
