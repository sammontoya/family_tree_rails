class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.column :given_name, :string
      t.column :family_name, :string
    end
  end
end
