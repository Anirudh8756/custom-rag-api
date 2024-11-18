module Dashboard
    class UploadController < ApplicationController
      before_action :authenticate_user!

      def index

        render json: {
          user_files: fetch_file_names,
        }, status: :ok
      end

      def create
        if params[:upload].present? && params[:upload]
          category_id = params[:category_id]

          begin
            current_user.upload.attach(
              io: params[:upload].tempfile,
              filename: params[:upload].original_filename,
              content_type: params[:upload].content_type,
              metadata: { category_id: category_id }
            )

            render json: {
              message: "File uploaded successfully with category '#{category_id}'"
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
            category_id = params[:category_id]
            current_user.upload.purge
            current_user.upload.attach(
              io: params[:upload].tempfile,
              filename: params[:upload].original_filename,
              content_type: params[:upload].content_type,
              metadata: { category_id: category_id }
            )

            render json: {
              message: "Updated Successfully with category"
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
        attachment = current_user.upload.find(params[:id])
        attachment.purge
        render json: {
          message: "File Deleted Successfully"
        }
      end

      private

      def fetch_file_names
        if current_user.upload.attached?
          # Collect each file's data in an array
          current_user.upload_blobs.map do |upload|
            category_id =  upload.metadata["category_id"].to_i
            if category_id == 0
            else
              category = Category.find(category_id)
            end
            {
              file: upload.filename.to_s,
              file_category: category.try(:name)
            }
          end
        else
          []
        end
      end

    end
  end
