class MessagesController < ApplicationController
    before_action :authenticate_user!
    before_action :find_message, only: [:update, :destroy]
        def  index
            @message = current_user.messages.all
            render json: {
                messages: @message.map {|message| {content: message.content, creator: message.user.email, user_id: message.user.id}}
            }, status: :ok
        end

        def new
            @message = Message.new
        end

        def create
            @message =  current_user.messages.new(message_params)

            if @message.save
                    render json: {
                        "message_creator": @message.user.email,
                        "message": @message.content,
                        "user_id": @message.user.id
                    }, status: :ok
            else
                render json: {
                    error: "Message Could not be created"

                }, status: :unprocessable_entity
            end
        end

        def update
            if @message.update(message_params)
                render json: {
                    notice: "Message updated successfully"
                }, status: :ok
            else
                    render json: {
                        alert: "Message could not be Updated"
                    }, status: :unprocessable_entity
            end
        end
        def destroy
            if @message.destroy
                render json: {
                    notice: "message destroyed Succesfully"
                }, status: :ok
            else
                render json: {
                    alert: "Message could not be destroyed"
                }, status: :unprocessable_entity
            end
        end
    private
    def find_message
        @message = current_user.messages.find(params[:id])
    end
    def message_params
        params.require(:message).permit(:content)
    end
end
