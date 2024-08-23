class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: %i[show edit update destroy]
  before_action :authorize_business_user, only: [:new, :create, :edit, :update, :destroy]

  # GET /posts or /posts.json
  def index
    @posts = Post.all

    @posts_by_category = Post.all.group_by(&:category)

    if params[:search].present?
      @posts = Post.where("job_title LIKE ? OR job_description LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
      @searching = true
      @filtering_by_category = false
      @selected_category = nil
    elsif params[:category].present?
      @posts = Post.where(category: params[:category])
      @searching = false
      @filtering_by_category = true
      @selected_category = params[:category]
    else
      @filtering_by_category = false
      @selected_category = nil
      @searching = false
      @posts_by_category = @posts.group_by(&:category)
    end

    if params[:category].present?
      @posts = @posts.where(category: params[:category])
    end
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.find(params[:id])
    @review = Review.new 
    @reviews = @post.reviews.includes(:user) 
    @appointment = Appointment.new(post: @post)
  end

  # GET /posts/new
  def new
    @post = current_user.posts.build
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def create_appointment
    @post = Post.find(params[:post_id])
    @appointment = @post.appointments.new(appointment_params)
    @appointment.user = current_user
  
    if @appointment.save
      redirect_to post_appointments_path(@post), notice: 'Appointment scheduled successfully.'
    else
      render :new
    end
  end

  private

    def appointment_params
      params.require(:appointment).permit(:date, :time, :notes)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:job_title, :job_description, :user_id, :category, images: [])
    end

    def authorize_business_user
      redirect_to(root_path, alert: "You are not authorized to perform this action.") unless current_user.account_type == 'business'
    end
end
