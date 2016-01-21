fs = require('fs') #FileSystem
path = require('path');
mime = require('mime');

module.exports = (MobileUpdate, config) ->
  MobileUpdateService = 
    check_version: (version, res, callback) ->
      console.log "check_version"
      MobileUpdate.getLastMobileUpdate (mobileUpdate) ->
        if !mobileUpdate
            res.status(500).send
            callback success: false,
            message: 'Falha: Nenhuma versão disponível'

        else
          if version < mobileUpdate.version
              callback success: true,
              message: 'Versão desatualizada. Por favor, atualize a versão.'
            else
              res.status(204).send
              callback success: true,
              message: 'Versão atual é a mais recente.'

    update_version: (version, file_path, res, callback) ->
      MobileUpdate.getLastMobileUpdate (mobileUpdate) ->
        if !mobileUpdate
          mobileUpdate = new MobileUpdate()

        # read binary data
        fileData = fs.readFileSync(file_path)        
        Buffer newBufferFile = new Buffer(fileData).toString('base64') 
        
        mobileUpdate.version = version ? version : 0
        mobileUpdate.file = newBufferFile

        if mobileUpdate.save()
          callback success: true,
          message: 'Versão atualizada com sucesso.'
        else
          res.status(500).send
          callback sucess: false,
          message: 'Erro ao atualizar versão.'

    download_apk: (res, callback) ->
      MobileUpdate.getLastMobileUpdate (mobileUpdate) ->
        if mobileUpdate
          binaryData = new Buffer(mobileUpdate.file.toString(), 'base64');
          file = './msmart_update.txt'
          # console.log mobileUpdate.file.toString()
          
          filename = path.basename(file)
          mimetype = mime.lookup(file)

          res.setHeader('Content-disposition', 'attachment; filename=' + filename)
          res.setHeader('Content-type', mimetype)

          fs.writeFileSync(file, "teste")  
          res.end()                  

          callback success: true,
          message: "Download bem sucedido."          
        else
          callback success: false,
          message: "Versão não encontrada."

  return MobileUpdateService
