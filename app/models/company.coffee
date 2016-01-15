module.exports = (mongoose) ->
  Schema = mongoose.Schema

  CompanySchema = new Schema(
    name: String
    key: String
    url: String
  )

  #Métodos estáticos
  CompanySchema.statics.getCompanyByNameAndKey = (name, key, callback) ->
    this.findOne( key: key ).exec (error, company) ->
      throw error if error
      callback company
  return mongoose.model 'Company', CompanySchema