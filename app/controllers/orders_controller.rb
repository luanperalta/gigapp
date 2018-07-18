class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :set_options_for_select, only: [:new, :edit, :update, :create]
  before_action :set_products_for_order, only: [:new, :create, :edit, :update]

  # GET /orders
  # GET /orders.json
  def index
    @q = Order.ransack(params[:q])
    @orders = @q.result.page(params[:page])
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
         
    respond_to do |format|
      if @order.update(order_params.except([:amount]))
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
   def set_options_for_select
      @carrier_options_for_select = Carrier.all
   end
   
   def set_products_for_order
      @products_for_order = Product.all.order(:name)   
   end

    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:dateTime, :invoice, :deliveryValue, :discount, :amount, :carrier_id,
                                    items_attributes: [:amount, :value, :product_id, :_destroy, :id])
    end
    
end
