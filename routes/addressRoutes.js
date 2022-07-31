const AddressController = require('../controllers/addressController');
const passport = require('passport');
const Address = require('../models/address');

module.exports = (app) => {

    app.get('/api/address/getAll', passport.authenticate('jwt', {session: false}), AddressController.getAll);

    //app.get('/api/address/findByCity/:id_city', passport.authenticate('jwt', {session: false}), AddressController.findByCity);

    app.get('/api/address/findByCity/:id_city',  AddressController.findByCity);



    app.post('/api/address/create', passport.authenticate('jwt', {session: false}), AddressController.create);

}