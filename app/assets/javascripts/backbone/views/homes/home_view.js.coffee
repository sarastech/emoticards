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
    @message_x = new Emoticard.Models.Message()
    @messageflag = 1
    @message.fetch(wait:true)
    @message_x.fetch(url: '/messages/count', async:false)

  count_fetch: () ->
    @message_x = new Emoticard.Models.Message() 
    @message_x.fetch(url: '/messages/count', async:false)
    $('div.countNo').html(900 + @message_x.attributes.count)
    
  change_dialogue: () -> 
    dialogues = ["En vazhi thani vazhi<br /><i style=\"font-size: 14px;\">My way is a unique way</i>","Naan oru dhadavai sonna, nooru dhadavai sonna madhiri<br /><i style=\"font-size: 14px;\">If I say it once, its equivalent to having said it a 100 times</i>","Andavan solran. Arunachalam seiran<br /><i style=\"font-size: 14px;\">God commands. I obey</i>","Kanna, panni dhan Kootama varum. Singam Singleaa dhaan varum<br /><i style=\"font-size: 14px;\">Only pigs come in herds. The lion always comes alone</i>","Nee virumburavalai kattikiruthai vida unnai virumburavalai kattikitta, un vazhkkai santhoshama irrukkum<br /><i style=\"font-size: 14px;\">You will be happier if you marry the one who loves you instead of the one you love</i>","Idhu epadi iruku?<br /><i style=\"font-size: 14px;\">How is this?</i>","Seeviduven...seevi<br /><i style=\"font-size: 14px;\">I will chop you into pieces!</i>","Naan late-aah vanthalum,latest-aah varuven<br /><i style=\"font-size: 14px;\">Even if I come late, I will be the latest!</i>","Kashtapadaama edhuvum kidaikaadhu. Kashtapadaama kedachu ennikum nilaikaadhu<br /><i style=\"font-size: 14px;\">You will gain nothing without hardwork. And even if you do, it wont last for long</i>","Katham, Katham. Mudinchathu mudinchu pottchu<br /><i style=\"font-size: 14px;\">Finished. Finished. Whats done is done!</i>",]
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
          link: 'http://wishrajini.com',
          picture: 'http://www.pardaphash.com/uploads/images/660/63734.jpg',
          name: 'I wished Rajinikanth for his birthday!',
          caption: '12-12-12',
          message: 'hi',
          description: 'I just signed the biggest birthday card made for Superstar Rajinikanth! Include your message and sign as well at http://wishrajini.com'
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
    setInterval(@count_fetch,30000)
    setInterval(@change_dialogue,10000)  
    return this
