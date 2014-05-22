module.exports = (gulp, log, concat, size, minify, rename,myClean) ->
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
    # "underscore"
    "dist/lodash.underscore"
    "lib/underscore.string"
    "backbone"
    "lib/backbone.marionette"
    "dist/backbone.validation"
    "handlebars"
    "scroll"
    "d3"
  ]

  devVendors = devVendors.map (v) ->
    v = "bower_components/*/#{v}".js()
    log v
    v

  gulp.task vendorDev, ->
    log "#{bang}Loading Vendor Tasks#{bang}"
    myClean("dist/#{vendorDev.js()}")
    gulp.src(devVendors)
    .pipe(concat(vendorDev.js()))
    .pipe(size( title: vendorDev.js()))
    .pipe(gulp.dest("dist"))

  gulp.task vendorProd + "_compile", ->
    log "#{bang}Loading Vendor Tasks#{bang}"
    myClean("dist/#{vendorDev.js().toMin()}")
    gulp.src(devVendors)
    .pipe(minify())
    .pipe(concat(vendorDev.js().toMin()))
    .pipe(size( title:vendorDev.js().toMin()))
    .pipe(gulp.dest("dist"))

    log "#{bang}Out of Vendor Tasks#{bang}"
    
  develop: vendorDev
  prod: vendorProd
