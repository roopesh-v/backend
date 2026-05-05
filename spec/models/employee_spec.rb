require 'rails_helper'

RSpec.describe Employee, type: :model do
  it "is valid with valid attributes" do
    employee = build(:employee)

    expect(employee).to be_valid
  end

  it "is invalid without email" do
    employee = build(:employee, email: nil)

    expect(employee).not_to be_valid
    end
end
