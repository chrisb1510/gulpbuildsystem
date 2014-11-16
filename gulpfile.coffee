coffee = require 'gulp-coffee'
gulp = require 'gulp'
gUtil = require 'gulp-util'
filter = require 'gulp-filter'
less = require 'gulp-less'
sourceMaps = require 'gulp-sourcemaps'

karma = require('karma').server
mocha = require 'karma-mocha'
del = require 'del'

browserSync = require 'browser-sync'

handleError = (error)->
  new gUtil.PluginError('less',error, {showStack:true})
  @emit('end')


gulp.task 'trycatchtest',(done)->
  #throwing an error
  try
#    throw "hello error"
    console.log 'test'

  catch
    #catch the error and print it
    err = new gUtil.PluginError('test', _error, {showStack: true});

  finally
    #always do these
#    console.log 'done'
    done( if !err? then console.log 'no error' else err)

gulp.task 'karmaRunner', (done)->
  karma.start({
    configFile: __dirname + '/karma.conf.coffee',
    singleRun: false
  }, done)


gulp.task 'less',(done) ->
  gulp.src ['styles/**/*.less']
  .pipe sourceMaps.init()
  .pipe less()
  .on 'error',handleError
  .pipe sourceMaps.write '/maps'
  .pipe gulp.dest 'build/css'
  .pipe filter('**/*.js')
  .pipe browserSync.reload { stream:true }
  done(error?)

gulp.task 'srcCoffee',(done)->
  gulp.src ['src/**/*.coffee']
  .pipe sourceMaps.init()
  .pipe coffee()
  .on 'error', handleError
  .pipe sourceMaps.write '/maps'
  .pipe gulp.dest 'build/js'
  .pipe filter('**/*.js')
  .pipe browserSync.reload { stream:true }
  done(error?)

gulp.task 'teacupCompile',(done) ->
  gulp.src ['views/src/**/*.coffee']
  .pipe sourceMaps.init()
  .pipe coffee { bare:true }
  .on 'error', handleError
  .pipe sourceMaps.write 'build/views/maps'
  .pipe gulp.dest 'build/views'
  .pipe filter('**/*.js')
  .pipe browserSync.reload { stream:true }
  done(error?)

gulp.task 'cleanCss',(done)->
  del 'build/css/*',done
gulp.task 'cleanJs',(done)->
  del 'build/js/*',done
gulp.task 'cleanViews',(done)->
  del 'build/views/*',done

gulp.task 'cleanAll',['cleanCss','cleanJs','cleanViews'],(done)->
  if error?
    handleError
  else
    gUtil.log "All Clean"
    done

gulp.task 'browser-sync',['less','srcCoffee','teacupCompile'], ->

  browserSync
    files:[
      'css/**/*.css'
      'src/**/*.js'
      'views/**/*.js'
    ]
    server:
      baseDir: "build"




gulp.task 'default',['browser-sync'], ->
  gulp.watch "views/**/*.coffee", ['teacupCompile']
  gulp.watch "src/**/*.coffee", ['srcCoffee']
  gulp.watch "styles/**/*.less", ['less']



