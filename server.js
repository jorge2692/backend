const express =require('express');
const app = express();
const http = require('http');
const server = http.createServer(app);
const logger = require('morgan');
const cors = require('cors');
const exp = require('constants');
const multer = require('multer');
const admin = require('firebase-admin');
const serviceAccount = require('./serviceAccountKey.json');
const passport = require('passport');

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
})

const upload = multer({
    storage: multer.memoryStorage()
})

/*
*Rutas
*/

const users = require('./routes/usersRoutes');
const categories = require('./routes/categoriesRoutes');
const machines = require('./routes/machinesRoutes');
const address = require('./routes/addressRoutes');
const cities = require('./routes/citiesRoutes');
const esp8266 = require('./routes/esp8266Routes');



const port = process.env.PORT || 3000;

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({
    extended: true
}));
app.use(cors());
app.use(passport.initialize());
app.use(passport.session());
require('./config/passport')(passport);

app.disable('x-powered-by');


app.set('port', port);

/*
*Llamando Rutas
*/

users(app, upload);
categories(app);
machines(app, upload);
address(app);
cities (app);
esp8266 (app);


// server.listen(3000,'192.168.39.130' || 'localhost', function(){
//     console.log('Aplicacion de  NodeJS ' + port + ' Iniciado...')
// });
server.listen(process.env.PORT || '192.168.39.191', function(){
    const port = server.address().port;
    console.log(process.env.PORT)
    console.log(port)
    console.log('Aplicacion de  NodeJS ' + port + ' Iniciado...')
});


// ERROR HANDLER
app.use((err, req, res, next) => {
    console.log(err);
    res.status(err.status || 500).send(err.stack);
});

module.exports = {
    app: app,
    server: server
}

//"hello"