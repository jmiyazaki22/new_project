class TasksController < ApplicationController
before_action :authenticate_user

  def index
      @tasks_inbox = Task.where(
        user_id: @current_user.id).where.not(
        when_to: [Date.today, Date.tomorrow]
        )
      @tasks_today = Task.where(
        user_id: @current_user.id,
        when_to: Date.today
      )
      @tasks_tomorrow = Task.where(
        user_id: @current_user.id,
        when_to: Date.tomorrow
      )
    @search = params[:search]
    if @search
        @tasks_inbox = @tasks_inbox.where("content like ?","%#{@search}%")
        @tasks_today = @tasks_today.where("content like ?","%#{@search}%")
        @tasks_tomorrow = @tasks_tomorrow.where("content like ?","%#{@search}%")
    else
    end
  end

  def destroy
    @task = Task.find_by(id: params[:id])
    if @task.destroy
      flash[:notice] = "「#{@task.content}」を完了しました"
      redirect_to("/tasks/index")
    else
      render("tasks/index")
    end
  end

  def create
    @task = Task.new(
      content: params[:content],
      user_id: @current_user.id,
      when_to: params[:date]
    )
    if @task.when_to == nil
      @task.when_to = Date.new(1000, 01, 01)
    end
    if @task.save
      flash[:notice] = "「#{@task.content}」を追加しました"
      redirect_to("/tasks/index")
    else
      render("tasks/index")
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])
    @task.content = params[:content]
    @task.when_to = params[:date]
    if @task.save
      flash[:notice] = "「#{@task.content}」を編集しました"
      redirect_to("/tasks/index")
    else
      render("tasks/index")
    end
  end
end
