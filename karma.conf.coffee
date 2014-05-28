# Karma configuration
# Generated on Tue May 27 2014 15:17:04 GMT-0400 (EDT)

module.exports = (config) ->
  config.set

    # base path that will be used to resolve all patterns (eg. files, exclude)
    basePath: ''

    # frameworks to use
    # available frameworks: https://npmjs.org/browse/keyword/karma-adapter
    frameworks: ['jasmine', 'fixture']

    # preprocess matching files before serving them to the browser
    # available preprocessors: https://npmjs.org/browse/keyword/karma-preprocessor
    preprocessors: {
      'dist/fixtures/*.html': ['html2js']
      'dist/fixtures/**/*.json': ['html2js']
      # '**/*.coffee': ['coffee']
      'dist/all.js': ['coverage']
    }

    coverageReporter:
      type : 'html',
      dir : 'dist/coverage/'
      middlePathDir: "chrome"

    # list of files / patterns to load in the browser
    files: [
      'dist/fixtures/*.html'
      'dist/fixtures/json/*.json'
      "app/spec/karma_init.js"
      'dist/vendor_develop.js'
      # 'dist/jasmine-jquery.js'
      # 'dist/jasminerice.js'
      {pattern:'dist/**/*.css', included: false}
      'dist/templates.js'
      {pattern:'dist/jasmine*.js', included: false}
      {pattern:'dist/*.css', included: false}
      {pattern:'dist/boot.js', included: false}
      {pattern:'dist/console.js', included: false}
      {pattern:'dist/karma_html/**', included: false}
      'dist/*.js'
      'dist/all.js'
      'dist/spec.js'
      'dist/**/*.html'
    ]

    # list of files to exclude
    exclude: [
    ]

    # test results reporter to use
    # possible values: 'dots', 'progress'
    # available reporters: https://npmjs.org/browse/keyword/karma-reporter
    reporters: ['progress','dots', 'html', 'coverage']

    htmlReporter:
      middlePathDir: "chrome"
      outputDir: 'dist/karma_html',
      templatePath: 'app/spec/karma_jasmine_runner.html'

    # web server port
    port: 9876


    # enable / disable colors in the output (reporters and logs)
    colors: true


    # level of logging
    # possible values:
    # - config.LOG_DISABLE
    # - config.LOG_ERROR
    # - config.LOG_WARN
    # - config.LOG_INFO
    # - config.LOG_DEBUG
    logLevel: config.LOG_INFO


    # enable / disable watching file and executing tests whenever any file changes
    autoWatch: true


    # start these browsers
    # available browser launchers: https://npmjs.org/browse/keyword/karma-launcher
    browsers: ['Chrome']


    # Continuous Integration mode
    # if true, Karma captures browsers, runs the tests and exits
    singleRun: false

    plugins: [
      'karma-coverage'
      'karma-jasmine'
      'karma-html2js-preprocessor'
      'karma-fixture'
      'karma-html-reporter'
      'karma-chrome-launcher'
      'karma-firefox-launcher'
      'karma-ie-launcher'
      # 'karma-opera-launcher'
      'karma-phantomjs-launcher'
      'karma-safari-launcher'
      'karma-coffee-preprocessor'
    ]


  urlRoot: "base/dist/karma_html/chrome/index.html"
