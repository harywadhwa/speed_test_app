const express = require('express');
const http = require('http');
const fs = require('fs');
const path = require('path');
const morgan = require('morgan');

const app = express();
const PORT = 1234;
const FORMAT = "utf-8";

app.use(express.json());
app.use(morgan('combined'));

function generateTextContent(sizeInBits) {
  const charSet = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  const byteSize = sizeInBits / 8; // Convert bits to bytes
  let text = '';
  for (let i = 0; i < byteSize; i++) {
      for (let j = 0; j < 8; j++) { // Generate 8 times more content
          text += charSet.charAt(Math.floor(Math.random() * charSet.length));
      }
  }
  return text;
}

app.post('/upload', (req, res) => {
    req.on('data', (chunk) => {
        chunk.toString(FORMAT);
    });
    res.send('Data received');
});


app.get('/download', (req, res) => {
  const textContent = generateTextContent(100000000);
  const filePath = path.join(__dirname, '100Mb_textfile.txt');

  // Write text content to file
  fs.writeFile(filePath, textContent, (err) => {
      if (err) {
          console.error('Error writing file:', err);
          res.status(500).send('Internal Server Error');
      } else {
          // Set response headers
          res.setHeader('Content-Type', 'text/plain');
          res.setHeader('Content-Disposition', 'attachment; filename=100Mb_textfile.txt');

          // Send file as response
          const fileStream = fs.createReadStream(filePath);
          fileStream.pipe(res);

          // Delete the file after it has been sent to the client
          fileStream.on('close', () => {
              fs.unlink(filePath, (err) => {
                  if (err) {
                      console.error('Error deleting file:', err);
                  }
              });
          });
      }
  });
});

const server = http.createServer(app);

server.listen(PORT, () => {
  console.log(`Server listening on port ${PORT}`);
});
