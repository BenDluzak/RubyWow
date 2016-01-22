require "rubygems" 
require_relative 'PvPCharacter.rb'
require 'active_support'  
require 'rest-client' 
require 'roo' 
require 'ap' 
require 'json'
class PvPLeaderboard
	
	
	def create2v2
		bracket = "2v2"
		host="http://us.battle.net"
		request = host + "/api/wow/leaderboard/" + bracket		
		response = RestClient.get request
		#print response 
		pvpInfo=JSON.parse(response)['rows']
		@ladder2v2 = []
		for i in 0..499
			@ladder2v2[i] = PvPCharacter.new.construct(pvpInfo[i])
		end
		return self
	end
	def create3v3
		bracket = "3v3"
		host="http://us.battle.net"
		request = host + "/api/wow/leaderboard/" + bracket		
		response = RestClient.get request
		#print response 
		pvpInfo=JSON.parse(response)['rows']
		@ladder3v3 = []
		for i in 0..499
			@ladder3v3[i] = PvPCharacter.new.construct(pvpInfo[i])
		end
		return self
	end	
	def create5v5
		bracket = "5v5"
		host="http://us.battle.net"
		request = host + "/api/wow/leaderboard/" + bracket		
		response = RestClient.get request
		#print response 
		pvpInfo=JSON.parse(response)['rows']
		@ladder5v5 = []
		for i in 0..499
			@ladder5v5[i] = PvPCharacter.new.construct(pvpInfo[i])
		end
		return self
	end		
	def createRBG
		bracket = "rbg"
		host="http://us.battle.net"
		request = host + "/api/wow/leaderboard/" + bracket		
		response = RestClient.get request
		#print response 
		pvpInfo=JSON.parse(response)['rows']
		@ladderRBG = []
		for i in 0..499
			@ladderRBG[i] = PvPCharacter.new.construct(pvpInfo[i])
		end
		return self
	end			
 def get2v2Ladder
 	return @ladder2v2
 end
 def get3v3Ladder
 	return @ladder3v3
 end
 def get5v5Ladder
  return @ladder5v5
end
def getRBGLadder
	return @ladderRBG
end
end