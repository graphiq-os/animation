
index = require './controllers/index.controller'

module.exports = (app) ->
	console.log 'Initializing Routes...'

	app.route '/'
		.get index.index

	app.route '/convert'
		.post index.convert