do ->
  window.isFullKarma= isFullKarma = window.__karma__
  window.isKarmaEnvBrowser = isKarmaEnvBrowser =
    window.location.href.contains("base")#has the karma base path

  if isFullKarma
    #make html2js fixture loading behave like jasmine-jquery
    window.loadFixtures = (path) ->
      fixture.load("container.html")
      html = fixture[0].innerHTML
      $('body').append = html
    return

  if isKarmaEnvBrowser
    window.jasmine?.getFixtures?().fixturesPath = 'fixtures'
    window.jasmine?.getStyleFixtures?().fixturesPath = 'fixtures'
    window.jasmine?.getJSONFixtures?().fixturesPath = 'fixtures/json'
  else
    window.jasmine?.getFixtures?().fixturesPath = 'base/fixtures'
    window.jasmine?.getStyleFixtures?().fixturesPath = 'base/fixtures'
    window.jasmine?.getJSONFixtures?().fixturesPath = 'base/fixtures/json'
