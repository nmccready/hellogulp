_ = require('./node_modules/underscore/underscore-min')
istanbul = require('gulp-istanbul')
debug = require('gulp-debug')

module.exports = (srcFileNames, gulp, log, concat, size, minify, rename, jshint, coffee,
  coffeelint, gulpif, specRunner, myClean, appendName = undefined, bang = '!!!!!!') ->

  bang = "!!!!#{specRunner.spec}!!!!"

  dependencyTasks = _.values(specRunner.dependencyTasks)
  runner = specRunner.runner

  log "#{bang}Spec Task Setup#{bang}"
  ###
  this file should be called by gulpfile.coffee
  with gulp and plugins already loaded
  ###

  buildOurSpecs = if appendName then "spec_build_#{appendName}" else "spec_build"
  runSpecs = if appendName then "spec_#{appendName}" else "spec"
  coverSpecs = if appendName then "spec_cover_#{appendName}" else "spec_cover"

  gulp.task buildOurSpecs, ->
    myClean("src/spec.js",true)
    gulp.src(["app/spec/spec_helpers/*","app/spec/scripts/**/*"])
    .pipe(gulpif(/[.]js$/,jshint()))
    .pipe(gulpif(/[.]js$/,jshint.reporter("default")))
    .pipe(gulpif(/[.]coffee$/, coffeelint()))
    .pipe(gulpif(/[.]coffee$/, coffeelint.reporter()))
    .pipe(gulpif(/[.]coffee$/, coffee().on('error', log)))
    .pipe(concat("spec.js"))
    .pipe(size( title:'spec.js'))
    .pipe(gulp.dest("dist"))

    #copy spec fixtures to dist so Chrome and PhantomJS work
    # if this is left to just open / serve then this only works with chrome
    gulp.src("app/spec/fixtures/**")
    .pipe(gulpif(/[.]js$/,jshint()))
    .pipe(gulpif(/[.]js$/,jshint.reporter("default")))
    .pipe(gulpif(/[.]coffee$/, coffeelint()))
    .pipe(gulpif(/[.]coffee$/, coffeelint.reporter()))
    .pipe(gulpif(/[.]coffee$/, coffee().on('error', log)))
    .pipe(size( title:'spec.js'))
    .pipe(gulp.dest("dist/fixtures"))

  dependencyTasks = if dependencyTasks? then [buildOurSpecs,"scripts"].concat(dependencyTasks) else [buildOurSpecs,"scripts"]

  log "#{bang}BEGIN:Spec dependencyTasks#{bang}"
  dependencyTasks.forEach (d)->
    log "#{bang}#{d}#{bang}"
  log "#{bang}End:Spec dependencyTasks#{bang}"

  log "#{bang} Spec Task #{runSpecs} defined. #{bang}"
  gulp.task runSpecs, dependencyTasks, ->
    gulp.src srcFileNames
    .pipe(runner())

  dependencyTasks = if specRunner.coverage then dependencyTasks.concat([specRunner.coverage]) else dependencyTasks
  log "#{bang} Spec Coverage dependencyTasks#{bang}"
  dependencyTasks.forEach (d)->
    log "#{bang}#{d}#{bang}"
  gulp.task coverSpecs, dependencyTasks

  spec: runSpecs
