class AppointmentsController < ApplicationController
  def index
    @appointments = current_user.appointments.includes(:post)
    @post_appointments = Appointment.includes(:post).where(posts: { user_id: current_user.id }).references(:posts)
  end

  def create
    @post = Post.find(params[:post_id])
    @appointment = @post.appointments.new(appointment_params)
    @appointment.user = current_user

    if @appointment.save
      redirect_to @post, notice: 'Appointment scheduled successfully.'
    else
      redirect_to @post, alert: 'Failed to schedule appointment.'
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit(:date, :time, :notes)
  end
end