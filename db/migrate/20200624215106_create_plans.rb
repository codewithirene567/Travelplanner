class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name
      t.string :destination
      t.string :mode_of_transport
      t.date :date
      t.integer :user_id
    end
  end
end
