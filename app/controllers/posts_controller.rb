class PostsController < ApplicationController
   
  before_action :today_date
   
  def today_date
    @today_date = Time.zone.now
  end
   
  def index
    @page_title = "スケジュール一覧"
    @posts = Post.all
    @posts_count = Post.count
  end
 
  def new
    @page_title = "スケジュール新規作成"
    @post = Post.new
  end
   
  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = "スケジュールを登録しました"
      redirect_to :posts
    else
      flash[:failure] = "スケジュールを登録できませんでした"
      render "new"
    end
  end
   
  def show
    @page_title = "スケジュール詳細"
    @post = Post.find(params[:id])
  end
 
  def edit
    @page_title = "スケジュール編集"
    @post = Post.find(params[:id])
  end
 
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:success] = "「#{@post.id}」のスケジュールを更新しました"
      redirect_to :posts
    else
      flash[:failure] = "スケジュールを更新できませんでした"
      render "edit"
    end
  end
 
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:success] = "ユーザーを削除しました"
    redirect_to :posts
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :start_at, :end_at, :is_all_day, :memo)
  end
end
