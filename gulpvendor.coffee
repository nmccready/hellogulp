module.exports = (gulp, log, concat, size, myClean) ->
  bang = '!!!!!!!!!!'
  log "#{bang}Vendors Setup#{bang}"
  ###
  this file should be called by gulpfile.coffee
  with gulp and plugins already loaded
  ###
  vendorDev = "vendor_develop"
  vendorProd = "vendor_prod"

  devVendors = [
    "jquery"
    "jquery-ui"
    "d3"
    "dist/lodash.underscore"
    "scroll"
    "backbone"
    "lib/backbone.marionette"
    "dist/backbone.validation"
    "handlebars"
  ]
  devVendors = devVendors.map (v) ->
    v = "bower_components/**/#{v}".js()
    log v
    v
  gulp.task vendorDev, ->
    log "#{bang}Loading Vendor Tasks#{bang}"
    myClean("dist/#{vendorDev.js()}",true)
    gulp.src(devVendors)
    .pipe(concat(vendorDev.js()))
    .pipe(size( title: vendorDev.js()))
    .pipe(gulp.dest("dist"))
    log "#{bang}Out of Vendor Tasks#{bang}"
  # .pipe(uglify())
  # .pipe(rename(vendorDev.js.toMin))
  # .pipe(size( title:vendorDev.js.toMin))
  # .pipe(gulp.dest("dist"))
  develop: vendorDev
  prod: vendorProd
