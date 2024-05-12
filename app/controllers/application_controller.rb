# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from StandardError, with: :handle_standard_error

  private

  def record_not_found(exception)
    flash[:alert] = "Record not found: #{exception.message}"
    redirect_to root_path
  end

  def handle_standard_error(exception)
    flash[:alert] = "An error occurred: #{exception.message}"
    redirect_to root_path
  end
end
