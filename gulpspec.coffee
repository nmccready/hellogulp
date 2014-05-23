module.exports = (gulp, log, concat, size, minify, rename, jshint, coffee,
coffeelint, gulpif, dependencyTasks, runner, myClean, bang = '!!!!!!!!!!') ->
  log "#{bang}Spec Task Setup#{bang}"
  ###
  this file should be called by gulpfile.coffee
  with gulp and plugins already loaded
  ###

  buildOurSpecs = "spec_build"
  runSpecs = "spec"

  gulp.task buildOurSpecs, ->
    myClean("src/spec.js",true)
    gulp.src(["spec/spec_helpers/*","spec/scripts/**/*"])
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
    gulp.src("spec/fixtures/**")
    .pipe(gulpif(/[.]js$/,jshint()))
    .pipe(gulpif(/[.]js$/,jshint.reporter("default")))
    .pipe(gulpif(/[.]coffee$/, coffeelint()))
    .pipe(gulpif(/[.]coffee$/, coffeelint.reporter()))
    .pipe(gulpif(/[.]coffee$/, coffee().on('error', log)))
    .pipe(size( title:'spec.js'))
    .pipe(gulp.dest("dist/fixtures"))

  dependencies = if dependencyTasks? then [buildOurSpecs].concat(dependencyTasks) else [buildOurSpecs]

  log "#{bang}BEGIN:Spec dependencies#{bang}"
  dependencies.forEach (d)->
    log "#{bang}#{d}#{bang}"
  log "#{bang}End:Spec dependencies#{bang}"

  gulp.task runSpecs, dependencies, ->
    gulp.src("spec/spec_runner.html")
    .pipe(gulp.dest("dist"))

    gulp.src("dist/spec_runner.html").pipe(runner())

  spec: "spec"
