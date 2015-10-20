class AddFather < ActiveRecord::Migration
  def change
    change_table(:people) do |t|
      t.column :father_id, :int
  end
end
end
