class SubsController < ApplicationController

  before_action :enforce_moderation, only: :edit
  before_action :block_logged_out_user, only: [:edit, :create, :new]

  def new
    @sub = Sub.new
    @subs = Sub.all
  end

  def create
    @sub = current_user.subs.new(subs_params)
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash[:notice] = @sub.errors.full_messages
      redirect_to new_sub_url
    end
  end

  def edit
    @sub = Sub.find(params[:id])
    @subs = Sub.all
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update(subs_params)
      redirect_to sub_url(@sub)
    else
      flash[:notice] = @sub.errors.full_messages
    end
  end

  def index
    @subs = Sub.all
  end

  def show
    @sub = Sub.find(params[:id])
  end

  private
  def subs_params
    params.require(:sub).permit(:title, :description)
  end

  def enforce_moderation
    @sub = Sub.find(params[:id])

    unless current_user && (@sub.moderator_id == current_user.id)
      flash[:notice] = ["You are not allowed to edit this sub. U R NOT THE MOD"]
      redirect_to sub_url(@sub)
    end
  end
end
