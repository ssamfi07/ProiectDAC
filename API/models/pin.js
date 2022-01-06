var mongoose = require('mongoose');
var Schema = mongoose.Schema;
var bcrypt = require('bcrypt');
const { post } = require('../routes/router');

var pinSchema = new Schema({
    username: {
        type: String,
        required: false // added by default
    },
    location: {
        type: String,
        required: true
    },
    title: {
        type: String,
        required: true
    },
    description: {
        type: String,
        required: false // optional
    }
})

module.exports = mongoose.model('Pin', pinSchema);