# frozen_string_literal: true

class Group < ApplicationRecord
  validates :name, presence: true

  has_many :user_group_associations, dependent: :destroy
  has_many :users, through: :user_group_associations

  # scope :organizers, -> { joins(:user_group_associations).where(user_group_associations: { role: 'organizer' }) }

  def organizers
    user_group_associations.where(group_id: id, role: 'organizer')
  end

  def presenters
    user_group_associations.where(group_id: id, role: 'presenter')
  end

  def participants
    user_group_associations.where(group_id: id, role: 'participant')
  end

  def update_user_role(user, role)
    user_group_association = user_group_associations.find_by(user:)
    if user_group_association
      user_group_association.update(role:)
      'User role updated successfully.'
    else
      'User is not associated with this group.'
    end
  end

  def add_user_to_group(user)
    users << user unless users.include?(user)
  end
end
