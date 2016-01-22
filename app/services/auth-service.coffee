module.exports = (Company, jwt, config) ->
  AuthService = 
    login: (company_name, chaveAcesso, res, callback) ->
      Company.getCompanyByKey company_name, chaveAcesso, (company) ->
        if !company
            console.log "ERRO 203 - AUTH-SERVICE"
            res.status(203).send
            callback success: false,
            message: 'Falha na autenticação: Empresa não encontrada'

        else
          if company.chaveAcesso isnt chaveAcesso

              callback success: false,
              message: 'Falha na autenticação: Chave de acesso incorreta.'
            else
              token = jwt.sign({id: company._id, company: company.name, url: company.url}, config.secret, expiresInMinutes: 1440)
              
              callback success: true,
              message: 'Empresa autenticada com sucesso! Token emitido.',
              token: token
    verify: (token, callback) ->
      if !token
        callback message: 'Token de autenticação não enviado.'
      else jwt.verify token, config.secret, (error, decodedInfo) ->
        if error
          callback message: 'Token de autenticação inválido.'
        else
          callback null, decodedInfo

  return AuthService
