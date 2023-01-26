class Public::HomesController < ApplicationController
  def top
    @items = Item.where(is_active: true)
    @genres = Genre.all
    if params[:genre_id]
    @items = @items.where(genre_id: params[:genre_id]).page(params[:page])
    @title = Genre.find(params[:genre_id]).name
    else
    @items = @items.order('id DESC').limit(4)
    @title = "新着商品"
    end
  end

  def about
  end
end
