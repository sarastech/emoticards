Emoticard.Views.Homes ||= {}

class Emoticard.Views.Homes.HomeView extends Backbone.View
  template: JST["backbone/templates/homes/home"]
  
  events :
    "click #fbwallpost" : "post_to_wall"
  
  constructor: (options) ->
    super(options)
    @member = new Emoticard.Models.Member();
    
  post_to_wall: (e) ->
    obj =
      method: 'feed',
      redirect_uri: 'http://localhost:3000',
      link: 'http://en.wikipedia.org/wiki/Rajinikanth',
      picture: 'http://4.bp.blogspot.com/_BbJAArGDIEA/SFvhH0Ar54I/AAAAAAAAGsA/FP9PEiviL84/s400/rajinikanth.jpg',
      name: 'Wish Rajini',
      caption: '12-12-12',
      message: 'hi'
      description: 'Biggest birthday wish for Rajini.'
    FB.ui(obj)
    
  render: ->
    @member.fetch(
      success: =>
        $(@el).html(@template())
    )
    
    return this
