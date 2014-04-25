require 'tweetstream'

namespace :mongo_tweets do
  desc "Consume twitter data"
  task "consume_twitter_stream" => :environment do 

    puts "#{Time.now} - Starting task: mongo_tweets:consume_twitter_stream"

    TweetStream.configure do |config|
      config.consumer_key       = Figaro.env.consumer_key
      config.consumer_secret    = Figaro.env.consumer_secret
      config.oauth_token        = Figaro.env.oauth_token
      config.oauth_token_secret = Figaro.env.oauth_token_secret
      config.auth_method        = :oauth
    end

    client = TweetStream::Client.new

    client.on_error do |message|
      puts "Error: #{Time.now}"
      puts message
    end

    @statuses = []
    client.locations(-180,-90,180,90) do |status|

      @statuses << status
      client.stop if @statuses.size >= 10

    end

    @statuses.each do |status|
      if status.geo?

        @tweet = Tweet.new
        @tweet.screen_name = status.user.screen_name
        @tweet.text = status.text
        @tweet.location = status.geo.coordinates
        @tweet.created_at = status.created_at
        @tweet.hashtags = status.hashtags.map{|h| h.text} if status.hashtags?
        puts "Saved! #{@tweet.save}"

        puts "@#{status.user.screen_name}: #{status.text}"
        puts "created_at: #{status.created_at}\n\n"
        puts "loc: #{status.geo.coordinates}\n\n"
        puts "hashtags: #{@tweet.hashtags}\n\n"

      end
    end

    puts "#{Time.now} - Success!"
  end
end

