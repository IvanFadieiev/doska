class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  def self.search(by_poster)
   where("poster LIKE ?", "%#{by_poster}%")
  end
  def self.search_body(by_body)
   where("body LIKE ?", "%#{by_body}%")
  end
end
