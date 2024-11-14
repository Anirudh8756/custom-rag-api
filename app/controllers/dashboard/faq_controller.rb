module Dashboard
  class FaqController < ApplicationController
    before_action :authenticate_user!
    before_action :find_faq, only: [:destroy, :update]

      def index
        @faqs = current_user.faqs.all
        render json: {
          user_faqs: @faqs
        }
      end


      def new
        @faq = Faq.new
      end


      def create
        @faq =  current_user.faqs.build(faq_params)
        if @faq.save
          render json: {
            Message: "Faq created successfully",
            faq: @faq,
            user_id: @faq.user_id
          }, status: :ok
        else
          render json: {
            Message: "Faq could not be created",
            error: @faq.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      def update
        if @faq.update(faq_params)
          render json: {
            Message: "Faq Updates Successfully",
          }, status: :ok
        else
          render json: {
            Message: "Faq could not be updated Successfully",
          }, status: :unprocessable_entity
        end
      end


      def destroy
        if @faq.destroy
          render json: {
            Message:"Faq Destroyed Successfully",
          }, status: :ok
        else
          render json: {
            Message: "Faq could not be destroyed",
          }, status: :unprocessable_entity
        end
      end


      private
      def faq_params
        params.require(:faq).permit(:question, :answer ,:category_id)
      end
      def find_faq
        @faq = current_user.faqs.find(params[:id])
      end
  end
end
