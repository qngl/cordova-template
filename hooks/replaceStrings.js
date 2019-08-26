#!/usr/bin/env node
'use strict';

var fs = require('fs');
var path = require('path');

var rootdir = './';

function replaceStringInFile(filename, toReplace, replaceWith) {
  var data = fs.readFileSync(filename, 'utf8');

  var result = data.replace(new RegExp(toReplace, 'g'), replaceWith);

  fs.writeFileSync(filename, result, 'utf8');
}

var BASEURL = '';
var BASEDOMAIN = '';

if (process.env.BASEURL) {
  BASEURL = process.env.BASEURL;
}
if (process.env.BASEDOMAIN) {
  BASEDOMAIN = process.env.BASEDOMAIN;
}

if (rootdir) {
  var filestoreplace = [
    'www/index.html',
  ];

  filestoreplace.forEach(function(val, index, array) {
    var fullfilename = path.join(rootdir, val);

    if (fs.existsSync(fullfilename)) {
      replaceStringInFile(fullfilename, '"connection\\.', '"' + (BASEURL ? BASEURL + '/connection.' : 'connection.'));
      replaceStringInFile(fullfilename, '"app\\.', '"' + (BASEURL ? BASEURL + '/app.' : 'app.'));
      replaceStringInFile(fullfilename, '"bpp\\.', '"' + (BASEURL ? BASEURL + '/bpp.' : 'bpp.'));
      replaceStringInFile(fullfilename, '"others\\.', '"' + (BASEURL ? BASEURL + '/others.' : 'others.'));
      replaceStringInFile(fullfilename, '"runtime\\.', '"' + (BASEURL ? BASEURL + '/runtime.' : 'runtime.'));
      replaceStringInFile(fullfilename, 'https://www.abc.com', BASEDOMAIN);
    }
  });
}
