// Imports Express 
const express = require("express");
// Imports HTTP protocals
const http = require("http");
const app = express();
// Port and IP
const port = process.env.PORT || 80;
// const hostname = '127.17.0.1';
const hostname = '0.0.0.0';
const mess_n = "My name is fun!";
// Routing that responds to a HTTP GET request
app.get("/", (req, res) => {
    const responseObject = {
        message: mess_n,
        timestamp: new Date().getTime(),
        // Minified
        mini: mess_n.replace(/\s+/g, ''),
    };
    res.status(200).json(responseObject);
});
// Start Server and binding the Port
app.listen(port, () => {
    console.log(`Example app listening on port ${port}!`);
    console.log(`Server running at http://${hostname}:${port}/`);
});