class CreateEmployees < ActiveRecord::Migration[7.1]
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :job_title
      t.string :country
      t.string :department
      t.integer :salary
      t.string :currency
      t.date :hired_at

      t.timestamps
    end

    add_index :employees, :email, unique: true
    add_index :employees, :country
    add_index :employees, :job_title
    add_index :employees, [:country, :job_title]
  end
end
