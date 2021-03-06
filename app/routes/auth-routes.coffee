module.exports = (express, authService, logService, mobileUpdateService) ->
  authRouter = express.Router()

  authRouter.get '/', (req, res) ->
    res.json
      succes: true
      message: 'Bem vindo à API! Esse é o único endereço da aplicação que você pode acessar sem um token'

  authRouter.post '/auth', (req, res) ->
    authService.login req.body.company, req.body.chaveAcesso, res, (message)->
      res.json message


  authRouter.use (req, res, next) ->
    token = req.body?.token or req.query?.token or req.headers['x-access-token']
    authService.verify token, (error, decoded) ->
      if error
        res.status(203).send
          success: false
          message: error.message
      else
        req.decoded = decoded
        next()
    return

  authRouter.use (req, res, next) ->
    logService.logRequest req
    next()

  authRouter.use (req, res, next) ->

    url = req.decoded.url + req.originalUrl

    if url.indexOf("mobileUpdate") == -1
      if req.method == 'POST'
        request = require 'request'
        response = request {
            url: url
            method: 'POST'
            form: req.body
        }, (error, response, body) ->
            if error
              res.status(500).send
                success: false
                message: 'Dados não sincronizados'
            else
              res.status(200).send
                success: true
                message: 'Sincronizados'
      else
        res.redirect(url)
    else
      next()

  return authRouter