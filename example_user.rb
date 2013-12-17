class User
  attr_accessor :name, :email, :gender

  def initialize(attributes = {})
    @name  = attributes[:name]
    @email = attributes[:email]
    @gender = attributes[:gender]
  end

  def formatted_email
    "#{@name} <#{@email}> <#{@gender}>"
  end
  
  def formatted_gender
    "#{@name} <#{@gender}>"
  end
end