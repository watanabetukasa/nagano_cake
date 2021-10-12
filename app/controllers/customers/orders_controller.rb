class Customers::OrdersController < ApplicationController
before_action :authenticate_customer!
  def new
    @order = Order.new
  end

  def confirm
    #binding.pry
    @order = Order.new(order_params)
    #@address = Address.find(params[:order][:address_id])
    @cart_items = current_customer.cart_items
    if params[:address_option] == "0"
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
      @order.postal_code = current_customer.postal_code
    elsif params[:address_option] == "1"
      @address = Address.find(params[:address_id])
      @order.address = @address.address
      @order.name = @address.name
      @order.postal_code = @address.postal_code
    end
  end

  def create
    #オーダー（郵便番号・住所・名前・請求金額・支払方法andユーザーID・送料）
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.shipping_cost = 800
    @order.save
    #商品１つずつcreate(オーダーID・アイテムID・税込金額・個数)
    @cart_items = current_customer.cart_items.all
  @cart_items.each do |cart_item|
    @order_detail = OrderDetail.new
    @order_detail.order_id = @order.id
    @order_detail.item_id = cart_item.item.id
    @order_detail.price = cart_item.item.with_tax_price
    @order_detail.amount = cart_item.amount
    @order_detail.save
  end
    #カート内商品を全部削除（defじゃないからルーティング不要）
    @cart_items.destroy_all
    redirect_to orders_complete_path
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  private
  def order_params
    params.require(:order).permit(:payment_method,:name,:address,:postal_code,:total_payment)
  end

end

#