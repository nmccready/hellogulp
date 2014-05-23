Install the following globally:
- node && npm
- bower
- gulp
- [coffeegulp] (https://github.com/minibikini/coffeegulp)

Satisfy Project Dependencies:

```
npm install
bower install
```

Run gulp via coffeegulp, ```coffeegulp``` or shell script included ```cgulp```


tasks:

- serve or s
- clean
- vendor_develop
- vendor_prod_compile
- default or "empty"
- spec
- jasmine (serves and opens browser to localhost:3000/jasmine.html (alias to spec_runner.html))

Notes:
  hosting:
    - everything is being hosted out of dist or public
    - all specs and fixtures are copied to dist
    
- lib/jasminerice.js added from rails into lib since it is not a node/bower project
- jasmine-jquery-overrides.js - to support JQuery 1.7.2
