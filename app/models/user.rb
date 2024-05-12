# frozen_string_literal: true

class User < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :user_group_associations, dependent: :destroy
  has_many :groups, through: :user_group_associations

  def full_name
    "#{first_name} #{last_name}"
  end
end
