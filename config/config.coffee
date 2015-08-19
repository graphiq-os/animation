_ = require 'lodash'

resolveConfig = ()->
  conf = {}

  conf = _.extend(
  	require('./env/all'),
  	require('./env/' + process.env.NODE_ENV) || {}
  )

  return conf

module.exports = resolveConfig()