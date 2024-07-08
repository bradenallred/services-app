class MessagesController < ApplicationController
    before_action :authenticate_user!
  
    def index
      @messages = Message.where(sender_id: current_user.id).or(Message.where(receiver_id: current_user.id))
    end
  
    def new
      @message = Message.new
      @receiver = User.find(params[:receiver_id])
    end
  
    def create
      @message = current_user.sent_messages.new(message_params)
      if @message.save
        redirect_to messages_path, notice: 'Message sent successfully.'
      else
        render :new, alert: 'Failed to send message.'
      end
    end
  
    private
  
    def message_params
      params.require(:message).permit(:content, :receiver_id)
    end
  end
