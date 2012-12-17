class TeamsController < ApplicationController
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
    @teams = current_user.teams
  end
end
