class Admin::ItemsController < ApplicationController
before_action :authenticate_admin!,only: [:create, :edit, :update, :index, :show, :new]

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end


  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    redirect_to admin_item_path(item.id)
  end

  def create
    @item = Item.new(item_params)
    @item.save
    redirect_to admin_item_path(@item.id)
  end


  private
  def item_params
    params.require(:item).permit(:name,:introduction,:price,:image)
  end

end
