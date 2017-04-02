FactoryGirl.define do

  factory :product do
    name { Faker::Commerce.department }
    category { Faker::Commerce.department }
    price { 400 }
    sale_price { 400 }
  end

end