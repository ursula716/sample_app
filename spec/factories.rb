FactoryGirl.define do
  factory :user do
    name     "Ursula"
    email    "ursula@rgnrtr.com"
    password "foobar"
    password_confirmation "foobar"
  end
end