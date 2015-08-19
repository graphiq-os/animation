
module.exports.handle = (req, res, status, error) ->
	res.status status
		.render status,
			error: error