require 'rails_helper'

RSpec.describe "Api::V1::Employees", type: :request do
  describe "GET /index" do
    before do
      create_list(:employee, 3)
    end

    it "returns all employees" do
      get "/api/v1/employees"

      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)

      expect(json.length).to eq(3)
    end
  end

  describe "GET /show" do
    let(:employee) { create(:employee) }

    it "returns employee details" do
      get "/api/v1/employees/#{employee.id}"

      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)

      expect(json["email"]).to eq(employee.email)
    end
  end

  describe "POST /create" do
    let(:valid_params) do
      {
        employee: {
          first_name: "John",
          last_name: "Doe",
          email: "john@example.com",
          job_title: "Developer",
          country: "India",
          department: "Engineering",
          salary: 150000,
          currency: "INR",
          hired_at: Date.today
        }
      }
    end

    it "creates a new employee" do
      expect {
        post "/api/v1/employees", params: valid_params
      }.to change(Employee, :count).by(1)

      expect(response).to have_http_status(:created)

      json = JSON.parse(response.body)

      expect(json["email"]).to eq("john@example.com")
    end

    it "returns validation errors" do
      invalid_params = {
        employee: {
          first_name: "",
          email: ""
        }
      }

      post "/api/v1/employees", params: invalid_params

      expect(response).to have_http_status(:unprocessable_content)

      json = JSON.parse(response.body)

      expect(json["errors"]).to be_present
    end
  end

  describe "PATCH /update" do
    let(:employee) { create(:employee) }

    it "updates employee" do
      patch "/api/v1/employees/#{employee.id}",
            params: {
              employee: {
                salary: 200000
              }
            }

      expect(response).to have_http_status(:ok)

      employee.reload

      expect(employee.salary).to eq(200000)
    end
  end

  describe "DELETE /destroy" do
    let!(:employee) { create(:employee) }

    it "deletes employee" do
      expect {
        delete "/api/v1/employees/#{employee.id}"
      }.to change(Employee, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end

end
