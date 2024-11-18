class CustomPromtController < ApplicationController
  before_action :authenticate_user!
  before_action :find_prompt, only: %i[update destroy]
  def new
    @custom_promt = CustomPromt.new
  end

  def create
    @custom_promt = current_user.build_custom_Promt(set_custom_promt_url)
    if @custom_promt.save
      render json: {
        status:"200",
        message: "Custom Prompt Saved",
        data: @custom_promt
      }, status: :ok
    else
      render json: {
        status: "422",
        message: "Custom Prompt could not be created"

      }, status: :unprocessable_entity
    end
  end

  def update
     if @prompt.update(set_custom_promt_url)
        render json: {
          status: "200",
          message:"Prompt Updated Succesfully",
          data: @prompt
        }, status: :ok
      else
        render json: {
          status: "422",
          message: "Prompt could not be updated Successfully"
        }, status: :unprocessable_entity
      end
  end


  def destroy
    if @prompt&.destroy
        render json: {
          code: "200",
          message: "Custom Prompt deleted successfully",

        }, status: :ok
    else
      render json: {
        code: "422",
        message: "Custom Prompt could not be deleted successfully"
      }, status: :unprocessable_entity
    end
  end

  private
  def set_custom_promt_url
    params.require(:custom_Promt).permit(:template)
  end

  def find_prompt
    @prompt = current_user.custom_Promt
  end
end
