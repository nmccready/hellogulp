
/*
    Created to make namespaces safely without stomping and crushing
    other namespaces and or objects
    (taken/modified from stack overflow)
    author: Nick McCready
 */

(function() {
  this.namespace = function(names, fn) {
    var space, _name;
    if (fn == null) {
      fn = function() {};
    }
    if (typeof names === 'string') {
      names = names.split('.');
    }
    space = this[_name = names.shift()] || (this[_name] = {});
    space.namespace || (space.namespace = this.namespace);
    if (names.length) {
      return space.namespace(names, fn);
    } else {
      return fn.call(space);
    }
  };

}).call(this);

(function() {
  var A, HelloWorld,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  A = (function() {
    function A() {}

    A.prototype.a = function() {
      return "a";
    };

    return A;

  })();

  HelloWorld = (function(_super) {
    __extends(HelloWorld, _super);

    function HelloWorld() {
      return HelloWorld.__super__.constructor.apply(this, arguments);
    }

    HelloWorld.prototype.hi = function() {
      return "hello world";
    };

    HelloWorld.prototype.hi2 = function() {};

    return HelloWorld;

  })(A);

}).call(this);

function test(){
  return 'test';
}

function hi2(){
  return "hi2";
}

function hi3(){
  return "hi3";
}

function hi4(){
  return "hi4";
}

(function() {
  this.namespace("app.views");

  app.views.Main = Marionette.ItemView.extend({
    template: hbs.crap
  });

  $(function() {
    var model, view;
    model = new Backbone.Model({
      crap: "wow some crap!!!"
    });
    view = new app.views.Main({
      el: $("#main"),
      model: model
    });
    return view.render();
  });

}).call(this);

(function() {
  var baseObjectKeywords,
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  baseObjectKeywords = ['extended', 'included'];

  this.BaseObject = (function() {
    function BaseObject() {}

    BaseObject.extend = function(obj) {
      var key, value, _ref;
      for (key in obj) {
        value = obj[key];
        if (__indexOf.call(baseObjectKeywords, key) < 0) {
          this[key] = value;
        }
      }
      if ((_ref = obj.extended) != null) {
        _ref.apply(0);
      }
      return this;
    };

    BaseObject.include = function(obj) {
      var key, value, _ref;
      for (key in obj) {
        value = obj[key];
        if (__indexOf.call(baseObjectKeywords, key) < 0) {
          this.prototype[key] = value;
        }
      }
      if ((_ref = obj.included) != null) {
        _ref.apply(0);
      }
      return this;
    };

    return BaseObject;

  })();

}).call(this);

(function() {
  (function() {
    var init;
    window.hbs = _.clone(jsTemplates, true);
    init = function(obj) {
      if (obj == null) {
        obj = window.hbs;
      }
      return _.keys(obj).forEach(function(k) {
        if (_.isString(obj[k])) {
          return obj[k] = Handlebars.compile($(obj[k]).html());
        } else if (_.isObject(obj[k])) {
          return init(obj);
        }
      });
    };
    init();
    window.HandlebarsTemplates = hbs;
    return window.Handlebars.templates = hbs;
  })();

}).call(this);
