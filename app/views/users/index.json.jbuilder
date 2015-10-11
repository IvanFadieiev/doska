json.array!(@users) do |user|
  json.extract! user, :id, :user, :full_name, :birthday, :email, :adress, :city, :country, :password_digest, :latitude, :longitude
  json.url user_url(user, format: :json)
end
