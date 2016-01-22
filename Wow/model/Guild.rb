require "rubygems" 

require 'active_support'  
require 'rest-client' 
require 'roo' 
require 'ap' 
require 'json'
require 'addressable/uri'
require_relative "Member.rb"

class Guild

	# no constructor needed
	def create (params)
		host = "http://us.battle.net/api/wow/guild/"
		request = host + params[:realm] + '/' + params[:guildName].gsub(" ","%20") + "?fields=members"
     	begin
			response =RestClient.get Addressable::URI.parse(request).normalize.to_str
		rescue
			return nil
		end
		guildInfo = JSON.parse(response)
		#guildInfo.delete_if {|key,value| }
		return construct(guildInfo)						
	end
	
	def construct(guildInfo)
     @guildName = guildInfo['name']
     @guildRealm = guildInfo['realm']
     @guildLevel = guildInfo['level']
     @guildBGroup = guildInfo['battlegroup']
     
       setMembers(guildInfo['members'])
	end
	
	def setMembers (roster)
	  @guildMembers =[]
	    i=0
	    while i<roster.length
	      @guildMembers[i]=Member.new.construct(roster[i])
	      i+=1
	    end
		@guildMembers.sort!{|x,y| x.getName <=> y.getName}
	end
 def getMembers
    return @guildMembers
 end
	def getName
		return @guildName
	end
	
	def getLevel
		return @guildLevel
	end
	
	def getRealm
		return @guildRealm
	end

	def getBGroup
	  return @guildBGroup
	end
	
	def getMemRace
	  return @guildMemRace
	end
	
	def getMemClass
	  return @guildMemClass
	end
	
end
