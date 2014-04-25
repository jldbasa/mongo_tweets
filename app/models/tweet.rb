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

  def self.near(near, distance, page=nil)
    page = page || 1
    per_page = MongoTweets::Application.config.rpp

    pipeline = [

      {
        "$geoNear" => {
          "near" => near,
          "distanceField" => "dist.calculated",
          "maxDistance" => distance,
          "spherical" => true,
        }
      },
      { "$sort" =>  { "created_at" => -1 } },
    ]

    count = collection.aggregate(pipeline).count

    if page && per_page
      pipeline << { '$skip' => ((page.to_i - 1) * per_page) }
      pipeline << { '$limit' => per_page }
    end

    tweets_hash = collection.aggregate(pipeline)
    ids = tweets_hash.map{|e| e['_id'].to_s}
    tweets = self.any_in(_id: ids).order([:created_at, :desc])

    tweets.instance_eval <<-EVAL
      def current_page
        #{ page }
      end
      def total_pages
        #{ count.modulo(per_page).zero? ? (count / per_page) : ((count / per_page) + 1)}
      end
      def limit_value
        #{ per_page }
      end
    EVAL

    tweets
  end
end
