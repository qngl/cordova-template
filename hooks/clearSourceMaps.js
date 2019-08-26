#!/usr/bin/env node
'use strict';

var fs = require('fs');
var path = require('path');

var rootdir = './';

function rm(filename) {
  fs.unlinkSync(filename);
}

if (rootdir) {
  var filestoreplace = [
    'www/app.css.map',
    'www/app.js.map',
    'www/vendor.css.map',
    'www/vendor.js.map',
    'www/manifest.js.map'
  ];

  filestoreplace.forEach(function(val, index, array) {
    var fullfilename = path.join(rootdir, val);

    if (fs.existsSync(fullfilename)) {
      rm(fullfilename);
    }
  });
}
