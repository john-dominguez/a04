class LinksController < ApplicationController

  before_action :require_login

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(links_params)
    @link.user_id = current_user.id
    if @link.save
      redirect_to link_url(@link)
    else
      flash[:errors] = @link.errors.full_messages
      render :new
    end
  end

  def index
    @links = Link.all
  end

  def show
    @link = Link.find(params[:id])
  end

  def edit
    @link = Link.find(params[:id])
  end

  def update
    @link = current_user.links.find(params[:id])
    if @link.update_attributes(links_params)
      redirect_to link_url(@link)
    else
      flash[:errors] = @link.errors.full_messages
      render :edit
    end
  end

  private
  def links_params
    self.params.require(:link).permit(:title, :url)
  end
end
