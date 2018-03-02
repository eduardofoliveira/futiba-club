const bodyParser = require('body-parser')
const session = require('express-session')
const mysql = require('mysql2/promise')
const express = require('express')
const app = express()

const account = require('./account')
const admin = require('./admin')
const groups = require('./groups')

app.use(express.static('public'))
app.use(bodyParser.urlencoded({extended: true}))
app.use(session({
    secret: 'fullstack-academy',
    resave: true,
    saveUninitialized: true
}))
app.set('view engine', 'ejs')

const init = async() => {
    const connection = await mysql.createConnection({
        host: 'duduhouse.dyndns.info',
        user: 'futiba',
        password: '190790edu',
        database: 'futiba_club'
    })

    app.use((req, res, next) => {
        if(req.session.user){
            res.locals.user = req.session.user
        }else{
            res.locals.user = false
        }
        next()
    })
    
    app.use(account(connection))
    app.use('/admin', admin(connection))
    app.use('/groups', groups(connection))
    

    app.listen(3000, err => {
        if(err) console.log(err)
        console.log('Futiba Club server is running...')
    })
}
init()

// Fullstack Academy - Aula3 - 56:54