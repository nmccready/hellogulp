@namespace "app.views"

app.views.Main = Marionette.ItemView.extend
  template: Handlebars.compile $("<div>{{crap}}</div>\n").html()
  #HandlebarsTemplates["crap"]


$ ->
  model = new Backbone.Model crap: "wow some crap!"
  view = new app.views.Main
    el: $ "#main"
    model: model
  view.render()
