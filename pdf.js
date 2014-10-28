var webPage = require('webpage');
var page = webPage.create();

page.viewportSize = {
  width: 1920,
  height: 1080
};

page.open('http://localhost:8000/cv/pdf', function start(status) {
  page.render('public/downloads/richard-willis-cv-2014.pdf', {
    format: 'pdf',
    quality: '100'
  });
  phantom.exit();
});