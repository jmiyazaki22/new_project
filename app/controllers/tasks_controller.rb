class TasksController < ApplicationController
before_action :set_current_user
before_action :authenticate_user

  def index
    @tasks_inbox = Task.where(
      user_id: @current_user.id,
      when_to: nil
    )
    @tasks_today = Task.where(
      user_id: @current_user.id,
      when_to: Date.today
    )
    @tasks_tomorrow = Task.where(
      user_id: @current_user.id,
      when_to: Date.tomorrow
    )
    @task = Task.new
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
    if @task.save
      flash[:notice] = "「#{@task.content}」を追加しました"
      redirect_to("/tasks/index")
    else
      render("tasks/index")
    end
  end
end
