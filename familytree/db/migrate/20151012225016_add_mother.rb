class AddMother < ActiveRecord::Migration
  def change
    change_table(:people) do |t|
      t.column :mother_id, :int
  end
end
end
