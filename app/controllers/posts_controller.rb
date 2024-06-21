class PostsController < ApplicationController

	before_action :authenticate_user!, except: [:index, :show]
  before_action :just_user, only: [:edit, :update, :destroy]

	def index
		@posts = Post.all
	end

	def show
		@post = Post.find(params[:id])
	end

	def new
		@post = Post.new
		puts "session: #{session[:user_id]}"
	end

  def create
    puts "params: #{params}"
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

	def edit
		@post = Post.find(params[:id])
	end

  def update
    post = Post.find_by(id: params[:id])

    if post.update(post_params)
      redirect_to posts_path
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

	private

	def post_params
		params.require(:post).permit(:title, :content, :user_id, :answers_count)
	end

  def just_user
    post = Post.find(params[:id])
    unless current_user.id == post.user_id
      redirect_to posts_path, alert: 'You are not authorized to modify this post.'
    end
  end
end
