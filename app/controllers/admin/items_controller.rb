class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @item = Item.all
    @items = Item.page(params[:page])
  end

  def new
    @item = Item.new
  end

  def create
      # １.&2. データを受け取り新規登録するためのインスタンス作成
    @item = Item.new(item_params)
    # 3. データをデータベースに保存するためのsaveメソッド実行
    if @item.save
    redirect_to admin_item_path(@item.id)
    else
    render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
    redirect_to admin_item_path(@item.id)
    else
    render :edit
    end
  end

  def item_params
    params.require(:item).permit(:name,:description,:price,:image,:genre_id,:is_active,:page)
  end

  def search
    @items = Item.search(params[:keyword]).page(params[:page])
    @keyword = params[:keyword]
    render "index"
  end
end

