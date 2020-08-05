class User < ActiveRecord::Base 
    has_secure_password
    validates :email, uniqueness: true 
    validates :name, :image_url, :bio, :email, :password, :location, presence: true 
    has_many :readings
end