passport = require 'passport'

exports.login = (req, res)->
  res.render 'login'

exports.logout = (req, res)->
  req.session.user = undefined
  req.logout()
  res.locals.loggedInUser = undefined
  res.redirect '/'

exports.checkLogin = (req, res)->
  console.log 'checking logins...'

