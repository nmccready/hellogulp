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

- ```serve``` or ```s```
- ```clean```
- ```vendor_develop```
- ```vendor_prod_compile```
- ```default``` or empty / no args
- ```spec``` :
  - runs karma
  - coverage reports (html and cobertura)
  - also you can run karma via the command line as well ```karma start```
    - this will allow you to debug the karma served javascript as well from:
      - [http://localhost:9876](http://localhost:9876)
      - [http://localhost:9876/base/dist/karma_html/chrome/index.html](http://localhost:9876/base/dist/karma_html/chrome/index.html)
- ```spec_jasmine```
  - runs jasmine command line only
  - generates xml report pass/fail

- ```jasmine``` :
  - serves and opens browser to [localhost:3000/jasmine.html](http://localhost:3000/jasmine.html) (alias to spec_runner.html))

- many sub tasks that are run behind the scenes examples: ```["jasmine_build","karma_build"]```

Notes:
  hosting:
  - everything is being hosted out of dist or public
  - all specs and fixtures are copied to dist

- lib/jasminerice.js added from rails into lib since it is not a node/bower project
- jasmine-jquery-overrides.js - to support JQuery 1.7.2
