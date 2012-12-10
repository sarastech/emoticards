class Emoticard.Models.Member extends Backbone.Model
  paramRoot: 'member'

class Emoticard.Collections.MembersCollection extends Backbone.Collection
  model: Emoticard.Models.Member
  url: '/members'
