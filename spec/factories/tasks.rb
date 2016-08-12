FactoryGirl.define do
  factory :task do
    user
    name { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph  }
    state { %w(new started).sample }
  end
end
