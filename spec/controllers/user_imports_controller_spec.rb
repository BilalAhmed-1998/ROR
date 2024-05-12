# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserImportsController, type: :controller do
  describe 'POST #import_users' do
    let(:valid_csv_file) { fixture_file_upload('valid_csv_file.csv', 'text/csv') }
    let(:invalid_csv_file) { fixture_file_upload('invalid_csv_file.csv', 'text/csv') }

    it 'imports users from a valid CSV file' do
      expect do
        post :import_users, params: { csv_file: valid_csv_file }
      end.to change(User, :count).by(5)
    end

    it 'does not import users from an invalid CSV file' do
      expect do
        post :import_users, params: { csv_file: invalid_csv_file }
      end.not_to change(User, :count)
    end

    it 'handles missing CSV file' do
      expect do
        post :import_users
      end.not_to change(User, :count)
    end
  end
end
