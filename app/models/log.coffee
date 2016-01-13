mongoose = require 'mongoose'
Schema = mongoose.Schema

LogSchema = new Schema(
  date: Date
  ip: String
  method: String
  url: String
  headers: Schema.Types.Mixed
  body: Schema.Types.Mixed
  params: Schema.Types.Mixed
)

module.exports = mongoose.model 'Log', LogSchema