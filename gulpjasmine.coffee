jasminePhantomJs = require('gulp-jasmine2-phantomjs')
open         = require("gulp-open")

module.exports = (gulp, log, concat, size, minify, rename, coffee, gulpif,
myClean, bang = '!!!!!!!!!!') ->
  log "#{bang}Jasmine Setup#{bang}"
  ###
  this file should be called by gulpfile.coffee
  with gulp and plugins already loaded
  ###
  jasmine = "jasmine"
  jasmineBuild = "jasmine" + "_build"
  jasmine2JUnit= "jasmine2-junit"
  dependencies = [jasmine,jasmine2JUnit]

  log "#{bang} BEGIN: Jasmine Tasks#{bang}"
  dependencyTasks = {}
  dependencies.forEach (t) ->
    dependencyTasks[t] = t + "_build"
    log dependencyTasks[t]

  log "#{bang} END: Jasmine Tasks: #{dependencyTasks}#{bang}"

  jasmineFiles = [
    "jasmine"
    "jasmine-html"
  ]
  bowerJasmineFiles = jasmineFiles.map (v) ->
    v = "bower_components/#{jasmine}/lib/jasmine-core/#{v}".js()
    log v
    v
  bowerJasmineFiles.push "bower_components/#{jasmine}/lib/jasmine-core/jasmine.css"
  bowerJasmineFiles.push "bower_components/#{jasmine2JUnit}/boot.js"
  bowerJasmineFiles.push "bower_components/#{jasmine}/lib/console/console.js"
  #support fixtures
  bowerJasmineFiles.push "bower_components/jasmine-jquery/lib/jasmine-jquery.js"
  bowerJasmineFiles.push "lib/jasmine*"

  log "#{bang} BEGIN: TASK: #{dependencyTasks[jasmine]}#{bang}"
  gulp.task dependencyTasks[jasmine], ->
    log "#{bang}Loading #{dependencyTasks[jasmine]}#{bang}"
    #clean up old jasmine files in dist
    jasmineFiles.forEach (f) ->
      myClean("dist/#{f.js()}")
    #copy jasmine dependencies to dist
    gulp.src(bowerJasmineFiles)
    .pipe(gulpif(/[.]coffee$/, coffee().on('error',log)))
    .pipe(size())
    .pipe(gulp.dest("dist"))

  gulp.task dependencyTasks[jasmine2JUnit], ->
    log "#{bang}Loading #{dependencyTasks[jasmine2JUnit]}#{bang}"
    myClean("dist/#{jasmine2JUnit.js()}")
    gulp.src("bower_components/#{jasmine2JUnit}/#{jasmine2JUnit.js()}")
    .pipe(size())
    .pipe(gulp.dest("dist"))

  gulp.task "jasmine", ["serve-build"],->
    options =
      url: "http://localhost:3000/jasmine.html"
      app: "Google Chrome" #osx , linux: google-chrome, windows: chrome
    gulp.src("dist/spec_runner.html")
    .pipe(rename("jasmine.html"))
    .pipe(gulp.dest("dist"))
    .pipe(open("", options))

  spec: jasmine
  dependencies: dependencies
  dependencyTasks: dependencyTasks
  runner: jasminePhantomJs
