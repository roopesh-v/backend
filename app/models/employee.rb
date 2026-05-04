class Employee < ApplicationRecord
  validates :first_name,
            :last_name,
            :email,
            :job_title,
            :country,
            :salary,
            presence: true

  validates :email, uniqueness: true
end
