class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :member_id
      t.text :message

      t.timestamps
    end
  end
end
