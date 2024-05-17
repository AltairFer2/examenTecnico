const User = require('../models/User');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

// Registrar usuario
exports.register = async (req, res) => {
    const { name, email, rfc, password } = req.body;
    try {
        let user = await User.findOne({ email });
        if (user) {
            return res.status(400).json({ msg: 'El usuario ya existe' });
        }

        user = new User({
            name,
            email,
            rfc,
            password
        });

        const salt = await bcrypt.genSalt(10);
        user.password = await bcrypt.hash(password, salt);

        await user.save();
        const payload = {
            user: {
                id: user.id
            }
        };

        jwt.sign(payload, process.env.JWT_SECRET, { expiresIn: 360000 }, (err, token) => {
            if (err) throw err;
            res.json({ token });
        });

    } catch (err) {
        console.error(err.message);
        res.status(500).send('Error de Server');
    }
};

// Iniciar sesión
exports.login = async (req, res) => {
    const { email, password } = req.body;
    try {
        let user = await User.findOne({ email });
        if (!user) {
            return res.status(400).json({ msg: 'Credenciales Inválidas' });
        }

        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) {
            return res.status(400).json({ msg: 'Credenciales Inválidas' });
        }

        const payload = {
            user: {
                id: user.id
            }
        };

        jwt.sign(payload, process.env.JWT_SECRET, { expiresIn: 360000 }, (err, token) => {
            if (err) throw err;
            res.json({ token });
        });

    } catch (err) {
        console.error(err.message);
        res.status(500).send('Error de Server');
    }
};

// Obtener perfil de usuario
exports.getUserProfile = async (req, res) => {
    try {
        const user = await User.findById(req.user.id).select('-password');
        res.json(user);
    } catch (err) {
        console.error(err.message);
        res.status(500).send('Error de Server');
    }
};

// Actualizar perfil de usuario
exports.updateUserProfile = async (req, res) => {
    const { name, email } = req.body;
    const updatedFields = { name, email };

    try {
        const user = await User.findByIdAndUpdate(req.user.id, { $set: updatedFields }, { new: true });
        res.json(user);
    } catch (err) {
        console.error(err.message);
        res.status(500).send('Error de Server');
    }
};

// Eliminar usuario
exports.deleteUser = async (req, res) => {
    try {
        await User.findByIdAndRemove(req.params.id);
        res.json({ msg: 'Usuario eliminado' });
    } catch (err) {
        console.error(err.message);
        res.status(500).send('Error de Server');
    }
};
