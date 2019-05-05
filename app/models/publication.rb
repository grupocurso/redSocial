class Publication < ApplicationRecord
    validates :description, presence: true 
end
