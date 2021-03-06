var User = require('../models/user')
var Pins = require('../models/pin')
var jwt = require('jwt-simple')
var config = require('../config/dbConfig')

function isValidEmail(email) {
    var emailRegex = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
    return !!email && typeof email === 'string' &&
        email.match(emailRegex)
};

var functions = {
    addNewUser: function(req, res) {
        if ((!req.body.username) || (!req.body.password)) {
            res.status(400).json({ success: false, message: 'Enter all fields' }) // make the user fill all the fields
        } else {
            User.findOne({ username: req.body.username },
                function(err, user) {
                    if (err) throw err;
                    if (user) { // username already present, don't allow to create new user
                        res.status(400).json({ success: false, message: 'Username already present' });
                    } else if (isValidEmail(req.body.email)) {
                        var newUser = new User({
                            name: req.body.name,
                            username: req.body.username,
                            email: req.body.email,
                            password: req.body.password
                        });
                        newUser.save(function(err, newUser) { // check if user is daved in the db 
                            if (err) {
                                res.status(400).json({ success: false, message: 'Failed to save' });
                            } else {
                                res.status(200).json({ success: true, message: 'Successfully saved', user: newUser });
                            }
                        })
                    } else {
                        res.status(400).json({ success: false, message: 'Email invalid' });
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
                user.comparePassword(req.body.password, async function(err, isMatch) {
                    if (isMatch && !err) // send token
                    {
                        var jwtToken = await jwt.encode(user, config.secret);
                        res.status(200).send(jwtToken);
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
    addPin: async function(req, res) {
        if (req.headers.authorization && req.headers.authorization.split(' ')[0] === 'Bearer') {
            var token = req.headers.authorization.split(' ')[1];
            var decodedToken = await jwt.decode(token, config.secret, 0);

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

                    await newPin.save(function(err) { // check if pin is saved in the db
                        if (err) {
                            res.json({ success: false, message: 'Failed to save pin' });
                        } else {
                            res.json({ success: true, message: 'Successfully saved pin', pin: newPin });
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
    },
    pinsFromUser: async function(req, res) {
        if (req.headers.authorization && req.headers.authorization.split(' ')[0] === 'Bearer') {
            var token = req.headers.authorization.split(' ')[1];
            var decodedToken = await jwt.decode(token, config.secret, 0);

            if (decodedToken.username != undefined) {
                Pins.find({ username: decodedToken.username }, function(err, pins) {
                    if (err) {
                        res.sendStatus(400);
                    } else if (pins.length > 0) {
                        res.send({ pins: pins }).status(200);
                    } else {
                        res.sendStatus(404);
                    }
                })
            } else {
                res.json({ success: false, message: 'Failed to read decoded info' });
            }
        } else {
            res.json({ success: false, message: 'Failed to get token' });
        }
    },
    pinsFromTitle: function(req, res) {
        Pins.find({ title: req.body.title }, function(err, pins) {
            if (err) {
                res.sendStatus(400);
            } else if (pins.length > 0) {
                res.send({ pins: pins }).status(200);
            } else {
                res.sendStatus(404);
            }
        })
    }
}
module.exports = functions