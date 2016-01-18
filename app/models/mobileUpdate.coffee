module.exports = (mongoose) ->
  Schema = mongoose.Schema

  MobileUpdateSchema = new Schema({
    version: Number
    file: Buffer
  }, { collection: 'mobileUpdates' });

  #Métodos estáticos
  MobileUpdateSchema.statics.getMobileUpdateByVersion = (version, callback) ->
    this.findOne( ).exec (error, mobileUpdate) ->
      throw error if error
      callback mobileUpdate

  return mongoose.model 'MobileUpdate', MobileUpdateSchema