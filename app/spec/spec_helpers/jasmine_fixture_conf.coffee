unless String.prototype.contains
  String.prototype.contains = (toFind) ->
    this.indexOf(toFind) > -1

do ->
  window.isFullKarma= isFullKarma = window.__karma__
  window.isKarmaEnvBrowser = isKarmaEnvBrowser =
    #has the karma base path
    window.location.href.contains("base")

  if isFullKarma
    #make html2js fixture loading behave like jasmine-jquery
    window.loadFixtures = (path) ->
      fixture.load("container.html")
      html = fixture[0].innerHTML
      $('body').append = html
    return
  else
    obj =
      loadFixtures: window.loadFixtures
    loadFixtures = _.clone(obj,true).loadFixtures
    window.loadFixtures = (path) ->
      if path.contains(".json")
        propName = path.replace(".json","")
        loadFixtures(path)[propName]
      else
        loadFixtures(path)

  if isKarmaEnvBrowser
    fixurePath  ='/base/dist/fixtures'
  else
    fixurePath  ='fixtures'

  window.jasmine?.getFixtures?().fixturesPath = fixurePath
  window.jasmine?.getStyleFixtures?().fixturesPath = fixurePath
  window.jasmine?.getJSONFixtures?().fixturesPath = "#{fixurePath}/json"
