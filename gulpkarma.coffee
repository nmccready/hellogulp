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
      noOverrideFiles: true


  ###
  NOTICE:
  noOverrideFiles -

  #see issue https://github.com/lazd/gulp-karma/pull/18, why I forked to nmccready
  otherwise you will need the src below in gulpspec.coffee , spec task
  # gulp.src([
  #   'dist/vendor_develop.js'
  #   'dist/templates.js'
  #   'dist/fixtures/*.html'
  #   'dist/fixtures/json/*.json'
  #   'dist/all.js'
  #   "app/spec/karma_init.js"
  #   # 'dist/jasmine.js'
  #   # 'dist/jasmine-html.js'
  #   # 'dist/jasmine2-junit.js'
  #   # 'dist/boot.js'
  #   # 'dist/console.js'
  #   # 'dist/*.js'
  #
  #   'dist/spec.js'
  #   'dist/**/*.html'
  #   ])

  ###
