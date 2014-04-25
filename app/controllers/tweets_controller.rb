class TweetsController < ApplicationController

  def index



    if params[:long].present? && params[:lat].present? && params[:distance].present?

      @tweets = Tweet.order(:created_at.desc)
        .page(params[:page])
        .per(MongoTweets::Application.config.rpp)
        .geo_near([params[:long].to_f, params[:lat].to_f])
        .spherical
        .max_distance(params[:distance].to_f.fdiv(6371))

    else

      @tweets = Tweet.order(:created_at.desc)
        .page(params[:page])
        .per(MongoTweets::Application.config.rpp)

    end
  end

end
