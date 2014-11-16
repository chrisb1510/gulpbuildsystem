# Karma configuration
# Generated on Sat Nov 15 2014 23:08:31 GMT+0000 (GMT)

module.exports = (config) ->
  config.set

    # base path that will be used to resolve all patterns (eg. files, exclude)
    basePath: './'

    port: 3030
    # frameworks to use
    # available frameworks: https://npmjs.org/browse/keyword/karma-adapter
    frameworks: ['mocha','chai']


    # list of files / patterns to load in the browser
    files: [
      'src/**/*.coffee'
      'test/**/*.coffee'
      {
        pattern:'coverage/**/*'
        served:true
        watched:true, included:false
      }
    ]


    # list of files to exclude
    exclude: [
    ]


    # preprocess matching files before serving them to the browser
    # available preprocessors: https://npmjs.org/browse/keyword/karma-preprocessor
    preprocessors: {

      '**/*.html': []

      'src/**/*.coffee':['coverage']
      'test/**/*.coffee': ['coffee']
    }

    coffeePreprocessor:
  # options passed to the coffee compiler
      options:
        bare: true
        sourceMap: true

    client:
      mocha:
        reporter: 'html'# change Karma's debug.html to the mocha web reporter



    # test results reporter to use
    # possible values: 'dots', 'progress'
    # available reporters: https://npmjs.org/browse/keyword/karma-reporter
    reporters: ['progress','coverage']


    coverageReporter:

      type : 'coverage'
      dir :'build'
      subdir: (browser)->
        #  shorten browser name
        return browser.toLowerCase().split(/[ /-]/)[0]

  # web server port









    # enable / disable colors in the output (reporters and logs)
    colors: true


    # level of logging
    # possible values:
    # - config.LOG_DISABLE
    # - config.LOG_ERROR
    # - config.LOG_WARN
    # - config.LOG_INFO
    # - config.LOG_DEBUG
    logLevel: config.LOG_DEBUG


    # enable / disable watching file and executing tests whenever any file changes
    autoWatch: true





    # Continuous Integration mode
    # if true, Karma captures browsers, runs the tests and exits
    singleRun: false
