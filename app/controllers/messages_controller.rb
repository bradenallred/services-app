class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    # Get unique users the current user has messaged or received messages from
    @users = User.joins("INNER JOIN messages ON users.id = messages.user_id OR users.id = messages.receiver_id")
                 .where("messages.user_id = ? OR messages.receiver_id = ?", current_user.id, current_user.id)
                 .distinct
  end

  def new
    @receiver = User.find(params[:user_id])
    @message = Message.new(receiver: @receiver)
  end

  def conversation
    @receiver = User.find(params[:user_id])
    @messages = Message.where("(user_id = ? AND receiver_id = ?) OR (user_id = ? AND receiver_id = ?)", 
                              current_user.id, @receiver.id, @receiver.id, current_user.id).order(created_at: :asc)
    @new_message = Message.new
  end

  def create
    @message = current_user.sent_messages.build(message_params)
    if @message.save
      redirect_to conversation_messages_path(@message.receiver_id), notice: "Message sent!"
    else
      render :conversation
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :receiver_id)
  end
end