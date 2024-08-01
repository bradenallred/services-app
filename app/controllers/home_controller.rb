class HomeController < ApplicationController
  def index
  end

  def analytics
  end

  def account
    @posts = Post.all
  end
end
