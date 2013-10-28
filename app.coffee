express = require("express")
routes = require("./routes")
user = require("./routes/user")
video = require './routes/video'
account = require './routes/account'
http = require("http")
path = require("path")
login = require './routes/login'
app = express()

passport = require 'passport'
ensureLoggedIn = require('connect-ensure-login').ensureLoggedIn
LocalStrategy = require('passport-local').Strategy

app.set "port", process.env.PORT or 3000
app.set "views", __dirname + "/views"
app.set "view engine", "jade"
app.use express.favicon()
app.use express.logger("dev")
app.use express.methodOverride()
app.use express.static(path.join(__dirname, "public"))
app.use express.cookieParser()
app.use express.bodyParser()
app.use express.session({ secret: 'my-unique-secret' })
app.use passport.initialize()
app.use passport.session()

app.use (req, res, next)->
  res.locals.loggedInUser = req.session.user
  next()

app.use app.router

myUser = process.env.USER || 'ravi'
myPass = process.env.PASSWORD || 'pass'

passport.serializeUser (user, done)->
  done(null, user)
 
passport.deserializeUser (obj, done)->
  done(null, obj)

passport.use new LocalStrategy (username, password, done)->
  console.log 'check user: ', username
  if (username == myUser and password == myPass)
    done null, {username: username}
  else
    done null, false, {message: 'Invalid username/password'}

# development only
app.use express.errorHandler()  if "development" is app.get("env")
app.get "/", ensureLoggedIn('/login'), routes.index
app.get "/users", ensureLoggedIn('/login'), user.list
app.get "/videos", ensureLoggedIn('/login'), video.list
app.get '/account', ensureLoggedIn('/login'), account.home
app.post '/login', passport.authenticate('local'), (req, res)->
  req.session.user = req.body.username
  console.log 'Logged in user: ', req.session.user
  res.redirect('/')

app.get '/login', login.login
app.get '/logout', login.logout

http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")

