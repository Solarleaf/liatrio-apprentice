const express = require("express");
const app = express();
const port = 80;

app.get("/", (req, res) => {
    const responseObject = {
        message: "My name is Leif Hasle",
        timestamp: new Date()
    };
    res.json(responseObject);
});

app.listen(port, () => {
    console.log(`Example app listening on port ${port}!`);
    // console.log(`Server running at http://${hostname}:${port}/`);
});