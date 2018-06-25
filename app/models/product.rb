class Product < ApplicationRecord
  belongs_to :supplier
  has_many :items

  validates :name, presence: true
  accepts_nested_attributes_for :items
  #nao ta fazendo diferença
end
