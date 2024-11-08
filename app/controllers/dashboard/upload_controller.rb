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
          category = params[:category] # Retrieve the category from params

          begin
            current_user.upload.attach(
              io: params[:upload].tempfile,
              filename: params[:upload].original_filename,
              content_type: params[:upload].content_type,
              metadata: { category: category }
            )

            render json: {
              message: "File uploaded successfully with category '#{category}'"
            }, status: :created
          rescue => e
            render json: {
              message: "File failed to upload",
              error: e.message
            }, status: :unprocessable_entity
          end
        else
          render json: {
            message: "File and category are required"
          }, status: :unprocessable_entity
        end
      end


      def update
        if current_user.upload.attached?
          if params[:upload]
            category = params[:category] # Retrieve the category from params

            # Purge the old file
            current_user.upload.purge

            # Attach the new file with category metadata
            current_user.upload.attach(
              io: params[:upload].tempfile,
              filename: params[:upload].original_filename,
              content_type: params[:upload].content_type,
              metadata: { category: category }
            )

            render json: {
              message: "Updated Successfully with category '#{category}'"
            }, status: :ok
          else
            render json: {
              message: "No file found"
            }, status: :unprocessable_entity
          end
        else
          render json: {
            message: "No existing upload to update"
          }, status: :not_found
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
