class ApplicationController < ActionController::Base
  protect_from_forgery
  require 'twitter'
  require 'oauth'
  
  before_filter :get_tweets
  #client.friends_timeline.each  { |tweet| puts tweet.inspect }
  
  def get_tweets
      Twitter.configure do |config|
          config.consumer_key = "hizYaomd8nNSeRsWih8NQ"
          config.consumer_secret = "dp3OANVbltdqL3vGY3W1HyNbkCvN7F7se3Ltjopys"
          config.oauth_token = "15748151-qnwJRp8cEYFM0T39jKg3G7VJGWkWj2mMXWKYaFsPk"
          config.oauth_token_secret = "oSJbOmy9xIYsz9s3ISopJDfxbl6qHDbl4ZnvGRGNao"
      end
          #do something here
   end

end
