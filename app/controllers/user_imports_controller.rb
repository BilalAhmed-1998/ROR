# frozen_string_literal: true

class UserImportsController < ApplicationController
  def import_users
    handle_csv_upload
  rescue StandardError
    flash[:alert] = 'Please upload a valid CSV file.'
    redirect_to root_path
  end

  private

  def handle_csv_upload
    return no_csv_selected unless params[:csv_file].present?
    return invalid_csv_file unless valid_csv_file?

    CsvImportService.new(params[:csv_file].path).import_users
    redirect_to root_path, notice: 'Users imported successfully.'
  end

  def no_csv_selected
    flash[:alert] = 'Please select a CSV file to import users.'
    redirect_to root_path
  end

  def invalid_csv_file
    flash[:alert] = 'Please upload a valid CSV file.'
    redirect_to root_path
  end

  def valid_csv_file?
    params[:csv_file].content_type.in?(['text/csv', 'application/csv'])
  end
end
