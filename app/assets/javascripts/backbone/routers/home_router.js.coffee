class Emoticard.Routers.HomesRouter extends Backbone.Router
  initialize: (options) ->

  routes:
    ".*": "splash"
    "home/:id": "welcomehome"
    "home": "home"
  
  splash: ->
    @view = new Emoticard.Views.Homes.SplashView()
    $("#base").html(@view.render().el)

  welcomehome: (id) ->
    @view = new Emoticard.Views.Homes.HomeView()
    $("#base").html(@view.render().el)
 
  home: ->
    @view = new Emoticard.Views.Homes.HomeView()
    $("#base").html(@view.render().el)

