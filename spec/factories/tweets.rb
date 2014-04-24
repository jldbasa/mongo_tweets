# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tweet do
    screen_name "@jldbasa"
    text "Test tweet"
    location [29.36209198, 47.97968745]
    created_at Time.now
  end
end
