module.exports = (Log, config) ->	
	LogService =
		logRequest: (req)->	
			if config.logging is on
				log = new Log
				log.date = new Date
				log.headers = req.headers
				log.ip = req.ip
				log.method = req.method
				log.originalUrl = req.originalUrl
				log.body = req.body
				log.params = req.params
				log.smartUrl = req.decoded.url
				log.company = req.decoded.company

				log.save (err) ->
				  console.log err if err

	return LogService