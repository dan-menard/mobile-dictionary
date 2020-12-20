const fs = require('fs');
const http = require('http');
const https = require('https');
const url = require('url');

const hostname = '127.0.0.1';
const proxyPort = 3001;

const API_URL = 'https://www.dictionaryapi.com/api/v3/references/collegiate/json';

function startProxyServer(apiKey) {
  const server = http.createServer((req, res) => {
    const jsonPayload = JSON.stringify({hello: 'world'});

    const search = url.parse(req.url, true).search;
    const word = search.substring(1).split('=')[1];

    https.get(`${API_URL}/${word}?key=${apiKey}`, (response) => {
      let data = '';

      response.on('data', (chunk) => {
        data += chunk;
      });

      response.on('end', () => {
        parsed = JSON.parse(data);
        console.log('Search result:');
        console.log(parsed);

        res.statusCode = 200;
        res.setHeader('Content-Type', 'application/json');
        res.end(data);
      });
    }).on('error', (err) => {
      console.log('Error during fetch:');
      console.log(err);

      res.statusCode = 500;
      res.end;
    });;
  });

  server.listen(proxyPort, hostname, () => {
    console.log(`Proxy running at http://${hostname}:${proxyPort}/`);
  });
}

fs.readFile('secret/mw_api_key.txt', (err, txt) => {
  if (err) {
    console.log('Something went wrong loading the API key:');
    console.log(err);
  } else {
    startProxyServer(txt);
  }
});
