class UrlsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_url , only: %i[update destroy]


  def new
    @url = Url.new
  end

  def create
    @url = current_user.urls.build(set_url_params)
    if @url.save
      render json: {
        status: "200",
        message: "Database Configurations Information saved successfully",
        data: @url
      }, status: :ok
    else
      render json: {
        status: "422",
        message: "Database Configuration Information not saved successfully",
        cause: @url.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def update
    if @url.update(set_url_params)
      render json: {
        status: "200",
        message: "Database Configurations Information updated successfully",
        data: @url
      }, status: :ok
    else
      render json: {
        status: "422",
        message: "Database Configurations Information not updated successfully",
        cause: @url.errors.full_messages
      }, status: :unprocessable_entity
    end
  end



  def destroy
    if @url.destroy
      render json: {
        status: "200",
        message: "Database Configurations Information deleted successfully"
      },status: :ok
    else
      render json: {
        status: "422",
        message: "Database Configurations Information not deleted successfully",
        cause: @url.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  private
  def set_url
    @url = current_user.urls.find(params[:id])
  end

  def set_url_params
     params.require(:url).permit(:db_url , :api_key)
  end
end
