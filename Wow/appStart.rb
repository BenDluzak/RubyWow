require "rubygems"
require "sinatra"
require './model/Character.rb'
require './model/RealmList.rb'
require './model/Realm.rb'
require './model/Guild.rb'
require './model/PvPLeaderboard.rb'
require 'rack'

set :static, true
set :views, "view"

post "/characterModel"	do

	$Response = Character.new
		$Response.create(params)	
		
	$Response.makeModelParams

	erb :characterModel

end

post "/character" do
   begin
     if(params["realm"]== "Select a Realm")
     @error = "No Realm Selected."
           erb :character
   else      
    $Response = Character.new
    $Response.create(params)
   
    if $Response.getName == nil
      @error = "Invalid character name."
      erb :character
    else
      erb :characterResults
    end
   end
   rescue
     
         @error = "Error in character lookup"
         erb :character
   end


end
 
post "/guild" do
  begin
     if(params["realm"]== "Select a Realm")
     @error = "No Realm Selected."
           erb :guild
     else
	$guild=Guild.new()
	$guild.create(params)	
	
	if $guild.getName == nil
		@error = "Invalid guild name."
		erb :guild			
	else
		erb :guildResults
	end
end
  rescue
    @error = "Invalid guild name."
      erb :guild  
  end
end


get "/arena2v2" do
	$ladder=PvPLeaderboard.new.create2v2.get2v2Ladder
	erb :arena2v2
end
get "/arena3v3" do
	$ladder=PvPLeaderboard.new.create3v3.get3v3Ladder
	erb :arena3v3
end
get "/arena5v5" do
	$ladder=PvPLeaderboard.new.create5v5.get5v5Ladder
	erb :arena5v5
end
get "/RBG" do
	$ladder=PvPLeaderboard.new.createRBG.getRBGLadder
	erb :RBG
end
get "/" do

  erb :index
end

get "/character" do

  erb :character
end


get "/guild" do
	
  erb :guild
end

get "/pvpLeaderboards" do
	$ladder=PvPLeaderboard.new.create2v2.get2v2Ladder
	erb :arena2v2
end

get "/realms" do
  $realms = RealmList.new.create()

  erb :realms
end
