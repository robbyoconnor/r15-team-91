FactoryGirl.define do
  factory :comparison do
    code { Digest::SHA256.new.to_s }
  end
end
