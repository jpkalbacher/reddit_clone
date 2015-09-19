class PostsController < ApplicationController
  before_action :block_logged_out_user, only: [:edit, :create, :new]

  def new
    @post = Post.new
    @sub = Sub.find(params[:sub_id])
    @subs = Sub.all - [@sub]
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.sub_id = params[:sub_id]

    ActiveRecord::Base.transaction do
      if @post.save
        params[:post][:cross_post].each do |sub_id|
          CrossPost.create!(post_id: @post.id, sub_id: sub_id)
        end
        redirect_to sub_url(@post.sub_id)
      else
        flash[:notice] = ["failed to create post"]
        redirect_to new_sub_post_url(@post.sub)
      end
    end
  end

  def destroy
  end

  def update
    @post = Post.find(params[:id])
    @old_cross_posts = @post.cross_posts

    ActiveRecord::Base.transaction do
      if @post.save
        @old_cross_posts.each(&:destroy!)
        params[:post][:cross_post].each do |sub_id|
          CrossPost.create!(post_id: @post.id, sub_id: sub_id)
        end
        redirect_to sub_url(@post.sub_id)
      else
        flash[:notice] = ["failed to update post"]
        redirect_to new_sub_post_url(@post.sub)
      end
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
    @sub = @post.sub
    @subs = Sub.all - [@sub]

  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content)
  end
end
