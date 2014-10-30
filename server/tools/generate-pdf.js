/*jshint node: true*/
/*global phantom: true*/

'use strict';

var system = require('system');
var args = system.args;
var url = args[1];

if (!url) {
  console.error('Please specify URL as first argument.')
  phantom.exit();
}

var webPage = require('webpage');
var page = webPage.create();

page.zoomFactor = 0.8;

page.onError = function (msg, trace) {
  console.log(msg);
  trace.forEach(function(item) {
    console.log('  ', item.file, ':', item.line);
  });
};

page.viewportSize = {
  width: 1024,
  height: 600
};

page.paperSize = {
  format: 'A4',
  orientation: 'portrait',
  margin: {
    top: '1cm',
    left: '1cm',
    right: '1cm',
    bottom: '0'
  },
  footer: {
    height: '1cm',
    margin: 0,
    contents: phantom.callback(function createFooter(pageNum, numPages) {

      // PhantomJS 1.9 does not support CSS classes for the footer region.

      var styles = (function(obj) {
        return Object.keys(obj).map(function(key) {
          return key + ':' + obj[key];
        }).join(';');
      }({
        'text-align': 'center',
        'color': '#666',
        'font-size': '10px',
        'letter-spacing': '1px',
        'padding-top': '10px'
      }));

      return '<div style="'+styles+'">Page ' + pageNum + ' / ' + numPages + '</div>';
    })
  }
};

page.open(url, function open(status) {

  if (status !== 'success') {
    console.error('Unable to open page for PDF generation!');
    phantom.exit();
    return;
  }

  page.evaluate(function() {
    [].slice.call(document.querySelectorAll('a[href]')).forEach(function(a){
      var contents = a.innerHTML + ' [<span class="pdf-link">' + a.href.replace(/(http:\/\/)|(\/$)/g, '') + '</span>]';
      var elem = document.createElement('span');
      elem.innerHTML = contents;
      a.parentNode.replaceChild(elem, a);
    });
  });

  var pdfPath = 'public/downloads/richard-willis-cv.pdf';

  page.render(pdfPath, {
    format: 'pdf',
    quality: '100'
  });

  console.log('Generated PDF at path: ' + pdfPath);

  phantom.exit();
});