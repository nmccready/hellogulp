_            = require('./node_modules/underscore/underscore-min')
gulp         = require("gulp")
coffee       = require('gulp-coffee')
jshint       = require("gulp-jshint")
sass         = require("gulp-sass")
concat       = require("gulp-concat")
minify       = require("gulp-uglify")
rename       = require("gulp-rename")
gutil        = require("gulp-util")
clean        = require("gulp-clean")
order        = require("gulp-order")
gulpif       = require("gulp-if")
coffeelint   = require("gulp-coffeelint")
serve        = require("gulp-serve")
open         = require("gulp-open")
handlebars   = require('gulp-jstemplater')
defineModule = require('gulp-define-module')
declare      = require('gulp-declare')
size         = require('gulp-size')

jsToMin = (fileName) ->
  fileName.replace('.','.min.')

String.prototype.toMin = ->
  jsToMin this

String.prototype.js = ->
  this + ".js"

myClean = (fileORDirName, doMin) ->
  gulp.src(fileORDirName, read: false )
  .pipe do ->
    c = clean()
    gutil.log "cleaned #{fileORDirName}!!"
    c
  if doMin
    myClean fileORDirName.toMin()

gulp.task "sass", ->
  myClean("dist/stylesheets.css",true)
  gulp.src("src/stylesheets/*.scss")
  .pipe(sass().on("error", gutil.log))
  .pipe(concat("stylesheets.css"))
  .pipe(size( title:'stylesheets.css'))

  .pipe(gulp.dest("dist"))

gulp.task "templates", ->
  myClean("dist/templates.js",true)
  gulp.src(['src/templates/*.hbs'])
  .pipe( handlebars  "templates.js", variable: "jsTemplates" )
  .pipe(rename("templates.js"))
  .pipe(size( title:'templates.js'))
  .pipe(gulp.dest('dist'))
  .pipe(minify())
  .pipe(rename("templates.min.js"))
  .pipe(size( title:'templates.min.js'))
  .pipe(gulp.dest("dist"))

gulp.task "scripts", ->
  myClean("dist/all.js",true)
  gulp.src(["src/scripts/**/*"])
  .pipe(gulpif(/[.]js$/,jshint()))
  .pipe(gulpif(/[.]js$/,jshint.reporter("default")))
  .pipe(order [
    "handlebarstemplates.coffee"
    "baseobject.coffee"
    "namespace.coffee"
    "test.coffee"
    "crap.js"
    "views/*.coffee"])
  .pipe(gulpif(/[.]coffee$/, coffeelint()))
  .pipe(gulpif(/[.]coffee$/, coffeelint.reporter()))
  .pipe(gulpif(/[.]coffee$/, coffee().on('error', gutil.log)))
  .pipe(concat("all.js"))
  .pipe(size( title:'all.js'))
  .pipe(gulp.dest("dist"))
  .pipe(minify())
  .pipe(rename("all.min.js"))
  .pipe(size( title:'all.min.js'))
  .pipe(gulp.dest("dist"))

gulp.task "watch", ["scripts"], ->
  gulp.watch "src/*", ["scripts"]
  gulp.watch "src/**/*", ["scripts"]
  gulp.watch "scss/*.scss", ["sass"]

gulp.task "clean", ->
  gulp.src('dist', read: false )
  .pipe clean()

gulp.task "serve-build", serve
  root:[ "public","dist"]
  port: 3000

gulp.task "serve-prod", serve
  root: ["public","dist"]
  port: 80
  middleware: (req, res) ->

gulp.task "open-build", ["watch"],->
  options =
    url: "http://localhost:3000/index.html"
    app: "Google Chrome" #osx , linux: google-chrome, windows: chrome
  gulp.src("dist/all.js")
  .pipe(open("", options))

vendors = require('./gulpvendor.coffee')(gulp, gutil.log,
concat, size, minify,rename, myClean)

jasmine = require('./gulpjasmine.coffee')(gulp, gutil.log,
concat, size, minify,rename, myClean)

spec = require('./gulpspec.coffee')(gulp, gutil.log,
concat, size, minify,rename, jshint, coffee, coffeelint, gulpif
_.values(jasmine.dependencyTasks), jasmine.runner, myClean)


#base tasks
gulp.task "default", ["sass","templates","scripts", vendors.develop,
  spec.spec, "watch"]

gulp.task "serve", ["default", vendors.develop,"serve-build","open-build"]

gulp.task "s", ["serve"]
