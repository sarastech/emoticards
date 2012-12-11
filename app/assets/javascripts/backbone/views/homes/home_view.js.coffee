Emoticard.Views.Homes ||= {}

class Emoticard.Views.Homes.HomeView extends Backbone.View
  template: JST["backbone/templates/homes/home"]
  
  events :
    #"click #fbwallpost" : "post_to_wall"
    "keydown #message" : "displaycharlength"
    "click #signcard" : "submit_message"
  
  constructor: (options) ->
    super(options)
    @member = new Emoticard.Models.Member()
    @message = new Emoticard.Models.Message()
    @message_s = new Emoticard.Models.Message()
    @messageflag = 1
    @message.fetch(wait:true)
    @message_s.fetch(url: '/messages/count', async:false)

  count_fetch: () ->
    @message_s = new Emoticard.Models.Message() 
    @message_s.fetch(url: '/messages/count', async:false)
    $('div.countNo').html(121 + @message_s.attributes.count)
    
  change_dialogue: () -> 
    dialogues = ["En vazhi thani vazhi","Naan oru dhadavai sonna, nooru dhadavai sonna madhiri","Andavan solran. Arunachalam seiran","Kanna, panni dhan Kootama varum. Singam Singleaa dhaan varum.","Nee virumburavalai kattikiruthai vida unnai virumburavalai kattikitta, un vazhkkai santhoshama irrukkum.","Idhu epadi iruku - How is it - Super ...","Seeviduven...seevi","Naan late-aah vanthalum,latest-aah varuven","Kashtapadaama edhuvum kidaikaadhu. Kashtapadaama kedachu ennikum nilaikaadhu","Katham, Katham. Mudinchathu mudinchu pottchu",]
    movie = ["Padayappa (1999) ","Baasha (1995) ","Arunachalam (1997) ","Sivaji (2007) ","Valli (1993) ","Veera (1994)", "Murattu Kaalai (1980)", "Baba (2002)" , "Baasha (1995)" , "Annamalai (1992)", "Baba (2002)"]
    min = 0
    max = 3
    rnd = min + Math.floor(Math.random() * (max - min + 1))
    $('.quote').html(dialogues[rnd])
    $('.filmName').html(movie[rnd])
    
  post_to_wall: () ->
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
    that = this
    @message.save({ message: @$('#submit_message [name=message]').val(), wait:true },
      success: (message) =>
        $("div.resultSection").html('')
        $("div.fbSection").html('<div class="captionTxt" style="margin: 0px;margin-top: 31px;color: #E14022;font: 24px \'RobotoRegular\', Arial, sans-serif;"><b>Thank you ' + this.member.attributes.firstname  + '</b>,<br />We just put your message and your name on the birthday card we are making! Meanwhile get your friends to send in their wishes!</div>')
        @messageflag = 0
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
    setInterval(@count_fetch,7000)
    setInterval(@change_dialogue,10000)  
    return this
