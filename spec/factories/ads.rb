FactoryBot.define do
  factory :ad do
    title { "Ad title" }
    description { "Ad description" }
    city { "City 1" }
    user_id { 5 }
  end
end
