class Item < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :product, presence: true 
  validates :amount, presence: true, numericality: true
  validates :value, presence: true, numericality: true
  validates_associated :product, presence: true
  accepts_nested_attributes_for :product, reject_if: :all_blank
  
end
