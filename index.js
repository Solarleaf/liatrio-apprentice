
const express = require("express");
const http = require("http");

const app = express();

const port = 80;
const hostname = '127.17.0.1';
const mess_n = "My name is Leif Hasle";

app.get("/", (req, res) => {
    const responseObject = {
        message: mess_n,
        timestamp: new Date().getTime(),
        data: mess_n.replace(/\s+/g, ''),
        // timestamp: System.currentTimeMillis() / 1000,
    };
    res.status(200).json(responseObject);
});
/*
app.listen(port, hostname, () => {
    console.log(`Example app listening on port ${port}!`);
    // console.log(`Server running at http://${hostname}:${port}/`);
});
*/
app.listen(port, () => {
    console.log(`Example app listening on port ${port}!`);
    // console.log(`Server running at http://${hostname}:${port}/`);
});
