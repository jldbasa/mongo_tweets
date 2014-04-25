require 'spec_helper'

describe TweetsController do

  let!(:tweet) { FactoryGirl.create(:tweet, location: [29.36209198, 47.97968745]) }

  describe "GET 'index'" do
    before :each do
      get :index
    end

    it "assigns the requested tweets to @tweets" do
      expect(assigns(:tweets)).to eq Tweet.order(:created_at.desc).page(1).per(MongoTweets::Application.config.rpp)
    end

    it { should render_template(:index) }
  end

  describe "GET 'index' with params long, lat and distance" do
    before :each do
      get :index, long: 29.36209198, lat: 47.97968745, distance:10
    end

    it "assigns the requested tweets to @tweets" do
      expect(assigns(:tweets)).to eq Tweet.near([29.36209198, 47.97968745],
        10.fdiv(6371))
    end

    it { should render_template(:index) }
  end

end
