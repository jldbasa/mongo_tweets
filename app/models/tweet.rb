class Tweet
  include Mongoid::Document
  field :screen_name, type: String
  field :text, type: String
  field :location, type: Array, default: []
  field :created_at, type: DateTime

  index({location: '2dsphere'}, background: true)

  validates_presence_of :screen_name
  validates_presence_of :text
  validates_presence_of :location
  validates_presence_of :created_at
end
