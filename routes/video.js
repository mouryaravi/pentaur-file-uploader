// Generated by CoffeeScript 1.6.3
(function() {
  var fs, path;

  fs = require('fs');

  path = require('path');

  exports.list = function(req, res) {
    var files, videosPath;
    videosPath = path.join(__dirname, "../public/videos");
    files = fs.readdirSync(videosPath) || [];
    return res.render('videos', {
      videos: files
    });
  };

}).call(this);