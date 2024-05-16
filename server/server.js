const express = require('express');
const http = require('http');
const fs = require('fs');
const path = require('path');
const morgan = require('morgan');
const multer = require('multer');

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



const storage = multer.memoryStorage();
const upload = multer({ storage: storage });

// Handle file upload
app.post('/upload', upload.single('file'), (req, res) => {
    const file = req.file;
    if (!file){
        return res.status(400).send('No file uploaded.');
    }

    const fileSizeInBits = file.buffer.length * 8; // Calculate file size in bits

    // Return the file size in bits as a response
    res.status(200).json({ fileSizeInBits });
});



app.post('/download', (req, res) => {
  let data = null;
  let receivedData = '';

  req.on('data', (chunk) => {
      // Accumulate the chunks of data
      receivedData += chunk.toString(FORMAT);
  });

  req.on('end', () => {
      console.log('Received data:', receivedData);

      // Attempt to parse JSON
      try {
          const jsonData = JSON.parse(receivedData);
          data = jsonData.data;
          console.log('Parsed data:', data);

          // Calculate file size in bits
          const fileSizeInBits = data * 1000000;

          // Create file name based on file size
          const fileName = `${fileSizeInBits}bits_textfile.txt`;
          const filePath = path.join(__dirname, fileName);

          // Check if file already exists
          fs.access(filePath, fs.constants.F_OK, (err) => {
              if (!err) {
                  // File already exists, send it as response
                  console.log('File already exists, sending existing file:', fileName);

                  // Set response headers
                  res.setHeader('Content-Type', 'text/plain');
                  res.setHeader('Content-Disposition', `attachment; filename=${fileName}`);

                  // Send file as response
                  const fileStream = fs.createReadStream(filePath);
                  fileStream.pipe(res);
              } else {
                  // File does not exist, create it and then send as response

                  // Generate text content based on the received data
                  const textContent = generateTextContent(fileSizeInBits);

                  // Write text content to file
                  fs.writeFile(filePath, textContent, (err) => {
                      if (err) {
                          console.error('Error writing file:', err);
                          res.status(500).send('Internal Server Error');
                      } else {
                          console.log('File created:', fileName);

                          // Set response headers
                          res.setHeader('Content-Type', 'text/plain');
                          res.setHeader('Content-Disposition', `attachment; filename=${fileName}`);

                          // Send file as response
                          const fileStream = fs.createReadStream(filePath);
                          fileStream.pipe(res);
                      }
                  });
              }
          });
      } catch (e) {
          console.error('Error parsing JSON:', e);
          res.status(400).send('Bad Request');
      }
  });
});
  

const server = http.createServer(app);

server.listen(PORT, () => {
  console.log(`Server listening on port ${PORT}`);
});
