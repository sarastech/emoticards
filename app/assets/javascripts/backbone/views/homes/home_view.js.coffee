Emoticard.Views.Homes ||= {}

class Emoticard.Views.Homes.HomeView extends Backbone.View
  template: JST["backbone/templates/homes/home"]
  
  events :
    "click #fbwallpost" : "post_to_wall"
    "keydown #message" : "displaycharlength"
    "click #signcard" : "submit_message"
  
  constructor: (options) ->
    super(options)
    @member = new Emoticard.Models.Member()
    @message = new Emoticard.Models.Message()
    @messageflag = 1
    @message.fetch(wait:true)
    
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
    @messagetext = $('#message').val()
    length = 200 - @messagetext.length
    if length < 0
      $("#charlength").html('<font style="color:red;">' + length + '</font>')
    else
      $("#charlength").html(length)
      
  submit_message: (e) ->
    e.stopPropagation()
    e.preventDefault()
    @message.save({ message: @$('#submit_message [name=message]').val(), wait:true },
      success: (message) =>
        $("div.resultSection").html('')
        $("div.fbSection").html('<div class="captionTxt" style="margin: 0px;margin-top: 31px;color: #E14022;font: 24px \'RobotoRegular\', Arial, sans-serif;"><b>Thank you ' + this.member.attributes.firstname  + '</b>,<br />We just put your message and your name on the birthday card we are making! Meanwhile get your friends to send in their wishes!</div>')
        @messageflag = 0  
      error: (message, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )
    
  render: ->

    @member.fetch(
      success: =>
        if @message.attributes.hasOwnProperty("message")
          @messageflag = 0
        $(@el).html(@template())
    )
    
    return this
