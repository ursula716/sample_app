class MicropostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  #hides the indexing functionality from non-signed-in users
  before_action :correct_user,   only: :destroy
  #makes sure that you're only destroying posts of the correct user (yourself)
  
  def index
  end
  
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end
  
  def destroy
    @micropost.destroy  #the opposite of save
    redirect_to root_url
  end
  
  private
  
  def micropost_params
    params.require(:micropost).permit(:content)
    #content is the only thing you can submit into a micropost
  end
  
  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    #micropost IDs linked to user IDs by has_many
    redirect_to root_url if @micropost.nil?
  end
end