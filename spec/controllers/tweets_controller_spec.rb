require 'spec_helper'

describe TweetsController do

  let!(:tweet) { FactoryGirl.create(:tweet) }

  describe "GET 'index'" do
    before :each do
      get :index
    end

    it "assigns the requested tweets to @tweets" do
      expect(assigns(:tweets)).to eq Tweet.order(:created_at.desc).page(1).per(MongoTweets::Application.config.rpp)
    end

    it { should render_template(:index) }
  end

end
