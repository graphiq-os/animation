# Module dependencies
config = require '../../config/config'
error = require './error.controller'
converter = require '../lib/converter'
fs = require 'fs'

exports.index = (req, res) ->
	if req.query.download is 'true'
		url = req.query.url
		time = (parseInt req.query.time) || 2
		play = req.query.play is 'true'

		converter.convert url, time, play
			.then (output) -> 
				file = config.root + '/public/' + output
				res.setHeader 'Content-type', 'video/mp4'
				filestream = fs.createReadStream file
				filestream.pipe res
			, (err) -> 
				console.log 'error: ' + err
				res.status 400
					.send { error: '' + err }
	else
		res.render 'index',
			url: req.query.url
			play: req.query.play
			download: req.query.download
			time: req.query.time
			config: config

exports.convert = (req, res) ->
	url = req.body.url
	duration = req.body.duration
	play = req.body.play_graphiq

	converter.convert url, duration, play
		.then (output) -> 
			res.send { url: output }
		, (err) -> 
			console.log 'error: ' + err
			res.status 400
				.send { error: '' + err }
