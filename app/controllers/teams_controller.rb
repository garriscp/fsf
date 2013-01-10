class TeamsController < ApplicationController
  require "nokogiri"
  require "open-uri"
  
  before_filter :get_user
  
  def get_user
    @user = User.where(:username => params[:user_id]).first
  end
  
  def get_title(myStr)
    dashPos = myStr.index("-")
    title = myStr[0,dashPos-1]
  end
  
  def match_pos(myStr)
    positions = ["QB", "WR", "RB", "TE", "K"]
    retPos = nil
    positions.each do |position|
      if myStr.index(position)
        retPos = position
      end
    end
    return retPos
  end
  
  def match_team(myStr)
    teams = ["Oak", "Buf", "Mia", "Hou", "Bal", "Ind", "NE", "Den", "Pit", "Stl", "SD", "Cle", "NYJ", "Ten", "Jac", "KC", "Ari", "Min", "SF", "Chi", "Atl", "Cin", "Det", "TB", "Sea", "Car", "GB", "Dal", "NYG", "Phi", "Wsh", "NO"]
    retTeam = nil
    teams.each do |team|
      if myStr.index(team)
        retTeam = team
      end
    end
    return retTeam
  end
  
  def get_football_handles
    handles = ["MatthewBerryTMR", "SI_PeterKing", "EricMackFantasy", "allinkid", "NathanZegura", "CHarrisESPN", "Stephania_ESPN", "evansilva", "AdamSchefter", "mortreport", "Rotoworld_FB", "JasonLaCanfora", "ClaytonESPN", "JayGlazer", "MichaelLombardi", "AJMass", "BillSimmons", "ESPNFantasy", "ProFootballTalk", "ESPN_FFN", "YahooFootball", "richeisen"]
  end
  
  def new
   user = User.where(:username => params[:id]).first
   @team = user.teams.new
   @player = Player.new
   
    fnames = Array.new()
    lnames = Array.new()
    pos = Array.new()
    playerTeam = Array.new()
  
    url = params["url"]
    doc = Nokogiri::HTML(open(url))
    
    @teamTitle = get_title doc.at_css("title").text 
    playersRaw = doc.css(".playertablePlayerName")
    playersRaw.each do |player|
      commaPos = player.text.index(",")
      if commaPos
        myName = player.text[0,commaPos]
        noName = player.text.sub(myName + ",", "")
        myName.sub!("*","")
        nameArr = myName.split
        
        myCity = match_team noName
        noName.sub!(myCity, "")
        myPos = match_pos noName
        
        fnames.push(nameArr[0])
        lnames.push(nameArr[1])
        playerTeam.push(myCity)
        pos.push(myPos)
      end
    end
    @playersZip = fnames.zip(lnames,playerTeam, pos)
  end
  
  def create
    @team = current_user.teams.new(params[:team])
    @team.user_id = current_user.id
    
    if @team.save
      params[:players].each do |player|
      #Rails.logger.debug("here are the players: #{player}")
        @player = Player.new(:fname => player[1]["fname"], :lname => player[1]["lname"], :position => player[1]["position"], :team => player[1]["team"])
        if @player.save
          @passignment = Passignment.new
          @passignment.team_id = @team.id
          @passignment.player_id = @player.id
          @passignment.save
        end
      end
        
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
    #@tweets = Twitter.user_timeline("mlandconnor");
    @players = @team.players
    #@tweetArray = Hash.new
    #@players.each do |player|
      #fullName = player.fname + " " + player.lname
      #tweets = Twitter.search(fullName, :count => 1, :result_type => "recent").results
      #@tweetArray[fullName] = tweets
    #end
    finalHash = Hash.new
    tweetArray = consolidate_tweets
    tweetArray.each do |id, tweet|
      @players.each do |player|
        if (tweet[0]["text"].index(player.lname))
          finalHash[id] = tweet
          break
        end
      end
    end
    @myTweetHash = finalHash.sort_by {|id, tweet| -id}
  end
  
  def consolidate_tweets
    experts = get_football_handles
    tweetHash = Hash.new
    experts.each do |expert|
      tweets = Twitter.user_timeline(expert)
      tweets.each do |tweet|
        tweetHash[tweet.id] = ["name" => tweet.user.name, "text" => tweet.text, "created_at" => tweet.created_at, "profile_image_url" => tweet.user.profile_image_url]
      end
    end
    #myTweetHash = tweetHash.sort_by {|id, tweet| -id}
    return tweetHash
  end
  
  def prepare
  
  end
  
  def home
    if current_user
      redirect_to user_teams_path(current_user), :notice => "Welcome #{current_user.username}!"
      else
      redirect_to new_user_session_path
    end
  end
  
  def destroy
    @user.teams.find(params[:id]).destroy
    redirect_to user_teams_path(current_user), :notice => "Team Deleted!"
  end
  
  def _navMenu
    @connor = "test"
  end
end
