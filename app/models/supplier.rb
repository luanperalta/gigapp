class Supplier < ApplicationRecord
	has_many :phones, dependent: :destroy
	has_many :emails, dependent: :destroy
	has_many :products, dependent: :destroy

	validates :phones, presence: true
	validates :name, presence: true
  	validates :city, presence: true
  	validates :address, presence: true
  		
	accepts_nested_attributes_for :emails, allow_destroy: true, reject_if: :all_blank 
	accepts_nested_attributes_for :phones, allow_destroy: true, reject_if: :all_blank 
end
