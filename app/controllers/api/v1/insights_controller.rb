class Api::V1::InsightsController < ApplicationController
  def country
    result = Employee.group(:country)
                     .select(
                       :country,
                       'MIN(salary) as min_salary',
                       'MAX(salary) as max_salary',
                       'AVG(salary) as avg_salary',
                       'COUNT(*) as total_employees'
                     )

    render json: result
  end

  def job_titles
    result = Employee.group(:country, :job_title)
                     .select(
                       :country,
                       :job_title,
                       'AVG(salary) as avg_salary'
                     )

    render json: result
  end
end
