class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :fbuid
      t.date :dob
      t.string :gender
      t.string :location

      t.timestamps
    end
  end
end
