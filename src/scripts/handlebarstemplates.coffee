window.HandlebarsTemplates = _.clone jsTemplates, true

init = (obj = window.HandlebarsTemplates) ->
  _.keys(obj).forEach (k) ->
    if _.isString obj[k]
      obj[k] = Handlebars.compile obj[k]
    else if _.isObject obj[k]
      init obj

init()
