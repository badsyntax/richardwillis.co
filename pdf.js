var webPage = require('webpage');
var page = webPage.create();

page.viewportSize = {
  width: 960,
  height: 1080
};

page.zoomFactor = 0.8;

page.viewportSize = { width: 600, height: 600 };

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
    contents: phantom.callback(function(pageNum, numPages) {
      // PhantomJS 1.9 does not support CSS classes for footer region.
      return '<div style="text-align:center;color:#666;font-size:10px;letter-spacing:1px;padding-top:10px;">Page ' + pageNum + ' / ' + numPages + '</div>';
    }),
  }
};

page.open('http://localhost:8000/cv/pdf', function start(status) {

  page.evaluate(function() {
    [].slice.call(document.querySelectorAll('a[href]')).forEach(function(a){
      a.innerHTML += ' [<b>' + a.href.replace(/(http:\/\/)|(\/$)/g, '') + '</b>]';
      a.href = '';
    });
  });

  page.render('public/downloads/richard-willis-cv-2014.pdf', {
    format: 'pdf',
    quality: '100'
  });
  phantom.exit();
});