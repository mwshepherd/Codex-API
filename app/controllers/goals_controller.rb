class GoalsController < ApplicationController
  before_action :authenticate_user
  before_action :set_goal, only: [:show, :update, :destroy]

  def index
    goals = current_user.goals
    render json: { goals: goals, current_user: current_user.username}
  end

  def show
    render json: @goal
  end

  def create
    goal = current_user.goals.create(goal_params)
    render json: goal, status: 200
  end

  def update
    @goal.update(goal_params)
    render json: 'Goal Updated', status: 200
  end

  def destroy
    @goal.destroy
    render json: "Goal Deleted", status: 200
  end

  private
  def set_goal
    @goal = Goal.find(params[:id])
  end

  def goal_params
    params.require(:goal).permit(:title, :description, :url, :user_id)
  end
end
