class Order < ApplicationRecord
 	# Associations
 	belongs_to :carrier
  has_many :items, dependent: :destroy

  # validations
  validates :items, presence: true
  
 
  accepts_nested_attributes_for :items, allow_destroy: true, reject_if: :all_blank 
  
  # Callbacks
  before_save :total
  after_find :total


  def total
  	self.amount = 0
  	if self.deliveryValue.nil?
  		self.deliveryValue = 0
  	end
  	if self.discount.nil?
  		self.discount = 0
  	end

  	self.items.each do |item| 
  		self.amount += item.amount * item.value 
  	end

  	self.amount += self.deliveryValue - self.discount
    self.amount = self.amount.round(2)

  end

end
