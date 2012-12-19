class TeamsController < ApplicationController
  before_filter :get_user
  
  def get_user
    @user = User.where(:username => params[:user_id]).first
  end
  
  def new
    @team = current_user.teams.new
  end
  
  def create
    @team = current_user.teams.new(params[:team])
    @team.user_id = current_user.id
    if @team.save
        redirect_to user_teams_path(current_user), :notice => "Added Team!"
    else
        redirect_to user_teams_path(current_user), :notice => "Something Failed"
    end
  end
  
  def index
    @teams = @user.teams
  end
  
  def show
    @team = @user.teams.find(params[:id])
    @tweets = Twitter.user_timeline("mlandconnor");
  end
end
