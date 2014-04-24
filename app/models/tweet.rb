class Tweet
  include Mongoid::Document
  field :screen_name, type: String
  field :text, type: String
  field :location, type: Array, default: []
  field :created_at, type: DateTime

  index({location: '2dsphere'}, background: true)
end
