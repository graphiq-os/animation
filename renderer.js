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

// browser size / snapshot dimension
page.viewportSize = { width: 1024, height: 768 };

// open the web page
page.open(address, function(status){
  // successfully loaded
  // now, start asynchronously to reload the cached page and take snapshot
  setTimeout(function() {
    // after reloaded
    page.onLoadFinished = function(status) {
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

    // reload

    page.reload();
  }, 500);
});