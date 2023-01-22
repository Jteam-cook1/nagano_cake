class Public::ItemsController < ApplicationController
   before_action :authenticate_customer!, except: [:index,:show, :search]

  def index

    @genres = Genre.all
    if params[:genre_id]
    @items = Item.where(genre_id: params[:genre_id]).page(params[:page])
    @title = Genre.find(params[:genre_id]).name
    else
    @items = Item.page(params[:page]).per(8)
    @title = "商品"
    end
    #@item = Item.find(params[:id])
  end

  def show
     @genres = Genre.all
     @item = Item.find(params[:id])
  end

  def item_params
  end

  def search
    @items = Item.search(params[:keyword]).page(params[:page])
    @genres = Genre.all
    @keyword = params[:keyword]
    render "index"
  end
end