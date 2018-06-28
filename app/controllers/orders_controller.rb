class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :set_options_for_select, only: [:new, :edit, :update, :create]
  before_action :set_products_for_order, only: [:new, :create, :edit, :update]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all.reverse_order.page(params[:page]).per(8)
    
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @items = @order.items.build
    @items = Item.where(order_id: @order.id)
    
  end

  # GET /orders/new
  def new
    @order = Order.new
    
  end

  # GET /orders/1/edit
  def edit
    
  end

  # POST /orders
  # POST /orders.json
  def create
     
     @order = Order.new(order_params)
     
     total_calculate_create
     

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: I18n.t('messages.created') }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    

    total_calculate_update
   
    respond_to do |format|
      if @order.update(update_params)
        format.html { redirect_to @order, notice: I18n.t('messages.updated') }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: I18n.t('messages.destroyed') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
   def total_calculate_create
    total = 0
    @order.amount = 0
    if @order.deliveryValue == nil
      @order.deliveryValue = 0
    end
    if @order.discount == nil
      @order.discount = 0
    end
    @order.items.each do |order|
      total += order.amount.to_f * order.value.to_f
    end
     @order.amount = total + @order.deliveryValue - @order.discount
   end

   def total_calculate_update
    total = 0
    
    @new_order = Order.new(order_params)
    if @order.deliveryValue.blank?
      @order.deliveryValue = 0
    end
    if @order.discount.blank?
      @order.discount = 0
    end
    @order.deliveryValue = @new_order.deliveryValue
    @order.discount = @new_order.discount
    @order.amount = @new_order.amount
    
      
    @new_order.items.each do |order|
      if order.amount.blank?
        order.amount = 0
      end  
      if order.value.blank?
        order.value = 0
      end  

      total += order.amount * order.value
    end
     @order.amount = total + @order.deliveryValue - @order.discount

   end


   def set_options_for_select
      @carrier_options_for_select = Carrier.all
   end
   
   def set_products_for_order
      @products_for_order = Product.all   
   end

    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:dateTime, :invoice, :deliveryValue, :discount, :amount, :carrier_id,
                                    items_attributes: [:amount, :value, :product_id, :_destroy])
    end
    def update_params
      params.require(:order).permit(:dateTime, :invoice, :carrier_id,
                                    items_attributes: [:amount, :value, :id, :product_id, :_destroy])
    end
end
