class Emoticard.Models.Message extends Backbone.Model
  paramRoot: 'message'
  urlRoot: '/messages'

class Emoticard.Collections.MessagesCollection extends Backbone.Collection
  model: Emoticard.Models.Message
  url: '/messages'
