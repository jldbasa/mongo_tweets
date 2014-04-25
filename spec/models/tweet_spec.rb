require 'spec_helper'

describe Tweet do

  let(:tweet_1){ FactoryGirl.create(:tweet, screen_name: "@jldbasa",
      text: "Test tweet 1",
      location: [29.36209198, 47.97968745],
      created_at: Time.now)}

  let(:tweet_2){ FactoryGirl.create(:tweet, screen_name: "@jldbasa",
      text: "Test tweet 2",
      location: [29.36209198, 47.97968745],
      created_at: Time.now + 1.hour)}

  it "has a valid factory" do
    expect(FactoryGirl.build(:tweet)).to be_valid
  end

  it { should validate_presence_of(:screen_name) }
  it { should validate_presence_of(:text) }
  it { should validate_presence_of(:location) }
  it { should validate_presence_of(:created_at) }

  it "returns a sorted array of results that match" do
    tweet_1
    tweet_2
    @tweets = Tweet.near([29.36209198, 47.97968745], 10)
    expect(@tweets).to eq [tweet_2, tweet_1]
  end
end
