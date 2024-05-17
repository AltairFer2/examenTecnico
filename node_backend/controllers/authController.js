const User = require('../models/User');

exports.register = async (req, res) => {
    const { name, email, rfc, password } = req.body;
    try {
        const newUser = new User({ name, email, rfc, password });
        await newUser.save();
        res.status(201).send('User registered');
    } catch (error) {
        res.status(500).send(error);
    }
};

exports.login = async (req, res) => {
    // Implementación del login
};
