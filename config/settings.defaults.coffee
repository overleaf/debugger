http = require('http')
http.globalAgent.maxSockets = 300

module.exports =
	internal:
		debugger:
			port: 3030
			host: "localhost"
		
	tests: [
		{ method: "GET", url: "http://localhost:3030/test", interval: 1000, name: "localhost" }
	]
