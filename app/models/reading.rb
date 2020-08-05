class Reading < ActiveRecord::Base
    belongs_to :user 

    validates :name, :image_url, :location, :genre, presence: true 
end
