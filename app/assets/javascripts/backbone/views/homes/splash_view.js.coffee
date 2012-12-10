Emoticard.Views.Homes ||= {}

class Emoticard.Views.Homes.SplashView extends Backbone.View
  template: JST["backbone/templates/homes/splash"]

  render: ->
    $(@el).html(@template())
    return this
