# Load config
env = process.env.NODE_ENV = process.env.NODE_ENV || 'local'
config = require './config/config'
# db = require './config/sequelize'

# Initialize express
app = (require './config/express') null

# Start the app by listening on <port>
port = process.env.PORT || config.port
app.listen port

console.log """
	Express app started on port #{port}
"""

# Expose app
exports = module.exports = app