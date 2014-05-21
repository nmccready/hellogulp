gulp         = require("gulp")
coffee       = require('gulp-coffee')
jshint       = require("gulp-jshint")
sass         = require("gulp-sass")
concat       = require("gulp-concat")
uglify       = require("gulp-uglify")
rename       = require("gulp-rename")
gutil        = require("gulp-util")
clean        = require("gulp-clean")
order        = require("gulp-order")
gulpif       = require("gulp-if")
coffeelint   = require("gulp-coffeelint")
serve        = require("gulp-serve")
open         = require("gulp-open")
handlebars   = require('gulp-handlebars')
defineModule = require('gulp-define-module')
size = require('gulp-size')

gulp.task "sass", ["clean"], ->
  gulp.src("scss/*.scss").pipe(sass()).pipe gulp.dest("css")

gulp.task "templates", ["sass"], ->
  gulp.src(['src/templates/*.hbs'])
  .pipe(handlebars())
  .pipe(defineModule('node'))
  .pipe(rename("templates.js"))
  .pipe(size( title:'templates.js'))
  .pipe(gulp.dest('dist'))
  .pipe(uglify())
  .pipe(rename("templates.min.js"))
  .pipe(size( title:'templates.min.js'))
  .pipe(gulp.dest("dist"))

gulp.task "scripts", ["templates"], ->
  gulp.src("src/scripts/*")
  .pipe(gulpif(/[.]js$/,jshint()))
  .pipe(gulpif(/[.]js$/,jshint.reporter("default")))
  .pipe(gulpif(/[.]coffee$/, coffeelint()))
  .pipe(gulpif(/[.]coffee$/, coffeelint.reporter()))
  .pipe(gulpif(/[.]coffee$/, coffee().on('error', gutil.log)))
  .pipe(order([
    "lib/js1.js"
    "lib/**/*.js"
    "src/coffee1.js"
    "src/**/*.js"
  ]))
  .pipe(concat("all.js"))
  .pipe(size( title:'all.js'))
  .pipe(gulp.dest("dist"))
  .pipe(uglify())
  .pipe(rename("all.min.js"))
  .pipe(size( title:'all.min.js'))
  .pipe(gulp.dest("dist"))

gulp.task "watch", ["scripts"], ->
  gulp.watch "src/*", ["scripts"]
  gulp.watch "src/**/*", ["scripts"]
  gulp.watch "scss/*.scss", ["sass"]

gulp.task "clean", ->
  gulp.src('dist', read: false )
  .pipe( do ->
    c = clean()
    gutil.log "clean is really done!!"
    c
  )

gulp.task "serve-build", serve
  root:[ "public","dist"]
  port: 3000

gulp.task "serve-prod", serve
  root: ["public","dist"]
  port: 80
  middleware: (req, res) ->

gulp.task "open-build", ["watch"],->
  options = {
    url: "http://localhost:3000/all.js",
    app: "Google Chrome" #osx , linux: google-chrome, windows: chrome
  };
  gulp.src("dist/*")
  .pipe(open("", options));

gulp.task "default", ["clean","sass","templates","scripts","watch"]
gulp.task "serve", ["default","serve-build","open-build"]
