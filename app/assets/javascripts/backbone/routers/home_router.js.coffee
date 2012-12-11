class Emoticard.Routers.HomesRouter extends Backbone.Router
  initialize: (options) ->
    @bind 'all', @_trackPageview

  _trackPageview: ->
    url = Backbone.history.getFragment()
    _gaq.push(['_trackPageview', "/#{url}"])

  routes:
    ".*": "splash"
    "home": "home"
  
  splash: ->
    @view = new Emoticard.Views.Homes.SplashView()
    $("#base").html(@view.render().el)
 
  home: ->
    @view = new Emoticard.Views.Homes.HomeView()
    $("#base").html(@view.render().el)

