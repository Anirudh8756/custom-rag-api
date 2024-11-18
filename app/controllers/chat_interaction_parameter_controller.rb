class ChatInteractionParameterController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat_param, only: [:update, :destroy]

  # GET /dashboard/chat_interaction_parameters/new
  def new
    @chat_param = ChatInteractionParameter.new
  end

  # POST /dashboard/chat_interaction_parameters
  def create
    @chat_param = current_user.build_chat_interaction_parameter(chat_param_params)
    if @chat_param.save
      render json: {
        status: "200",
        message: "Chat Parameters Set Successfully",
        data: @chat_param
      }, status: :ok
    else
      render json: {
        status: "422",
        message: "Chat Parameters could not be set successfully",
        data: @chat_param.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  # PUT/PATCH /dashboard/chat_interaction_parameters/:id
  def update
    if @chat_param.update(chat_param_params)
      render json: {
        code: "200",
        message: "Chat Params updated successfully",
        data: @chat_param
      }, status: :ok
    else
      render json: {
        code: "422",
        message: "Chat Params could not be updated successfully",
        cause: @chat_param.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  # DELETE /dashboard/chat_interaction_parameters/:id
  def destroy
    if @chat_param.destroy
      render json: {
        code: "200",
        message: "Deleted Successfully"
      }, status: :ok
    else
      render json: {
        code: "422",
        message: "Could not be deleted successfully",
        error: @chat_param.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  private

  # Set chat interaction parameter for update and destroy actions
  def set_chat_param
    @chat_param = current_user.chat_interaction_parameter
    render json: { message: 'Chat Interaction Parameter not found' }, status: :not_found if @chat_param.nil?
  end

  # Strong parameters for creating and updating
  def chat_param_params
    params.require(:chat_interaction_parameter).permit(:max_token, :temp, :logging)
  end
end
