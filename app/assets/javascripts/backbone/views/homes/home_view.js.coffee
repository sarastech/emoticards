Emoticard.Views.Homes ||= {}

class Emoticard.Views.Homes.HomeView extends Backbone.View
  template: JST["backbone/templates/homes/home"]
  
  events :
    "click #fbwallpost" : "post_to_wall"
    "keydown #reason" : "displaycharlength"
  
  constructor: (options) ->
    super(options)
    @member = new Emoticard.Models.Member();
    
  post_to_wall: (e) ->
    obj =
      method: 'feed',
      redirect_uri: 'http://localhost:3000',
      link: 'http://en.wikipedia.org/wiki/Rajinikanth',
      picture: 'http://www.kollytalk.com/wp-content/uploads/2012/12/Shiva-with-Rajini.jpg',
      name: 'Wish Rajini',
      caption: '12-12-12',
      message: 'hi',
      description: 'Biggest birthday wish for Rajini.'
    FB.ui(obj)
    
  displaycharlength: (e) ->
    @message = $('#reason').val()
    length = 140 - @message.length
    $("#charlength").html(length + ' characters left.')
  
  render: ->
    @member.fetch(
      success: =>
        $(@el).html(@template())
    )
    
    return this
