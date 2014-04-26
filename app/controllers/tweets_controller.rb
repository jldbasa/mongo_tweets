class TweetsController < ApplicationController

  def index



    if params[:long].present? && params[:lat].present? && params[:distance].present?

      # geo_near call has issue with kaminari. undefined method `current_page'
      # for #<Mongoid::Contextual::GeoNear
      #@tweets = Tweet.order(:created_at.desc)
        #.page(params[:page])
        #.per(MongoTweets::Application.config.rpp)
        #.geo_near([params[:long].to_f, params[:lat].to_f])
        #.spherical
        #.max_distance(params[:distance].to_f.fdiv(6371))

      # temporary workaround with the above problem
      @tweets = Tweet.near([params[:long].to_f, params[:lat].to_f],
        params[:distance],
        params[:page],
        hashtags: params[:hashtag])

    else

      @tweets = Tweet.order(:created_at.desc)
        .page(params[:page])
        .per(MongoTweets::Application.config.rpp)

    end
  end

end
