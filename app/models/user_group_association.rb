# frozen_string_literal: true

class UserGroupAssociation < ApplicationRecord
  belongs_to :user
  belongs_to :group

  enum role: { organizer: 'Organizer', presenter: 'Presenter', participant: 'Participant' }
  validates :user_id, uniqueness: { scope: :group_id, message: 'User is already associated with this group' }
end
