require "sinatra"
require "pry"
require_relative "models/player"
require_relative "models/team"
require_relative "lib/team_data"

get "/" do
  "<h1>The LACKP Homepage<h1>"
  erb :playout
end

TEAMLIST = TeamData.to_h

get "/teams" do
  @team_list = TEAMLIST.keys
  erb :teamlist
end

get "/teams/:team_name" do
  @team = params[:team_name]
  @players = TEAMLIST.select {|team_name, players| team_name == @team}
  erb :team
end

get "/positions" do
  @positions = {}
  TEAMLIST.each do |team, players|
    players.each do |position, name|
      @positions["#{position}"] = "#{name}"
    end
  end
  @positions_list = @positions.keys
  erb :positions_list
end

get "/positions/:position" do
  @position = params[:position]
  @position_team = {}
  TEAMLIST.each do |team, players|
    players.each do |position, name|
      if position == @position
      @position_team["#{team}"] = "#{name}"
      end
    end
  end

  erb :positions
end
