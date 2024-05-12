# frozen_string_literal: true

class CsvImportService
  def initialize(file_path)
    @file_path = file_path
  end

  def import_users
    CSV.foreach(@file_path, headers: true) do |row|
      user = User.create(first_name: row['First Name'], last_name: row['Last Name'])
      group = Group.find_or_create_by(name: row['Group Name'])
      role = row['Role']

      if user && group && UserGroupAssociation.roles.key?(role.downcase)
        UserGroupAssociation.find_or_create_by(user:, group:, role: role.downcase)
      end
    end
  end
end
