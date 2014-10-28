var express = require('express');
var router = express.Router();

/* GET CV */
router.get('/cv', function(req, res) {
  res.render('cv', {
    title: 'Richard Willis - Freelance Web Developer',
    stylesheets: ['/css/cv.css'],
    showLinks: true
  });
});

router.get('/cv/pdf', function(req, res) {
  res.render('cv', {
    title: 'Richard Willis - Freelance Web Developer',
    stylesheets: ['/css/cv.css', '/css/cv-pdf.css'],
    showLinks: false
  });
});

module.exports = router;