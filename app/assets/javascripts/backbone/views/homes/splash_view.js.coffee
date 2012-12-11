Emoticard.Views.Homes ||= {}

class Emoticard.Views.Homes.SplashView extends Backbone.View
  template: JST["backbone/templates/homes/splash"]
  
  constructor: (options) ->
    super(options)
    @message_s = new Emoticard.Models.Message()
    
  count_fetch: () ->
    @message_s = new Emoticard.Models.Message() 
    @message_s.fetch(async:false)
    $('.countNo').html(@message_s.attributes.count)
  
  change_dialogue: () -> 
    dialogues = ["En vazhi thani vazhi","Naan oru dhadavai sonna, nooru dhadavai sonna madhiri","Andavan solran. Arunachalam seiran","Kanna, panni dhan Kootama varum. Singam Singleaa dhaan varum.","Nee virumburavalai kattikiruthai vida unnai virumburavalai kattikitta, un vazhkkai santhoshama irrukkum.","Idhu epadi iruku - How is it - Super ...","Seeviduven...seevi","Naan late-aah vanthalum,latest-aah varuven","Kashtapadaama edhuvum kidaikaadhu. Kashtapadaama kedachu ennikum nilaikaadhu","Katham, Katham. Mudinchathu mudinchu pottchu",]
    movie = ["Padayappa (1999) ","Baasha (1995) ","Arunachalam (1997) ","Sivaji (2007) ","Valli (1993) ","Veera (1994)", "Murattu Kaalai (1980)", "Baba (2002)" , "Baasha (1995)" , "Annamalai (1992)", "Baba (2002)"]
    min = 0
    max = 3
    rnd = min + Math.floor(Math.random() * (max - min + 1))
    $('.quote').html(dialogues[rnd])
    $('.filmName').html(movie[rnd])
  
  render: ->
    $(@el).html(@template())
    setInterval(@count_fetch,7000)
    setInterval(@change_dialogue,10000)
    return this
