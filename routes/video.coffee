fs = require 'fs'
path = require 'path'

exports.list = (req, res)->
  videosPath = path.join(__dirname, "../public/videos")
  files = fs.readdirSync(videosPath) || []

  res.render 'videos', 
    videos: files
