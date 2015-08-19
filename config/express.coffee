express = require 'express'
flash = require 'connect-flash'
helpers = require 'view-helpers'
http = require 'http'
https = require 'https'
morgan = require 'morgan'
bodyParser = require 'body-parser'
session = require 'express-session'
compression = require 'compression'
methodOverride = require 'method-override'
cookieParser = require 'cookie-parser'
helmet = require 'helmet'
config = require './config'
logger = require './logger'
consolidate = require 'consolidate'

module.exports = (db) ->

	console.log """
		Initializing Express...
	"""

	app = express()

	app.use (req, res, next) ->
		res.locals.url = req.protocol + '://' + req.headers.host + req.url
		next()

	app.use compression
		filter: (req, res) ->
			(/json|text|javascript|css/).test res.getHeader 'Content-Type'
		,
		level: 3

	app.set 'showStackError', true

	# Set views path, template engine and default layout
	app.engine 'jade', consolidate['jade']
	app.set 'view engine', 'jade'
	app.set 'views', config.root + '/app/views'

	app.use morgan logger.getLogFormat(), logger.getLogOptions()

	if process.env.NODE_ENV is 'production'
		app.locals.cache = 'memory'
	else
		app.set 'view cache', false

	app.use bodyParser.urlencoded
		extended: true

	app.use bodyParser.json()
	app.use methodOverride()

	app.use helmet.xframe()
	app.use helmet.xssFilter()
	app.use helmet.nosniff()
	app.use helmet.ienoopen()
	app.disable 'x-power-by'

	# Setting the fav icon and static folder
	app.use express.static config.root + '/public'

	app.use cookieParser()

	app.use session
		saveUninitialized: true
		resave: true
		secret: '$uper$ecret$e$$ionKey'
		cookie: 
			path: '/'
			httpOnly: true
			secure: false
			maxAge: null
		name: 'connect.sid'

	app.use flash()

	# use passport session
	# app.use passport.initialize()
	# app.use passport.session()

	(require config.root + '/app/routes') app

	app.use (err, req, res, next) ->
		if !err
			return next()

		console.error err.stack

		res.status 500
			.render '500',
				error: err.stack

	app.use (req, res) ->
		res.status 404,
			url: req.originalUrl,
			error: 'Not Found'

	app

