istanbul = require('gulp-istanbul')
debug = require('gulp-debug')

module.exports = (srcFileNames, gulp, log, concat, size, minify, rename, jshint, coffee,
coffeelint, gulpif, dependencyTasks, runner, myClean, appendName = undefined, bang = '!!!!!!!!!!') ->
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

  dependencies = if dependencyTasks? then [buildOurSpecs,"scripts"].concat(dependencyTasks) else [buildOurSpecs,"scripts"]

  log "#{bang}BEGIN:Spec dependencies#{bang}"
  dependencies.forEach (d)->
    log "#{bang}#{d}#{bang}"
  log "#{bang}End:Spec dependencies#{bang}"

  log "#{bang} Spec Task #{runSpecs} defined. #{bang}"
  gulp.task runSpecs, dependencies, ->
    gulp.src srcFileNames
    .pipe(runner())

  gulp.task coverSpecs, dependencies, ->
    # Covering files
    gulp.src srcFileNames
    .pipe(istanbul()).on "finish", ->
      gulp.src("dist/spec.js")#["dist/spec_runner.html"])
      # .pipe(runner())

      .pipe(istanbul.writeReports())
      .pipe(debug({verbose: true}))


    gulp.src("coverage/**/*")
    .pipe(gulp.dest("dist/coverage"))
    #duplicating since lcov-report is not being resolved by browser
    gulp.src("dist/coverage/lcov-report/**")
    .pipe gulp.dest("dist/coverage/report")

  spec: runSpecs
