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
page.settings.userAgent = 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.120 Safari/537.36 FTBImageGenerator/1.0';

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
    // after reloaded
    page.onLoadFinished = function(status) {
      var startProcess = function(data) {
        console.log('Main page is loaded and ready');
        //Do whatever here
        if(play) {
          page.evaluate( function() {
            var element = document.querySelector( '.gfx-slider-play' );
            var event = document.createEvent( 'MouseEvent' );
            event.initMouseEvent( 'click', true, true, window, 1, 0, 0 );   
            // send click to element
            element.dispatchEvent( event );
          });
          startCapture();
        }
        else {
          startCapture();
        }
      };
      setTimeout(function() {
        startProcess();
      }, 1000);
    };

    // reload
    page.reload();
  }, 500);
});