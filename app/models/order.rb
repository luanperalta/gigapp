class Order < ApplicationRecord
 	# Associations
 	belongs_to :carrier
  has_many :items, dependent: :destroy

  # validations
  validates :items, presence: true
  validates :deliveryValue, numericality: { allow_nil: true }
  validates :amount, numericality: { allow_nil: true }
   
  accepts_nested_attributes_for :items, allow_destroy: true, reject_if: :all_blank 
  
  # Callbacks
  before_save :total, :invoice_value
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

  def invoice_value
    if self.invoice.blank?
      if Order.last.nil?
        self.invoice = 1
      else
        order = Order.last
        self.invoice = order.id + 1  
      end 
     self.invoice 
    end
     
  end

end
