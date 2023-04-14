const express = require('express');
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
    const expiration = parseInt(req.query.expiration) || 60 * 10; // Default: ten minutes
    const isCache = cache.has(url);

    console.log("Cached? " + (isCache?"Y":"N"))

    if (isCache) {
        const cachedResponse = cache.get(url);
        const now = new Date().getTime();

        if (now > cachedResponse.expiration) {
            console.log("Cache expired. Fetching again.")
            cache.delete(url);
        } else {
            console.log("Returning cache.")
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

app.listen(3000);
