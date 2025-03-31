// Imports Express. Not using ES module in package so going with standard
const express = require("express");
// Imports HTTP protocals (Node). Express handles this
// const http = require("http");

const app = express();
// Port is from the environment or defaults to 80
const port = process.env.PORT || 80;
// Only available inside the same machine or container, good for local
// const hostname = '127.17.0.1';

// 0.0.0.0 for listening on all interfaces.
// Kubernetes may break routing otherwise

const hostname = '0.0.0.0';

const mess_n = "My name is fun";
const funFacts = [
    "Kubernetes Had a Secret Codename: Project Seven",
    "Phippy & Friends have a childrens book about Kubernetes",
    "Octopuses have three hearts.",
    "Kubernetes” is the Greek word for a ship’s captain. We get the words Cybernetic and Gubernatorial from it",
    "Why don’t Kubernetes pods ever get lost? Because they always have a service to find them!",
    "Why did the container apply for a job? It wanted better orchestration in its life!",
    "What’s a Kubernetes cluster’s favorite type of music? Bare metal… because it servers nodes!",
    "How does a DevOps engineer like their coffee? With CI/CD (Caffeine Input / Caffeine Deployment)!",
];
// Routing that responds to a HTTP GET request
// Express routing system
app.get("/", (req, res) => {
    const responseObject = {
        message: mess_n,
        // Better version
        // timestamp: new Date().getTime(),
        timestamp: Date.now(),
        // Minified. Removes spaces
        mini: mess_n.replace(/\s+/g, ''),
        request: req.hostname,
        requests: req.method,
        funFact: funFacts[Math.floor(Math.random() * funFacts.length)],
        portUsed: port,
    };
    // Express response helpers
    res.status(200).json(responseObject);
});

// Express  
app.use((req, res) => {
    res.status(404).json({
        error: "Route not found.",
        request: {
            method: req.method,
            url: req.originalUrl,
            path: req.hostname,
            query: req.query,
            headers: req.headers,
            params: req.params,
            body: req.body
        }
    });
});

// Start Server and  list/binding on the Port
// Express createServer()  
app.listen(port, () => {
    console.log(`Example app listening on port ${port}!`);
    console.log(`Server running at http://${hostname}:${port}/`);
});


/*

git checkout Presentation; git add .; git commit -m "Update for presentation"; git push -u origin Presentation
node index.js
# newline
  
git checkout Presentation
git add .
git commit -m "Update for presentation"
git push -u origin Presentation

node index.js 


docker build -t liatrio-app .
docker run -d --name liatrio-test -p 80:80 liatrio-app

# Powershell
docker stop liatrio-test; docker rm liatrio-test

# CMD
docker stop liatrio-test && docker rm liatrio-test

*/