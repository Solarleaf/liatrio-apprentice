const http = require("http");

const hostname = "127.0.0.1";
const port = 8000;

const server = http.createServer(function (req,
    res) {
    res.writeHead(200, {
        "Content-Type": "text/plain"
    });

    res.end("Hello null\n");
});

server.listen(port, hostname, function () {
    // Note that ` is used, not '
    console.log(`Server running at http://${hostname}:${port}/`);
});