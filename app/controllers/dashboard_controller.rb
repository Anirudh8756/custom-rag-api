class DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    auth_token = Warden::JWTAuth::UserEncoder.new.call(current_user, :user, nil).first
    render json: {
      user_email: current_user.email,
      user_id: current_user.id,
      latest_user_files: fetch_latest_file_names,
      latest_chat_history: fetch_chat_history,
      latest_faq_chats: fetch_faq_history
    }
  end

  private

  def fetch_latest_file_names(limit = 3)
    latest_files = current_user.upload_blobs.order(created_at: :desc).limit(limit)
    latest_files.map(&:filename).map(&:to_s)
  end

  def fetch_chat_history(limit = 3)
    latest_chat = current_user.messages.order(created_at: :desc).limit(limit)
    latest_chat.map do |chat|
      { # Corrected: Wrapped in curly braces
        id: chat.id,
        content: chat.content,
        created_at: chat.created_at,
        creator: chat.user.email
      }
    end
  end

  def fetch_faq_history(limit = 3 )
    latest_faqs = current_user.faqs.order(created_at: :desc).limit(limit)
    latest_faqs.map do |faq|
      if faq.category_id.present?
        category = Category.find(faq.category_id)
      end
      {
        id: faq.id,
        question: faq.question,
        answer: faq.answer,
        user_id: faq.user_id,
        category: category
      }
    end
  end


end
