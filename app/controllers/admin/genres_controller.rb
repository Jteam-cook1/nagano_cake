class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!
  def new
    @genre = Genre.new
  end
  
  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def create
    # １.&2. データを受け取り新規登録するためのインスタンス作成
    @genre = Genre.new(genre_params)
    # 3. データをデータベースに保存するためのsaveメソッド実行
    @genre.save
   
    redirect_to admin_genres_path
  end

  def edit
     @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    @genre.update(genre_params)
    redirect_to admin_genres_path 
  end
  
  private
  # ストロングパラメータ
  def genre_params
    params.require(:genre).permit(:name)
  end
end
