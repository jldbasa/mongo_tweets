# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tweet do
    screen_name "MyString"
    text "MyText"
    location ""
  end
end
