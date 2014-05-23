(function() {
  (function() {
    var consoleReporter, execJasmine, jasmine, jasmineEnv, something;
    jasmine = window.jasmine;
    execJasmine = function() {
      return jasmineEnv.execute();
    };
    jasmineEnv = jasmine.getEnv();
    jasmineEnv.updateInterval = 1000;
    jasmine.getFixtures().fixturesPath = 'jasmine/fixtures';
    jasmine.getStyleFixtures().fixturesPath = 'jasmine/fixtures';
    jasmine.getJSONFixtures().fixturesPath = 'jasmine/fixtures/json';
    if (navigator.userAgent.indexOf('PhantomJS') > 0) {
      consoleReporter = new jasmineRequire.ConsoleReporter()({
        showColors: true,
        timer: new jasmine.Timer(),
        print: function() {
          return console.log.apply(console, arguments);
        }
      });
      jasmineEnv.addReporter(consoleReporter);
    }
    return something = 4;
  })();

}).call(this);
