karma = require('gulp-karma')
open         = require("gulp-open")

module.exports = (gulp, log, concat, size, minify, rename, coffee, gulpif,
myClean, bang = '!!!!!!!!!!') ->
  log "#{bang}Karma Setup#{bang}"
  ###
  this file should be called by gulpfile.coffee
  with gulp and plugins already loaded
  ###
  runner = "karma"
  runnerBuild = runner + "_build"
  dependencies = []

  log "#{bang} BEGIN: Karma Tasks#{bang}"
  dependencyTasks = {}
  dependencies.forEach (t) ->
    dependencyTasks[t] = t + "_build"
    log dependencyTasks[t]

  log "#{bang} END: Karma Tasks: #{dependencyTasks}#{bang}"

  spec: runner
  dependencies: dependencies
  dependencyTasks: dependencyTasks

  runner: () ->
    karma
      configFile: 'karma.conf.coffee'
      action: 'run'
