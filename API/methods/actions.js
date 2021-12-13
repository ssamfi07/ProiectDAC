var User = require('../models/user')
var jwt = require('jwt-simple')
var config = require('../config/dbConfig')

var functions = {
    addNewUser: function(req, res) {
        if ((!req.body.name) || (!req.body.password)) {
            res.json({ success: false, message: 'Enter all fields' }) // make the user fill all the fields
        } else {
            User.findOne({ name: req.body.name },
                function(err, user) {
                    if (err) throw err;
                    if (user) { // username already present, don't allow to create new user
                        res.json({ success: false, message: 'Username already present' });
                    } else {
                        var newUser = new User({
                            name: req.body.name,
                            password: req.body.password
                        });
                        newUser.save(function(err, newUser) { // check if user is status to the database 
                            if (err) {
                                res.json({ success: false, message: 'Failed to save' });
                            } else {
                                res.json({ success: true, message: 'Successfully saved' });
                            }
                        })
                    }
                }
            )
        }
    },
    login: function(req, res) {
        User.findOne({
            name: req.body.name
        }, function(err, user) {
            if (err) throw err;
            if (!user) res.status(403).send({ success: false, message: 'Authentication failed, user not found' })
            else {
                user.comparePassword(req.body.password, function(err, isMatch) {
                    if (isMatch && !err) // send token
                    {
                        var jwtToken = jwt.encode(user, config.secret);
                        res.json({ success: true, token: jwtToken })
                    } else {
                        return res.status(403).send({ success: false, message: 'Authentication failed, wrong password' });
                    }
                })
            }
        })
    },
    getInfo: function(req, res) { // --get the token from the auth header
        if (req.headers.authorization && req.headers.authorization.split(' ')[0] === 'Bearer') {
            var token = req.headers.authorization.split(' ')[1];
            var decodedToken = jwt.decode(token, config.secret);
            return res.json({ success: true, message: 'Hello ' + decodedToken.name });
        } else {
            return res.json({ success: false, message: 'No headers' });
        }
    },
    users: function(res) {
        User.forEach({}, function(res, user) {
            res.status(200).send({ username: user.username, password: user.password })
        })
    }
}
module.exports = functions