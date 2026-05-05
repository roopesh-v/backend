# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
records = []

10000.times do
  records << {
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.unique.email,
    job_title: Faker::Job.title,
    country: Faker::Address.country,
    department: ['Engineering', 'Finance', 'HR'].sample,
    salary: rand(50000..300000),
    currency: 'INR',
    hired_at: Faker::Date.backward(days: 1000),
    created_at: Time.current,
    updated_at: Time.current
  }
end

Employee.insert_all(records)

puts "Seeded #{Employee.count} employees"