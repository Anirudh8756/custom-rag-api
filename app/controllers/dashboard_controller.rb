class DashboardController < ApplicationController
    before_action :authenticate_user!
  
    def index 
        auth_token = Warden::JWTAuth::UserEncoder.new.call(
            current_user, :user, nil
          ).first
      render json: {
        user_email: current_user.email,
        user_id: current_user.id,
        authentication_token: auth_token
      }
    end
    private
    
  end
  