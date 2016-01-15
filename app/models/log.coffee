module.exports = (mongoose) ->
  Schema = mongoose.Schema

  LogSchema = new Schema(
    date: Date
    ip: String
    method: String
    originalUrl: String
    headers: Schema.Types.Mixed
    body: Schema.Types.Mixed
    params: Schema.Types.Mixed
    smartUrl: String
    company: String
  )

  return mongoose.model 'Log', LogSchema