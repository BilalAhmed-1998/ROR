# frozen_string_literal: true

class CreateUserGroupAssociations < ActiveRecord::Migration[7.1]
  def change
    create_table :user_group_associations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true
      t.string :role

      t.timestamps
    end
    add_index :user_group_associations, %i[user_id group_id], unique: true
  end
end
