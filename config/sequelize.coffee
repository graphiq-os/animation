fs = require 'fs'
path = require 'path'
Sequelize = require 'sequelize'
_ = require 'lodash'
config = require './config'
db = {}

# TODO: add configuration
console.log 'Initializing Sequelize'
# create your instance of sequelize
sequelize = new Sequelize config.db.name, config.db.username, config.db.password,
	host: config.db.host
	dialect: 'mysql'
	storage: config.db.storage

# Loop through all files in models directory ignoring hidden files and this files
fs.readdirSync config.modelsDir
	.filter (file) ->
		file.indexOf('.') isnt 0 and file isnt 'index.js'
	.forEach (file) ->
		console.log 'Loading model file ' + file
		model = sequelize.import path.join config.modelsDir, file
		db[model.name] = model

# invoke associations on each of the models
Object.keys db
	.forEach (modelName) ->
		if db[modelName].options.hasOwnProperty 'associate'
			db[modelName].options.associate db

# Synchronizing any models changes with database
# WARNING: this will DROP your database everytime you re-run your application

if process.env.NODE_RECREATE_DB
	sequelize
		.sync 
			force: true
		.then ->
			console.log 'Database dropped and synchronized'
		, (err) ->
			console.log 'An error occured %j', err
			

# assign the sequelize variables to the db object and returning the db
module.exports = _.extend
	sequelize: sequelize
	Sequelize: Sequelize
	, db