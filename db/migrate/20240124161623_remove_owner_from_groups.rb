# frozen_string_literal: true

class RemoveOwnerFromGroups < ActiveRecord::Migration[7.1]
  def change
    remove_reference :groups, :owner, null: false, foreign_key: true
  end
end
