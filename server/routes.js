var fs = require('fs');
var express = require('express');
var moment = require('moment');
var _ = require('lodash');
var router = express.Router();

var stats = fs.statSync('./server/views/cv.ejs');
var lastUpdated = moment(new Date(stats.mtime)).format('Do MMMM YYYY');

var viewData = {
  title: 'Richard Willis - Freelance Web Developer',
  stylesheets: ['/css/style.css'],
  showLinks: true
};

/* GET Home */
router.get('/', function(req, res) {
  res.render('home', _.extend({}, viewData, {
    pageClass: 'home'
  }));
});

/* GET Showcase */
router.get('/showcase', function(req, res) {
  res.render('showcase', _.extend({}, viewData, {
    title: 'Richard Willis - Freelance Web Developer - Showcase',
    pageClass: 'showcase'
  }));
});

/* GET CV */
router.get('/cv', function(req, res) {
  res.render('cv', _.extend({}, viewData, {
    lastUpdated: lastUpdated,
    pageClass: 'cv'
  }));
});

/* GET CV PDF version */
router.get('/cv/pdf', function(req, res) {
  res.render('cv', _.extend({}, viewData, {
    showLinks: false,
    lastUpdated: lastUpdated,
    pageClass: 'cv'
  }));
});

/* GET CV Download */
router.get('/cv/download', function(req, res) {
  var file = './public/downloads/richard-willis-cv.pdf';
  res.download(file);
});

module.exports = router;