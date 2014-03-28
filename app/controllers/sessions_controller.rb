class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password]) # signs the user in, shows them their page
      sign_in user
      redirect_back_or user  #redirect to where they were going, OR back to the user page
    else
      flash.now[:error] = 'Invalid email/password combination' # Not quite right!
      render 'new' # sends them back to signin page
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end