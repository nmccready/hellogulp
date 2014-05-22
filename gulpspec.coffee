module.exports = (gulp, log, concat, size, minify, rename, jshint, coffee,
coffeelint, gulpif, dependencyTasks, runner, myClean, bang = '!!!!!!!!!!') ->
  log "#{bang}Spec Task Setup#{bang}"
  ###
  this file should be called by gulpfile.coffee
  with gulp and plugins already loaded
  ###

  buildOurSpecs = "scripts_spec"
  runSpecs = "spec"

  gulp.task buildOurSpecs, ->
    myClean("src/spec.js",true)
    gulp.src(["spec/scripts/*","spec/scripts/**/*"])
    .pipe(gulpif(/[.]js$/,jshint()))
    .pipe(gulpif(/[.]js$/,jshint.reporter("default")))
    .pipe(gulpif(/[.]coffee$/, coffeelint()))
    .pipe(gulpif(/[.]coffee$/, coffeelint.reporter()))
    .pipe(gulpif(/[.]coffee$/, coffee().on('error', log)))
    .pipe(concat("spec.js"))
    .pipe(size( title:'spec.js'))
    .pipe(gulp.dest("dist"))

  dependencies = if dependencyTasks? then [buildOurSpecs].concat(dependencyTasks) else [buildOurSpecs]

  log "#{bang}BEGIN:Spec dependencies#{bang}"
  dependencies.forEach (d)->
    log "#{bang}#{d}#{bang}"
  log "#{bang}End:Spec dependencies#{bang}"

  gulp.task runSpecs, dependencies, ->
    gulp.src("spec/specRunner.html").pipe(runner())

  spec: "spec"
