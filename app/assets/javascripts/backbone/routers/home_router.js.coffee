class Emoticard.Routers.HomesRouter extends Backbone.Router
  initialize: (options) ->

  routes:
    ".*": "splash"
  
  splash: ->
    @view = new Emoticard.Views.Homes.SplashView()
    $("#base").html(@view.render().el)

