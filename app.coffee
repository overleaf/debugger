Settings = require "settings-sharelatex"
logger = require "logger-sharelatex"
logger.initialize("debugger")

Metrics = require "metrics-sharelatex"
Metrics.initialize("debugger")

request = require "request"

express = require("express")
app = express()

app.all "/test", (req, res, next) ->
    logger.log "/test called"
    res.status(200).end()

app.get "/status", (req, res, next) ->
    res.send("debugger is alive")
    
port = Settings.internal?.debugger?.port
host = Settings.internal?.debugger?.host
app.listen port, host, (error) ->
    throw error if error?
    logger.log "debugger listening on #{host}:#{port}"
    
testEndpoint = (options, callback = (error) ->) ->
    timer = new Metrics.Timer(options.name)
    logger.log {options}, "calling endpoint"
    request options, (error, response, body) ->
        return callback(error) if error?
        timer.done()
        logger.log {options, response_time: new Date() - timer.start}, "endpoint returned"
        callback()

for test in Settings.tests
    do (test) ->
        setInterval () ->
            testEndpoint test, (error) ->
                if error?
                    logger.err err: error, "endpoint error"
        , test.interval
