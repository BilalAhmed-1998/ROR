# frozen_string_literal: true

module GroupsHelper
  def user_current_role_class(user, target_role)
    colors = { 'organizer' => 'success', 'presenter' => 'warning', 'participant' => 'primary' }
    user_association = user.user_group_associations.find_by(group: @group)
    current_role = user_association&.role
    color_class = colors[target_role] || 'secondary'

    "btn btn-outline-#{color_class} btn-sm mr-1#{current_role == target_role ? ' active' : ''}"
  end
end
