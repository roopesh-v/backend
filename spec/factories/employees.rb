FactoryBot.define do
  factory :employee do
    first_name { "Roopesh" }
    last_name { "V" }
    sequence(:email) { |n| "employee#{n}@example.com" }
    job_title { "Software Engineer" }
    country { "India" }
    department { "Engineering" }
    salary { 180000 }
    currency { "INR" }
    hired_at { Date.today }
  end
end
