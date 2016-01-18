MobileUpdate = require '../models/mobileUpdate'

module.exports = (express, mobileUpdateService) ->
  mobileUpdateRouter = express.Router()

  mobileUpdateRouter.post '/check_version', (req, res) ->
    mobileUpdateService.check_version req.body.version, res, (message)->
      res.json message
    
  mobileUpdateRouter.use (req, res, next) -> 
    mobileUpdateService.check_version req.body.version, (error, decoded) ->
      if error
        res.status(500).send
          success: false
          message: error.message      
    return

  return mobileUpdateRouter