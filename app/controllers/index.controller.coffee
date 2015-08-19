# Module dependencies
config = require '../../config/config'
error = require './error.controller'
converter = require '../lib/converter'

exports.index = (req, res) ->
	console.log 'here'
	res.render 'index',
		url: req.query.url
		config: config

exports.convert = (req, res) ->
	url = req.body.url
	duration = req.body.duration

	converter.convert url, duration
		.then (output) -> 
			res.send { url: output }
		, (err) -> 
			console.log 'error: ' + err
			res.status 400
				.send { error: '' + err }
