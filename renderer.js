var system = require('system');
var page = new WebPage();
var zpad = require('zpad');

// prefix of the snapshot
var prefix = system.args[1];
// url
var address = system.args[2];
// interval
var wait = parseInt(system.args[3]);
// number of snapshots
var iterations = parseInt(system.args[4]);
// manual play needed
var play = system.args[5] == 'true';

// browser size / snapshot dimension
page.viewportSize = { width: 1024, height: 768 };

// open the web page
page.open(address, function(status){
  // successfully loaded
  // now, start asynchronously to reload the cached page and take snapshot
  setTimeout(function() {
    var startCapture = function() {
      page.evaluate(function() {
        document.body.bgColor = '#ffffff';
      });
      var i = 0;
      // capture snapshot every `wait` milliseconds
      setInterval(function() {
        page.render('temp/' + prefix + '-' + zpad(i, 3) + '.png');
        i++;
        if(i >= iterations) {
          phantom.exit();
        }
      }, wait);
    };
    var mouseclick = function ( element ) {
      // create a mouse click event
      var event = document.createEvent( 'MouseEvents' );
      event.initMouseEvent( 'click', true, true, window, 1, 0, 0 );
   
      // send click to element
      element.dispatchEvent( event );
    };
    // after reloaded
    page.onLoadFinished = function(status) {
      if(play) {
        var element = document.querySelector( '.gfx-slider-play' );
        mouseclick_fn( element );
        startCapture();
      }
      else {
        startCapture();
      }
    };

    // reload
    page.reload();
  }, 500);
});