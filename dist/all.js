function test(){
  alert('test2');
}

function hi2(){
  var s = "hi";
  return s;
}

function hi3(){
  var s = "hi";
  return s;
}

function hi4(){
  var s = "hi";
  return s;
}

(function() {
  var HelloWorld;

  HelloWorld = (function() {
    function HelloWorld() {}

    hi(function() {
      return alert("HI");
    });

    return HelloWorld;

  })();

}).call(this);
