module.exports = (express, authService, logService) ->
  authRouter = express.Router()

  authRouter.get '/', (req, res) ->
    res.json
      succes: true
      message: 'Bem vindo à API! Esse é o único endereço da aplicação que você pode acessar sem um token'

  authRouter.post '/auth', (req, res) ->
    authService.login req.body.company, req.body.chaveAcesso, res, (message)->
      res.json message
    
  authRouter.use (req, res, next) -> 
    console.log("teste")
    token = req.body?.token or req.query?.token or req.headers['x-access-token']
    console.log token
    authService.verify token, (error, decoded) ->
      console.log(res.status)
      if error
        console.log(res.status)
        res.status(203).send
          # success: false
          # message: error.message
      else
        req.decoded = decoded
        next()        
    return

  authRouter.use (req, res, next) ->
    logService.logRequest req
    next()

  authRouter.use (req, res, next) -> 
    res.redirect req.decoded.url + req.originalUrl



  authRouter.get '/teste', (req, res) ->
    res.json
      success: true
      message: 'Você acessou uma sessão segura de nossa API! Seja bem-vindo(a) ' + req.decoded.username

  return authRouter