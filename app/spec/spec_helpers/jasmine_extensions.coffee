beforeEach ->
  unless not window.__karma__
    loadFixtures?("container.html")
    @fixture = $ "#container"

  if window.__karma__
    fixture.load("container.html")
    @fixture =  $ fixture[0].innerHTML
