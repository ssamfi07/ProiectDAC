var User = require('../models/user')
var Pins = require('../models/pin')
var jwt = require('jwt-simple')
var config = require('../config/dbConfig')

var functions = {
    addNewUser: function(req, res) {
        if ((!req.body.username) || (!req.body.password)) {
            res.json({ success: false, message: 'Enter all fields' }) // make the user fill all the fields
        } else {
            User.findOne({ username: req.body.username },
                function(err, user) {
                    if (err) throw err;
                    if (user) { // username already present, don't allow to create new user
                        res.json({ success: false, message: 'Username already present' });
                    } else {
                        var newUser = new User({
                            username: req.body.username,
                            password: req.body.password
                        });
                        newUser.save(function(err, newUser) { // check if user is daved in the db 
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
            username: req.body.username
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
            return res.json({ success: true, message: 'Hello ' + decodedToken.username });
        } else {
            return res.json({ success: false, message: 'No headers' });
        }
    },
    users: function(res) {
        User.forEach({}, function(res, user) {
            res.status(200).send({ username: user.username, password: user.password })
        })
    },
    addPin: function(req, res) {
        if (req.headers.authorization && req.headers.authorization.split(' ')[0] === 'Bearer') {
            var token = req.headers.authorization.split(' ')[1];
            var decodedToken = jwt.decode(token, config.secret, 0);

            if (decodedToken.username != undefined) {
                if ((!req.body.location) || (!req.body.title)) {
                    res.json({ success: false, message: 'Enter all required fields' }) // make the user fill all the fields
                } else {
                    if (!req.body.description) {
                        var newPin = new Pins({
                            username: decodedToken.username,
                            location: req.body.location,
                            title: req.body.title,
                            description: ""
                        });
                    } else {
                        var newPin = new Pins({
                            username: decodedToken.username,
                            location: req.body.location,
                            title: req.body.title,
                            description: req.body.description
                        });
                    }

                    newPin.save(function(err) { // check if pin is saved in the db
                        if (err) {
                            res.json({ success: false, message: 'Failed to save pin' });
                        } else {
                            res.json({ success: true, message: 'Successfully saved pin' });
                        }
                    })
                }
            } else {
                res.json({ success: false, message: 'Failed to read decoded info' });
            }
        } else {
            res.json({ success: false, message: 'Failed to get token' });
        }
    },
    pins: function(req, res) {
        Pins.find({}, function(err, pins) {
            if (err) {
                res.sendStatus(404)
            } else {
                if (pins.length > 0) {
                    res.send({ pins: pins }).status(200)
                } else {
                    res.sendStatus(404)
                }
            }
        });
    }
}
module.exports = functions