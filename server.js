const express = require('express');
const path = require('path');
const fs = require('fs');

const app = express();

// Serve o arquivo index.html quando acessar /index.html
app.get('/index.html', (req, res) => {
    res.sendFile(path.join(__dirname, 'index.html'));
});

// Serve arquivos .txt (neste caso, p1.txt)
app.get('/index.html/:file', (req, res) => {
    const fileName = req.params.file;
    const filePath = path.join(__dirname, 'c', fileName);
    
    // Verifica se o arquivo existe e é .txt
    if (fs.existsSync(filePath) && path.extname(filePath) === '.txt') {
        res.sendFile(filePath);
    } else {
        res.status(404).send('File not found');
    }
});

// Inicia o servidor
app.listen(3000, () => {
    console.log('Server is running on http://localhost:3000');
});
