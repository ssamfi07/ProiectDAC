var User = require('../models/user')
var jwt = require('jwt-simple')
var config = require('../config/dbConfig')

var functions = {
    addNewUser: function(req, res) {
        if ((!req.body.name) || (!req.body.password)) {
            res.json({ success: false, message: 'Enter all fields' })
        } else {
            var newUser = new User({
                name: req.body.name,
                password: req.body.password
            });
            newUser.save(function(err, newUser) {
                if (err) {
                    res.json({ success: false, message: 'Failed to save' });
                } else {
                    res.json({ success: true, message: 'Successfully saved' });
                }
            })
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
    users: function(res) {
        User.forEach({}, function(res, user) {
            res.status(200).send({ username: user.username, password: user.password })
        })
    }
}
module.exports = functions