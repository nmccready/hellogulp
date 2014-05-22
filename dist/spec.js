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
    it('constructor - exists', function() {
      return expect(this.testCtor).toBeDefined();
    });
    it('internal model defined', function() {
      expect(this.subject.model).toBeDefined();
      return expect(this.subject.model.attributes).toBeDefined();
    });
    it('json fixture matches json', function() {
      return expect(this.subject.model.get('crap')).toEqual("test crap");
    });
    return it('was rendered', function() {
      var element;
      element = $(".crap");
      expect(element).toBeDefined();
      return expect(element.length > 0).toBeTruthy();
    });
  });

}).call(this);
