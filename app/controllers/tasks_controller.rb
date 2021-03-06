class TasksController < ApplicationController
  
  #before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  # Micropostの場合
  # before_action :correct_user, only: [:destroy] 
  # def correct_user
  # @micropost = current_user.microposts.find_by(id: params[:id])
  
  before_action :require_user_logged_in, only: [:show, :edit, :update, :destroy, :new]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  
  def index
    # @tasks = Task.all.page(params[:page])
  end

  def show
    
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)

    if @task.save
      flash[:success] = 'Task が正常に投稿されました'
      redirect_to root_url
    else
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def edit
    
  end

  def update
    

    if @task.update(task_params)
      flash[:success] = 'Task は正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
    end
  end

  def destroy
    # before_action で @task = Task.find(params[:id])→そもそもなに？
    # @taskに、Taskモデルからidで検索して投稿を代入
    
    
    # ログイン実装後におかしくなる
    # 
    @task.destroy

    flash[:success] = 'Task は正常に削除されました'
    redirect_back(fallback_location: root_path)
  end
  
  private

  # def set_task
  #   @task = Task.find(params[:id])
  # end

  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end

  
  
  
  
end


