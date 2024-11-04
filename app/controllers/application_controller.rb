class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  before_action :get_custom_header_in_variables

  def current_user_data
    return User.where("id = ? and authentication_token = ?", @user_id, @user_authentication_token).try(:first)
  end

  private
  def get_custom_header_in_variables
    if request.headers['X-User-Id']
      @user_id = request.headers['X-User-Id']
      @user_email = request.headers['X-User-Email']
      @user_authentication_token = request.headers['X-User-Token']
    end
  end
end
