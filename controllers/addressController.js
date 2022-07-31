//const { request } = require('express');
const Address = require('../models/address');


module.exports = {

    async findByCity(req, res, next){
        try {
            const id_city = req.params.id_city;
            const data = await Address.findByCity(id_city);
            console.log(`Address ${JSON.stringify(data)}`);
            return res.status(201).json(data);
            
        } catch (error) {
            console.log(`Error ${error}`);
            return res.status(501).json({
                message: 'Hubo un error al tratar de obtener las Direcciones',
                error: error,
                success: false
            })
            
        }


    },

    async getAll(req, res, next){
        try {
            const data = await Address.getAll();
            console.log(`Address ${JSON.stringify(data)}`);
            return res.status(201).json(data);
            
        } catch (error) {
            console.log(`Error ${error}`);
            return res.status(501).json({
                message: 'Hubo un error al tratar de obtener los Edificios',
                error: error,
                success: false
            })
            
        }


    },

    async create(req, res, next){
        
        try {
            const address = req.body;
            console.log(`Address enviado: ${address}`);
            const data = await Address.create(address);
            return res.status(201).json({
                message : 'El Edificio se creo correctamente',
                success : true,
                data : data.id
            })
            
        } catch (error) {
            console.log(`Error: ${error}`);
            return res.status(501).json({
                message: 'Hubo un error al crear el Edificio',
                success: false,
                error: error

            });
        }
    }


}