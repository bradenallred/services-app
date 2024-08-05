class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications.order(created_at: :desc)
  end

  def mark_as_read
    @notification = Notification.find(params[:id])
    if @notification.update(read: true)
      redirect_to conversation_path(@notification.message.conversation)
    else
      redirect_to root_path, alert: 'Unable to mark notification as read'
    end
  end
end
