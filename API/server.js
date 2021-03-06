const express = require('express')
const morgan = require('morgan')
const cors = require('cors')
const connectDB = require('./config/db.js')
const passport = require('passport')
const bodyParser = require('body-parser')
const routes = require('./routes/router')

// once server starts the connection to MongoDB is trying to be established
connectDB()

const app = express()

if (process.env.NODE_ENV === 'development') {
    app.use(morgan('dev'))
}

app.use(cors())
app.use(bodyParser.urlencoded({ extended: false }))
app.use(bodyParser.json())
app.use(routes)
app.use(passport.initialize())
require('./config/passport')(passport)

const PORT = process.env.PORT || 3000

app.listen(PORT, console.log(`Server running on ${process.env.NODE_ENV} mode on port ${PORT}`))