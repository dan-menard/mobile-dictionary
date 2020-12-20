const http = require('http');
const fs = require('fs');

const hostname = '127.0.0.1';
const proxyPort = 3001;
const uiPort = 3000;

function startProxyServer() {
  const jsonPayload = JSON.stringify({hello: 'world'});

  const server = http.createServer((req, res) => {
    res.statusCode = 200;
    res.setHeader('Content-Type', 'application/json');
    res.end(jsonPayload);
  });

  server.listen(proxyPort, hostname, () => {
    console.log(`Proxy running at http://${hostname}:${proxyPort}/`);
  });
}

function startUiServer(html) {
  const server = http.createServer((req, res) => {
    res.statusCode = 200;
    res.setHeader('Content-Type', 'text/html');
    res.write(html);
    res.end();
  });

  server.listen(uiPort, hostname, () => {
    console.log(`UI running at http://${hostname}:${uiPort}/`);
  });
}

fs.readFile('api-proxy/proxy-ui.html', (err, html) => {
  if (err) {
    console.log('ooh! Something went wrong loading the HTMLL:');
    console.log(err);
  } else {
    startUiServer(html);
  }
});

startProxyServer();
