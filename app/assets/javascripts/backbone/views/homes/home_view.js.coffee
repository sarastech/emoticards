Emoticard.Views.Homes ||= {}

class Emoticard.Views.Homes.HomeView extends Backbone.View
  template: JST["backbone/templates/homes/home"]
  
  constructor: (options) ->
    super(options)
    @member = new Emoticard.Models.Member();

  render: ->
    @member.fetch(
      success: =>
        $(@el).html(@template())
    )
    
    return this
