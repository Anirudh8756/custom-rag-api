class DashboardController < ApplicationController
    before_action :authenticate_user!
  
    def index 
        auth_token = Warden::JWTAuth::UserEncoder.new.call(
            current_user, :user, nil
          ).first 
        latest_files = current_user.upload_blobs.order(created_at: :DESC).limit(5)
        file_names = []
        if latest_files.present? 
          latest_files.each do |latest_file|
            file_names << latest_file.filename.to_s
          end
        else 
          
        end

      render json: {
        user_email: current_user.email,
        user_id: current_user.id,
        user_files: file_names
      }
     
    end
    private
    
  end
  