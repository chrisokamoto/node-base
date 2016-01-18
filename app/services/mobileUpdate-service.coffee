module.exports = (MobileUpdate, config) ->
  MobileUpdateService = 
    check_version: (version, res, callback) ->
      MobileUpdate.getMobileUpdateByVersion version, (mobileUpdate) ->
        if !mobileUpdate
            res.status(500).send
            callback success: false,
            message: 'Falha: Nenhuma versão disponível'

        else
          if version < mobileUpdate.version
              callback success: true,
              message: 'Versão desatualizada. Por favor, atualize a versão.'
            else
              callback success: true,
              message: 'Versão atual é a mais recente.'

  return MobileUpdateService
