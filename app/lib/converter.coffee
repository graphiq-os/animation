exec = require 'promise-exec'
ffmpeg = require 'fluent-ffmpeg';
q = require 'q'
moment = require 'moment'
config = require '../../config/config'
fs = require 'fs'
zpad = require 'zpad'

removeFiles = (files) ->
  for file in files
    fs.unlink file

module.exports.convert = (url, duration, play) ->
  deferred = q.defer()

  prefix = 'snap' + moment()
  interval = Math.round(1000/config.video.fps)
  snap_count = config.video.fps * duration
  cmd = 'node_modules/phantomjs/bin/phantomjs renderer.js ' + prefix + ' ' + url + ' ' + interval + ' ' + snap_count + ' ' + play
  console.log 'Renderer command: ' + cmd;
  exec cmd
    .then (out) ->
      images = []
      [0..snap_count-1].forEach (index) -> images.push config.root + '/temp/' + prefix + '-' + zpad(index, 3) + '.png'

      output = 'output/' + prefix + '.mp4'

      ffmpeg { source: config.root + '/temp/' + prefix + '-%03d.png', nolog: true }
        .fps config.video.fps
        .loop duration
        .on 'end', -> 
          deferred.resolve output
          removeFiles images
        .on 'error', (err) ->
          deferred.reject err
          removeFiles images
        .save 'public/' + output
    .catch (err) ->
      deferred.reject err

  deferred.promise