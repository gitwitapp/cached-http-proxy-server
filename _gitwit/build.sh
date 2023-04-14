#!/bin/sh

# Add README.md
echo -e -e "# NodeJS API that takes two inputs" > README.md
echo -e -e "" >> README.md
echo -e -e "This server can be used as an intermediary to cache HTTP responses from a given URL. It listens on port 3000 by default, but that can be changed by setting the PORT environment variable." >> README.md
echo -e -e "" >> README.md
echo -e -e "## How to use" >> README.md
echo -e -e "" >> README.md
echo -e -e "To start the server, run `npm start`" >> README.md
echo -e -e "" >> README.md
echo -e -e "To request a cached or non-cached response, send a GET request to `http://localhost:3000/cache?url=YOUR_URL&expiration=SECONDS_TO_EXPIRE`" >> README.md >> README.md
echo -e -e "" >> README.md
git add README.md
git commit -a -m "👷🏼 Add README.md"

# Install dependencies
npm install axios express express-rate-limit morgan
git add package.json
git commit -a -m "👷🏼 Install dependencies"

# Initialize NodeJS project
npm init -y
git add package.json
git commit -a -m "👷🏼 Initialize NodeJS project"

# Add server.js
echo -e -e "const express = require('express');
const axios = require('axios');
const morgan = require('morgan');
const rateLimit = require('express-rate-limit');
const app = express();

const cache = new Map();

app.use(morgan('tiny'));

const limiter = rateLimit({
    windowMs: 60 * 1000,
    max: 10,
    message: 'Too many requests, please try again later.'
});
app.use(limiter);

app.get('/cache', async (req, res) => {
    const url = req.query.url;
    const expiration = parseInt(req.query.expiration);
    const isCache = cache.has(url);

    if (isCache) {
        const cachedResponse = cache.get(url);
        const now = new Date().getTime();

        if (now > cachedResponse.expiration) {
            cache.delete(url);
        } else {
            return res.status(cachedResponse.status).send(cachedResponse.data);
        }
    }

    try {
        const response = await axios.get(url);
        cache.set(url, {
            status: response.status,
            expiration: new Date().getTime() + expiration * 1000,
            data: response.data
        });

        return res.status(response.status).send(response.data);
    } catch (error) {
        console.error(error);
        return res.status(500).send('Error fetching data.');
    }
});
" > server.js
git add server.js
git commit -a -m "👷🏼 Add server.js"

# Add .gitignore
echo -e -e "node_modules/
.DS_Store
package-lock.json
README.md" > .gitignore
git add .gitignore
git commit -a -m "👷🏼 Add .gitignore"

# Add info.json
echo -e -e '{
    "repositoryName": "nodejs-api-that-takes-two-inputs",
    "description": "A NodeJS API that takes two inputs: A web URL, and an expiration period. Upon receiving a request, it checks for a cached HTTP response from that URL. If available and within the expiration period, it returns the response. Otherwise, it fetches the response and stores it in the cache.",
    "generator": "GitWit",
    "generatorVersion": "0.0.6",
    "gptModel": "gpt-3.5-turbo-0301",
    "completionId": "chatcmpl-75E3PZGbKZD861C4x8vGLF23X1VXE",
    "repositoryURL": "https://github.com/gitwitapp/nodejs-api-that-takes-two-inputs.git",
    "dateCreated": "2023-04-14T13:47:50.953Z"
}' > _gitwit/info.json
git add _gitwit/info.json
git commit -a -m "👷🏼 Add info.json"