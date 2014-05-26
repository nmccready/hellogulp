do ->
  window.hbs = _.clone jsTemplates, true

  init = (obj = window.hbs) ->
    _.keys(obj).forEach (k) ->
      if _.isString obj[k]
        obj[k] = Handlebars.compile $(obj[k]).html()
      else if _.isObject obj[k]
        init obj

  init()

  window.HandlebarsTemplates = hbs
  window.Handlebars.templates = hbs
