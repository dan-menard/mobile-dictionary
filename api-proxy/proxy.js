const http = require('http');
const fs = require('fs');

const hostname = '127.0.0.1';
const port = 3000;

function startServer(html) {
  const server = http.createServer((req, res) => {
    res.statusCode = 200;
    res.setHeader('Content-Type', 'text/html');

    if (html) {
      res.write(html);
    }

    res.end();
  });

  server.listen(port, hostname, () => {
    console.log(`Server running at http://${hostname}:${port}/`);
  });
}

fs.readFile('api-proxy/proxy-ui.html', (err, html) => {
  if (err) {
    console.log('ooh! Something went wrong loading the HTML. Starting with no UI.');
    console.log(err);

    startServer();
  } else {
    startServer(html);
  }
});
