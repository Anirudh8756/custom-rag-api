module Dashboard
    class UploadController < ApplicationController
      before_action :authenticate_user!

      def index
        render json: {
          user_files: fetch_file_names
        }, status: :ok
      end

      def create
        if params[:upload].present?
          begin
            current_user.upload.attach(params[:upload])
            render json: {
              message: "File Uploaded Successfully"
            }, status: :created
          rescue => e
            render json: {
              message: "File failed to upload",
              error: e.message
            }, status: :unprocessable_entity
          end
        else
          render json: {
            message: "No File Provided"
          }, status: :unprocessable_entity
        end
      end

      def update  
        if current_user.upload.attached?
            if params[:upload]
              current_user.upload.purge
              current_user.upload.attach(params[:upload])

              render json: {
                message: "Updated Successfully"
              }, status: :ok
            else
              render json: {
                message: "No file found"
              }, status: :unprocessable_entity
            end


        end
      end

      def destroy
        attachment = current_user.upload.find(params[:id]) # Assuming 'upload' is an association
        attachment.purge
        render json: {
          message: "File Deleted Successfully"
        }
      end

      private

      def fetch_file_names
        if current_user.upload.attached?
        current_user.upload_blobs.map(&:filename) # Collects all filenames in an array
        else
          []
        end
      end
    end
  end
