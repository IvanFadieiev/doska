# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    poster "MyString"
    body "MyText"
    user nil
  end
end
