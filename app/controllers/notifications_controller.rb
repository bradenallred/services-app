class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications.order(created_at: :desc)
  end

  def mark_as_read
    @notification = Notification.find(params[:id])
    sender_id = @notification.message.user_id  # Accessing the sender's user ID
    sender = User.find(sender_id) 
    if @notification.update(read: true)
      redirect_to conversation_messages_path(sender)
    else
      redirect_to root_path, alert: 'Unable to mark notification as read'
    end
  end
end
