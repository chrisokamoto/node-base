module.exports = (mongoose) ->
  Schema = mongoose.Schema

  CompanySchema = new Schema(
    name: String
    chaveAcesso: String
    url: String
  )

  #Métodos estáticos
  CompanySchema.statics.getCompanyByNameAndKey = (name, chaveAcesso, callback) ->
    this.findOne( chaveAcesso: chaveAcesso ).exec (error, company) ->
      throw error if error
      callback company
  return mongoose.model 'Company', CompanySchema