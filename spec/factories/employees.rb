FactoryBot.define do
  factory :employee do
    first_name { "MyString" }
    last_name { "MyString" }
    email { "MyString" }
    job_title { "MyString" }
    country { "MyString" }
    department { "MyString" }
    salary { 1 }
    currency { "MyString" }
    hired_at { "2026-05-04" }
  end
end
