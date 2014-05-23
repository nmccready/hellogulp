  //support JQuery and JQuery 1.7.2 , 1.8+
  jasmine.Fixtures.prototype.loadFixtureIntoCache_ = function(relativeUrl) {

    var self = this,
        url = this.makeFixtureUrl_(relativeUrl),
        htmlText = '',
        request;

    if($.parseHTML){
      request = $.ajax({
        async: false, // must be synchronous to guarantee that no tests are run before fixture is loaded
        cache: false,
        url: url,
        success: function(data, status, $xhr) {
          htmlText = $xhr.responseText
        }
      }).fail(function($xhr, status, err) {
        throw new Error('Fixture could not be loaded: ' + url + ' (status: ' + status + ', message: ' + err.message + ')')
      })

      var scripts = $($.parseHTML(htmlText, true)).find('script[src]') || [];

      scripts.each(function() {
        $.ajax({
          async: false, // must be synchronous to guarantee that no tests are run before fixture is loaded
          cache: false,
          dataType: 'script',
          url: $(this).attr('src'),
          success: function(data, status, $xhr) {
            htmlText += '<script>' + $xhr.responseText + '</script>'
          },
          error: function($xhr, status, err) {
            throw new Error('Script could not be loaded: ' + scriptSrc + ' (status: ' + status + ', message: ' + err.message + ')')
          }
        });
      });

      self.fixturesCache_[relativeUrl] = htmlText;
    } else{ //support legacy jQuery < 1.8
      request = $.ajax({
        async: false, // must be synchronous to guarantee that no tests are run before fixture is loaded
        cache: false,
        url: url,
        success: function (data, status, $xhr) {
          self.fixturesCache_[relativeUrl] = $xhr.responseText
        },
        error: function (jqXHR, status, errorThrown) {
          throw new Error('Fixture could not be loaded: ' + url + ' (status: ' + status + ', message: ' + errorThrown.message + ')')
        }
      });
    }
  };
