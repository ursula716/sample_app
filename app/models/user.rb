class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  before_create :create_remember_token  #a method that is defined later in the private area of user.rb
  validates :name, presence: true, length: { maximum: 50 }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  
  has_secure_password
  validates :password, length: { minimum: 6 }
  
  def User.new_remember_token
    SecureRandom.urlsafe_base64          #this generates a 64-bit token with valid (URL-safe) characters
  end

  def User.hash(token)
    Digest::SHA1.hexdigest(token.to_s)   #storing the hash version of the token, not the actual token/password
    #SHA1 is like a better version of MD5
  end
  
  private
  def create_remember_token              #called upon in the "before create" area
    self.remember_token = User.hash(User.new_remember_token)
  end
end
