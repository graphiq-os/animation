path = require 'path'
rootPath = path.normalize __dirname + '/../..'

module.exports =
  app:
  	name: 'GraphQ'
		title: 'GraphQ'
  root: rootPath
  modelsDir: rootPath + '/app/models'
  
  port: process.env.PORT || 3000

  log:
  	format: 'combined'
  	options:
  		stream: 'access.log'

  video:
    fps: 24
    duration: 2