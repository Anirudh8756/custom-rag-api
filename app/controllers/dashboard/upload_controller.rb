class Dashboard::UploadController < ApplicationController
    before_action :authenticate_user!

    def create 
        if params[:upload].present? 
            begin 
                current_user.upload.attach(params[:upload])
                render json: {
                    message: "File Uploaded Successfully",
                }, status: :created 
            rescue => e  
                    render json: {
                        message: "File failed to Upload",
                        error: e.message
                    }, status: :unprocessable_entity
            end
        else  
            render json: {
                message: "No File Provided",
            }, status: :unprocessable_entity
        end
    end 
    
    def destroy 
        attachment = current_user.upload.find(params[:id])
        attachment.purge
        render json: {
            message: "File Deleted Successfully"
        }
    end 

end
