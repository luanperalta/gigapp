class Order < ApplicationRecord
  belongs_to :carrier
  has_many :items, dependent: :destroy

  validates :items, presence: true
  validates :discount, numericality: true
  validates :deliveryValue, numericality: true

  # validates :items, presence: true

  accepts_nested_attributes_for :items, allow_destroy: true, reject_if: :all_blank 
  # permite remover os items em orders
end
