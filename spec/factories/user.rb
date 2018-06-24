FactoryBot.define do
    factory :user do
        name { Faker::Name.name }
        emai "example@example.com"
        password "foobar"
    end
end
