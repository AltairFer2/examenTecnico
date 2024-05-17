const express = require('express');
const multer = require('multer');
const router = express.Router();

const fileController = require('../controllers/fileController');

const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, 'uploads/');
    },
    filename: function (req, file, cb) {
        const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
        cb(null, file.fieldname + '-' + uniqueSuffix + path.extname(file.originalname));
    }
});

const upload = multer({ storage: storage });

router.post('/upload', upload.single('file'), fileController.saveFileRecord);

router.get('/files', fileController.getFiles);

module.exports = router;
