morgan = require 'morgan'
config = require './config'
fs = require 'fs'

module.exports =
	getLogFormat: ->
		config.log.format

	getLogOptions: ->
		options = {}

		try
			if 'stream' in config.log.options
				options = 
					stream: fs.createWriteStream process.cwd() + '/' + config.log.options.stream, {flag: 'a'}
		catch e
			options = {}

		options