class User < ActiveRecord::Base

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#", :small => "100x100#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  before_save do 
  self.email = email.downcase
  self.full_name = full_name.capitalize
  self.user = user.capitalize
  self.adress = adress.capitalize
  self.city = city.capitalize
  self.country = country.capitalize
  end

  validates :user, presence: true, length: { maximum: 50 }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }
  validates :full_name, presence: true 
  validates :birthday, presence: true
  validates :adress, presence: true
  validates :city, presence: true
  validates :country, presence: true
  validates_attachment :avatar, content_type: { content_type: /\Aimage\/.*\Z/ }
end
