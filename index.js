// Imports Express 
const express = require("express");
// Imports HTTP protocals
const http = require("http");
const app = express();
// Port and IP
const port = process.env.PORT || 80;
// const hostname = '127.17.0.1';
const hostname = '0.0.0.0';
const mess_n = "Life is fun!";
const funFacts = [
    "Kubernetes Had a Secret Codename: Project Seven",
    "Phippy & Friends have a childrens book about Kubernetes",
    "Octopuses have three hearts.",
    "Kubernetes” is the Greek word for a ship’s captain. We get the words Cybernetic and Gubernatorial from it",
    "Why don’t Kubernetes pods ever get lost? Because they always have a service to find them!",
    "Why did the container apply for a job? It wanted better orchestration in its life!",
    "What’s a Kubernetes cluster’s favorite type of music? Heavy metal… because it’s full of nodes!",
    "How does a DevOps engineer like their coffee? With CI/CD (Caffeine Input / Caffeine Deployment)!",
];
// Routing that responds to a HTTP GET request
app.get("/", (req, res) => {
    const responseObject = {
        message: mess_n,
        timestamp: new Date().getTime(),
        // Minified
        mini: mess_n.replace(/\s+/g, ''),
        funFact: funFacts[Math.floor(Math.random() * funFacts.length)],
    };
    res.status(200).json(responseObject);
});
// Start Server and binding the Port
app.listen(port, () => {
    console.log(`Example app listening on port ${port}!`);
    console.log(`Server running at http://${hostname}:${port}/`);
});