gulp        = require("gulp")
coffee      = require('gulp-coffee')
jshint      = require("gulp-jshint")
sass        = require("gulp-sass")
concat      = require("gulp-concat")
uglify      = require("gulp-uglify")
rename      = require("gulp-rename")
gutil       = require("gulp-util")
clean       = require("gulp-clean")
order       = require("gulp-order")
gulpif      = require("gulp-if")
coffeelint  = require("gulp-coffeelint")

gulp.task "sass", ->
  gulp.src("scss/*.scss").pipe(sass()).pipe gulp.dest("css")

gulp.task "scripts", ->
  gulp.src("src/*")
  .pipe(gulpif(/[.]js$/,jshint()))
  .pipe(gulpif(/[.]js$/,jshint.reporter("default")))
  .pipe(gulpif(/[.]coffee$/, coffeelint()))
  .pipe(gulpif(/[.]coffee$/, coffeelint.reporter()))
  .pipe(gulpif(/[.]coffee$/, coffee().on('error', gutil.log)))
  # .pipe(gulp.src("src/*.js")) # gulp.src passes through input
  .pipe(order([
    "lib/js1.js"
    "lib/**/*.js"
    "src/coffee1.js"
    "src/**/*.js"
  ]))
  .pipe(concat("all.js"))
  .pipe(gulp.dest("dist"))
  .pipe(rename("all.min.js"))
  .pipe(uglify())
  .pipe(gulp.dest("dist"))

gulp.task "watch", ->
  gulp.watch "src/*", ["scripts"]
  gulp.watch "src/**/*", ["scripts"]
  gulp.watch "scss/*.scss", ["sass"]

gulp.task "clean", ->
  gulp.src('dist', read: false )
  .pipe(clean());

gulp.task "default", ["sass","scripts", "watch"]
