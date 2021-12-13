var JWTStrategy = require('passport-jwt').Strategy
var ExtractJWT = require('passport-jwt').ExtractJwt

var User = require('../models/user')
var config = require('./dbConfig')

module.exports = function(passport) {
    var opts = {};

    opts.secretOrKey = config.secret;
    opts.jwtFromRequest = ExtractJWT.fromAuthHeaderWithScheme('jwt');

    passport.use(new JWTStrategy(opts, function(jwtPayload, done) {
        User.find({
            id: jwtPayload.id
        }, function(err, user) {
            if (err) return done(err, false);
            if (user) done(null, user);
            else return done(null, false);
        })
    }))
}