Emoticard.Views.Homes ||= {}

class Emoticard.Views.Homes.SplashView extends Backbone.View
  template: JST["backbone/templates/homes/splash"]
  
  constructor: (options) ->
    super(options)
    @message_s = new Emoticard.Models.Message()
    @message_s.fetch(url: '/messages/count', async:false)
    
  count_fetch: () ->
    @message_s = new Emoticard.Models.Message() 
    @message_s.fetch(url: '/messages/count', async:false)
    $('.countNo').html(121 + @message_s.attributes.count)
  
  change_dialogue: () -> 
    dialogues = ["En vazhi thani vazhi<br /><i style=\"font-size: 14px;\">My way is a unique way</i>","Naan oru dhadavai sonna, nooru dhadavai sonna madhiri<br /><i style=\"font-size: 14px;\">If I say it once, its equivalent to having said it a 100 times</i>","Andavan solran. Arunachalam seiran<br /><i style=\"font-size: 14px;\">God commands. I obey</i>","Kanna, panni dhan Kootama varum. Singam Singleaa dhaan varum<br /><i style=\"font-size: 14px;\">Only pigs come in herds. The lion always comes alone</i>","Nee virumburavalai kattikiruthai vida unnai virumburavalai kattikitta, un vazhkkai santhoshama irrukkum<br /><i style=\"font-size: 14px;\">You will be happier if you marry the one who loves you instead of the one you love</i>","Idhu epadi iruku?<br /><i style=\"font-size: 14px;\">How is this?</i>","Seeviduven...seevi<br /><i style=\"font-size: 14px;\">I will chop you into pieces!</i>","Naan late-aah vanthalum,latest-aah varuven<br /><i style=\"font-size: 14px;\">Even if I come late, I will be the latest!</i>","Kashtapadaama edhuvum kidaikaadhu. Kashtapadaama kedachu ennikum nilaikaadhu<br /><i style=\"font-size: 14px;\">You will gain nothing without hardwork. And even if you do, it wont last for long</i>","Katham, Katham. Mudinchathu mudinchu pottchu<br /><i style=\"font-size: 14px;\">Finished. Finished. Whats done is done!</i>",]
    movie = ["Padayappa (1999) ","Baasha (1995) ","Arunachalam (1997) ","Sivaji (2007) ","Valli (1993) ","Veera (1994)", "Murattu Kaalai (1980)", "Baba (2002)" , "Baasha (1995)" , "Annamalai (1992)", "Baba (2002)"]
    min = 0
    max = 3
    rnd = min + Math.floor(Math.random() * (max - min + 1))
    $('.quote').html(dialogues[rnd])
    $('.filmName').html(movie[rnd])
  
  render: ->
    $(@el).html(@template())
    @count_fetch
    setInterval(@count_fetch,30000)
    setInterval(@change_dialogue,10000)
    return this
