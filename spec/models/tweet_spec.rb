require 'spec_helper'

describe Tweet do

  it "has a valid factory" do
    expect(FactoryGirl.build(:tweet)).to be_valid
  end

  it { should validate_presence_of(:screen_name) }
  it { should validate_presence_of(:text) }
  it { should validate_presence_of(:location) }
  it { should validate_presence_of(:created_at) }

end
