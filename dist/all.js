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

    return HelloWorld;

  })(A);

}).call(this);
