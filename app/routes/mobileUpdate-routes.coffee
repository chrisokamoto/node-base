MobileUpdate = require '../models/mobileUpdate'
multipart = require('connect-multiparty');
multipartMiddleware = multipart();

module.exports = (express, mobileUpdateService) ->
  mobileUpdateRouter = express.Router()

  mobileUpdateRouter.post '/', (req, res) ->
    mobileUpdateService.check_version req.body.version, res, (message)->
      res.json message

  mobileUpdateRouter.post '/update_version', multipartMiddleware, (req, res) ->
    mobileUpdateService.update_version req.body.version, req.files.file.path, res, (message) ->
      res.json message

  mobileUpdateRouter.get '/', (req, res) ->
    mobileUpdateService.download_apk req, res, (message) ->
      res.json message
    
  mobileUpdateRouter.use (req, res, next) -> 
    mobileUpdateService.check_version req.body.version, (error, decoded) ->
      if error
        res.status(500).send
          success: false
          message: error.message      
    return

  return mobileUpdateRouter