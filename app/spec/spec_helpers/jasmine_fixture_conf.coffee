do ->
  return if window.__karma__
  window.jasmine?.getFixtures?().fixturesPath = 'fixtures'
  window.jasmine?.getStyleFixtures?().fixturesPath = 'fixtures'
  window.jasmine?.getJSONFixtures?().fixturesPath = 'fixtures/json'
