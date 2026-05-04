class Api::V1::EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :update, :destroy]

  def index
    employees = Employee.all

    employees = employees.where(country: params[:country]) if params[:country].present?

    render json: employees.page(params[:page]).per(20)
  end

  def show
    render json: @employee
  end

  def create
    employee = Employee.new(employee_params)

    if employee.save
      render json: employee, status: :created
    else
      render json: { errors: employee.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @employee.update(employee_params)
      render json: @employee
    else
      render json: { errors: @employee.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @employee.destroy
    head :no_content
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(
      :first_name,
      :last_name,
      :email,
      :job_title,
      :country,
      :department,
      :salary,
      :currency,
      :hired_at
    )
  end
end
