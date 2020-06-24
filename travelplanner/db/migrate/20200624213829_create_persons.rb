class CreatePersons < ActiveRecord::Migration
  def change
    create_table :persons do |t|
      t.string :name
      t.string :username
      t.string :password_digest
      t.integer :num_of_plans
      t.integer :num_of_transport
      t.string :mode_of_transport
    end
  end
end
