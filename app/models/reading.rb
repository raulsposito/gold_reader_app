class Reading < ActiveRecord::Base
    belongs_to :user 

    validates :name, :location, :genre, :datetime, presence: true 
end
