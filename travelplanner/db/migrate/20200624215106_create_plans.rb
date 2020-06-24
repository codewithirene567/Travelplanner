class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :destination
      t.string :mode_of_transport
      t.date :date
      t.integer :person_id
    end
  end
end
