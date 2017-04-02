class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound do |ex|
    render_not_found(ex.model)
  end

  private

  def render_not_found(document_name)
    render json: { errors: [{ message: "#{document_name} not found" }] }, status: :not_found
  end
end
