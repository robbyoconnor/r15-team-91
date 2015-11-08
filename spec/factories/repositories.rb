FactoryGirl.define do
  factory :repository do
    sequence(:owner) { |n| "owner#{n}" }
    sequence(:name) { |n| "name#{n}" }
  end
end
