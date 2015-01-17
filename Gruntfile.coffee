spawn = require("child_process").spawn

module.exports = (grunt) ->
	grunt.initConfig
		coffee:
			app:
				src: "app.coffee"
				dest: "app.js"

		execute:
			app:
				src: "app.js"

	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-execute'
	grunt.loadNpmTasks 'grunt-bunyan'

	grunt.registerTask 'run',         ['coffee:app', 'bunyan', 'execute']

	grunt.registerTask 'default', ['run']


