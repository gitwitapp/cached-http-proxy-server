#!/bin/sh

# Initialize git repo
git init
echo -e "node_modules/" > .gitignore
echo -e ".DS_Store" >> .gitignore
echo -e "package-lock.json" >> .gitignore
echo -e "README.md" >> .gitignore
git add .gitignore
git commit -a -m "👷🏼 Add .gitignore"

# Create package.json
echo -e "{}" > package.json
git add package.json
git commit -a -m "👷🏼 Add package.json"

# Initialize NodeJS project
npm init -y
git add .
git commit -a -m "👷🏼 Initialize NodeJS project"

# Install dependencies
npm install --save express axios morgan express-rate-limit
git add package.json package-lock.json
git commit -a -m "👷🏼 Install dependencies"

# Create server.js file
echo -e "const express = require('express');" >> server.js
echo -e "const axios = require('axios');" >> server.js
echo -e "const morgan = require('morgan');" >> server.js
echo -e "const rateLimit = require('express-rate-limit');" >> server.js
echo -e "const app = express();" >> server.js
echo -e "" >> server.js
echo -e "const cache = new Map();" >> server.js
echo -e "" >> server.js
echo -e "app.use(morgan('tiny'));" >> server.js
echo -e "" >> server.js
echo -e "const limiter = rateLimit({" >> server.js
echo -e "    windowMs: 60 * 1000," >> server.js
echo -e "    max: 10," >> server.js
echo -e "    message: 'Too many requests, please try again later.'" >> server.js
echo -e "});" >> server.js
echo -e "app.use(limiter);" >> server.js
echo -e "" >> server.js
echo -e "app.get('/cache', async (req, res) => {" >> server.js
echo -e "    const url = req.query.url;" >> server.js
echo -e "    const expiration = parseInt(req.query.expiration);" >> server.js
echo -e "    const isCache = cache.has(url);" >> server.js
echo -e "" >> server.js
echo -e "    if (isCache) {" >> server.js
echo -e "        const cachedResponse = cache.get(url);" >> server.js
echo -e "        const now = new Date().getTime();" >> server.js
echo -e "" >> server.js
echo -e "        if (now > cachedResponse.expiration) {" >> server.js
echo -e "            cache.delete(url);" >> server.js
echo -e "        } else {" >> server.js
echo -e "            return res.status(cachedResponse.status).send(cachedResponse.data);" >> server.js
echo -e "        }" >> server.js
echo -e "    }" >> server.js
echo -e "" >> server.js
echo -e "    try {" >> server.js
echo -e "        const response = await axios.get(url);" >> server.js
echo -e "        cache.set(url, {" >> server.js
echo -e "            status: response.status," >> server.js
echo -e "            expiration: new Date().getTime() + expiration * 1000," >> server.js
echo -e "            data: response.data" >> server.js
echo -e "        });" >> server.js
echo -e "" >> server.js
echo -e "        return res.status(response.status).send(response.data);" >> server.js
echo -e "    } catch (error) {" >> server.js
echo -e "        console.error(error);" >> server.js
echo -e "        return res.status(500).send('Error fetching data.');" >> server.js
echo -e "    }" >> server.js
echo -e "});" >> server.js
echo -e "" >> server.js
git add server.js
git commit -a -m "👷🏼 Add server.js"

# Create README.md
echo -e "# NodeJS API that takes two inputs" > README.md
echo -e "" >> README.md
echo -e "This server can be used as an intermediary to cache HTTP responses from a given URL. It listens on port 3000 by default, but that can be changed by setting the PORT environment variable." >> README.md
echo -e "" >> README.md
echo -e "## How to use" >> README.md
echo -e "" >> README.md
echo -e "To start the server, run `npm start`" >> README.md
echo -e "" >> README.md
echo -e "To request a cached or non-cached response, send a GET request to `http://localhost:3000/cache?url=YOUR_URL&expiration=SECONDS_TO_EXPIRE`" >> README.md
echo -e "" >> README.md
echo -e "- `url` (required): The URL of the resource to fetch." >> README.md
echo -e "- `expiration` (required): The number of seconds to keep the cached response." >> README.md
echo -e "" >> README.md
git add README.md
git commit -a -m "👷🏼 Add README.md"