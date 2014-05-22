jasminePhantomJs = require('gulp-jasmine2-phantomjs')

module.exports = (gulp, log, concat, size, minify, rename,myClean, bang = '!!!!!!!!!!') ->
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
    "boot"
    "jasmine"
    "jasmine-html"
  ]
  bowerJasmineFiles = jasmineFiles.map (v) ->
    v = "bower_components/#{jasmine}/lib/jasmine-core/#{v}".js()
    log v
    v

  log "#{bang} BEGIN: TASK: #{dependencyTasks[jasmine]}#{bang}"
  gulp.task dependencyTasks[jasmine], ->
    log "#{bang}Loading #{dependencyTasks[jasmine]}#{bang}"
    #clean up old jasmine files in dist
    jasmineFiles.forEach (f) ->
      myClean("dist/#{f.js()}")
    #copy jasmine dependencies to dist
    gulp.src(bowerJasmineFiles)
    .pipe(size())
    .pipe(gulp.dest("dist"))

  gulp.task dependencyTasks[jasmine2JUnit], ->
    log "#{bang}Loading #{dependencyTasks[jasmine2JUnit]}#{bang}"
    myClean("dist/#{jasmine2JUnit.js()}")
    gulp.src("bower_components/#{jasmine2JUnit}/#{jasmine2JUnit.js()}")
    .pipe(size())
    .pipe(gulp.dest("dist"))

  spec: jasmine
  dependencies: dependencies
  dependencyTasks: dependencyTasks
  runner: jasminePhantomJs
