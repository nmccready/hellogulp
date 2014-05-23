(function() {
  beforeEach(function() {
    loadFixtures("container");
    return this.fixture = $("#container");
  });

}).call(this);

(function() {
  describe('app.views.Main', function() {
    beforeEach(function() {
      var json;
      json = loadJSONFixtures('main').main;
      this.testCtor = app.views.Main;
      this.subject = new this.testCtor({
        el: this.fixture,
        model: new Backbone.Model(json)
      });
      return this.subject.render();
    });
    afterEach(function() {
      return this.subject.close();
    });
    return it('constructor - exists', function() {
      return expect(this.testCtor).toBeDefined();
    });
  });

}).call(this);
