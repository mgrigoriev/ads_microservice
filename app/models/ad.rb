class Ad < ActiveRecord::Base
  validates :user_id, :title, :description, :city, presence: true
end
