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
    const { email, password } = req.body;

    try {
        const user = await User.findOne({ email: email });
        if (!user) {
            return res.status(401).send('Usuario no encontrado');
        }

        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) {
            return res.status(401).send('Contraseña incorrecta');
        }

        const token = jwt.sign({ id: user._id }, 'tu_secreto_jwt', { expiresIn: '1h' });

        res.status(200).json({
            message: "Login exitoso",
            token: token
        });
    } catch (error) {
        console.error(error);
        res.status(500).send('Error en el servidor');
    }
};

