const express = require('express')
const actions = require('../methods/actions')
const router = express.Router()

router.get('/', (req, res) => {
    res.send('Hello World')
})

router.get('/dashboard', (req, res) => {
    res.send('Dashboard')
})

// @desc Adding a new user
// @route POST /adduser
router.post('/register', actions.addNewUser)

// @desc Authenticating a user
// @route POST /login
router.post('/login', actions.login)

// @desc get user information
// @route GET /getInfo
router.get('/getInfo', actions.getInfo)

// @desc Show all users -- dev purpose only
// @route GET /users
router.get('/users', actions.users)

// @desc post new pin
// @route POST /newPin
router.post('/newPin', actions.addPin)

// @desc get all pins -- for map
// @route GET /pins
router.get('/pins', actions.pins)

// @desc get pins from logged in user -- for messages
// @route GET /pinsFromUser
router.get('/pinsFromUser', actions.pinsFromUser)

// @desc get pins from title -- for search purposes
// @route GET /pinsFromTitle
router.get('/pinsFromTitle', actions.pinsFromTitle)

module.exports = router