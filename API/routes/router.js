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
router.post('/adduser', actions.addNewUser)

// @desc Authenticating a user
// @route POST /login
router.post('/login', actions.login)

// @desc get user information
// @route GET /getInfo
router.get('/getInfo', actions.getInfo)

// @desc Show all users -- dev purpose only
// @route GET /users
router.get('/users', actions.users)

module.exports = router