class Public::HomesController < ApplicationController
  def top
    @genres = Genre.all
    if params[:genre_id]
    @items = Item.where(genre_id: params[:genre_id]).page(params[:page])
    @title = Genre.find(params[:genre_id]).name
    else
    @items = Item.order('id DESC').limit(4)
    @title = "新着商品"
    end
  end

  def about
  end
end
