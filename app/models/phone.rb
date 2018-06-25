class Phone < ApplicationRecord
  belongs_to :supplier
  
  validates :areacode, presence: true
  validates :number, presence: true
end
