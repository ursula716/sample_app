module SessionsHelper
  def sign_in(user)
    remember_token = User.new_remember_token                            #creates sign-in for the user
    cookies.permanent[:remember_token] = remember_token                 #saves the newly created token
    user.update_attribute(:remember_token, User.hash(remember_token))   #adds token to user
    self.current_user = user                                            #creates instance of user
  end
  
  def signed_in?
    !current_user.nil? #if NOT current_user IS nil (if current_user is not nil
  end
  
  def current_user=(user)  #called to SET the current user
    @current_user = user
  end
  
  def current_user                                                       #looking the user up (GET user)
    remember_token = User.hash(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)       #finding the user by the remember token
    #if that user does not already have a value, add it -- if they do, look them up -- ||= function
  end
  
  def current_user?(user)
    user == current_user
  end
  
  def sign_out
    current_user.update_attribute(:remember_token, User.hash(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    #redirect to the page they were going to, but if not, go to default page
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end
end