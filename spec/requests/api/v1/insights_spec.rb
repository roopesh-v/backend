require 'rails_helper'

RSpec.describe "Api::V1::Insights", type: :request do
  describe "GET /country" do
    before do
      create(:employee, country: "India", salary: 100000)
      create(:employee, country: "India", salary: 200000)
    end

    it "returns salary insights by country" do
      get "/api/v1/insights/country"

      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)

      india = json.find { |e| e["country"] == "India" }

      expect(india["min_salary"].to_i).to eq(100000)
      expect(india["max_salary"].to_i).to eq(200000)
    end
  end

  describe "GET /job_titles" do
    before do
      create(
        :employee,
        country: "India",
        job_title: "Backend Engineer",
        salary: 100000
      )

      create(
        :employee,
        country: "India",
        job_title: "Backend Engineer",
        salary: 200000
      )

      create(
        :employee,
        country: "USA",
        job_title: "Backend Engineer",
        salary: 300000
      )
    end

    it "returns average salary by country and job title" do
      get "/api/v1/insights/job_titles"

      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)

      india_backend = json.find do |e|
        e["country"] == "India" &&
          e["job_title"] == "Backend Engineer"
      end

      expect(india_backend["avg_salary"].to_f).to eq(150000.0)
    end
  end
end
