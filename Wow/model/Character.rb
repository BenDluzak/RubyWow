require "rubygems" 
require_relative "Item.rb"
require 'active_support'  
require 'rest-client' 
require 'roo' 
require 'ap' 
require 'json'
require 'addressable/uri'
=begin
		LIST OF SUPPORTED CHARACTER GETS:
				-getClass
				-getName
				-getLevel
				-getRealm
				-getGuild
				-getRace
				-getAchievementPoints
				-getItemLevel
			
			PvP stuff:
				-get2v2Rating
				-get3v3Rating
				-get5v5Rating
				-getRBGRating
				-getHonorableKills
			Items (returns an Item object. Details in Item class file):
				-getHead
				-getNeck
				-getShoulder
				-getBack
				-getChest
				-getWrist
				-getHands
				-getWaist
				-getLegs
				-getFeet
				-getFinger1
				-getFinger2
				-getTrinket1
				-getTrinket2
				-getMainHand
				-getOffHand

=end
class Character
	
	def construct(characterHash)      #(characterHash)	
		#print characterHash['appearance']
		@charName=characterHash['name']
		@charRealm=characterHash['realm'].gsub(" ","-")
		@charLevel=characterHash['level']
		@charGuild = characterHash['guild']['name']	
		@raceId = characterHash['race']		
		@charClass=findClass(characterHash['class'])
		@classId = characterHash['class']
		@charRace = findRace(@raceId)
		@charAchievementPoints = characterHash['achievementPoints']
		@avgIlvl= characterHash['items']['averageItemLevelEquipped']	
		@rating2v2 = characterHash['pvp']['brackets']['ARENA_BRACKET_2v2']['rating']
		@rating3v3 = characterHash['pvp']['brackets']['ARENA_BRACKET_3v3']['rating']
		@rating5v5 = characterHash['pvp']['brackets']['ARENA_BRACKET_5v5']['rating']
		@ratingRBG = characterHash['pvp']['brackets']['ARENA_BRACKET_RBG']['rating']
		@honorableKills = characterHash['totalHonorableKills']
		@thumbnail = characterHash['thumbnail']
		@charGender =  characterHash['gender']
		@param=
					"&sk"+characterHash['appearance']['skinColor'].to_s+
					"&ha"+characterHash['appearance']['hairVariation'].to_s+
					"&hc" + characterHash['appearance']['hairColor'].to_s+
					"&fa" + characterHash['appearance']['faceVariation'].to_s+
					"&fh"+characterHash['appearance']['featureVariation'].to_s+
					"&fc"+characterHash['appearance']['featureVariation'].to_s+"&mode=3"

		makeItems(characterHash['items'])			

	end	

	
	def makeModelParams

		if getRaceId==1 
					 race="human" 
				elsif getRaceId== 2 
					 race="orc" 
				elsif getRaceId==  3 
					 race="dwarf" 
				elsif getRaceId==  4 
					 race="nightelf" 
				elsif getRaceId== 5 
					 race="scourge" 
				 elsif getRaceId==6 
					 race="tauren" 
				 elsif getRaceId==7 
					 race="gnome" 
				 elsif getRaceId==8 
					 race="troll" 
				 elsif getRaceId==9 
					 race="goblin" 
				 elsif getRaceId==10 
					 race="bloodelf" 
				 elsif getRaceId==11 
					 race="draenei" 
				 elsif getRaceId==22 
					 race="worgen" 
				 elsif getRaceId==24	
					 race="pandaren"
				 elsif getRaceId==25 
					 race="pandaren"
				 elsif getRaceId==26
					 race="pandaren"
				 end	
		arr=[
		 (getHead.getTransmog.nil?)?getHead.getID : getHead.getTransmog,
		 (getNeck.getTransmog.nil?)?getNeck.getID : getNeck.getTransmog,
		 (getShoulder.getTransmog.nil?)?getShoulder.getID : getShoulder.getTransmog,
		 (getBack.getTransmog.nil?)? getBack.getID : getBack.getTransmog,
		 (getChest.getTransmog.nil?)? getChest.getID : getChest.getTransmog,
		 (getWrist.getTransmog.nil?)?getWrist.getID : getWrist.getTransmog,
		 (getHands.getTransmog.nil?)? getHands.getID : getHands.getTransmog,
		 (getWaist.getTransmog.nil?)?getWaist.getID : getWaist.getTransmog,
		 (getLegs.getTransmog.nil?)?getLegs.getID : getLegs.getTransmog,
		 (getFeet.getTransmog.nil?)?getFeet.getID : getFeet.getTransmog,
		 (getFinger1.getTransmog.nil?)?getFinger1.getID : getFinger1.getTransmog,
		 (getFinger2.getTransmog.nil?)?getFinger2.getID : getFinger2.getTransmog,
		 (getTrinket1.getTransmog.nil?)? getTrinket1.getID : getTrinket1.getTransmog,
		 (getTrinket2.getTransmog.nil?)? getTrinket2.getID : getTrinket2.getTransmog,
		 (getMainHand.getTransmog.nil?)? getMainHand.getID : getMainHand.getTransmog]		
		arr2=[]
		
		j=0
		for i in 0..arr.length

				req = "http://www.wowhead.com/item=#{arr[i]}&xml"
				uri=URI.parse(req)
				response = Net::HTTP.get_response(uri)	
				split=response.body.split('"')
				arr2[j]=split[15]
		
				arr2[j+1]=split[13]
		
				j+=2
		
		end
		str=""
		for i in 0..arr2.length
			if not(arr2[i].nil?)
		
				str<<arr2[i].to_str<<","
			end
		end
		str=str[0...-1]		

		@link = 
		"model=#{race}"<<"#{getGender}&modelType=16&contentPath=http://wow.zamimg.com/modelviewer/&equipList=#{str}#{getParam}"
		return
	end
	def getModelParams
		return @link
	end
	def getRaceId
		return @raceId
	end
  def getGender
  	if @charGender==0
  		return "male"
  	else return "female"
  	end
  end
   def getParam
   	return @param
   end
	def create (params)

		host = "http://us.battle.net/api/wow/character/"
		request = host + params[:realm].gsub(" " , "-") + '/' + params[:name] + "?fields=guild,items,pvp,appearance,progression"
		begin
			response =RestClient.get Addressable::URI.parse(request).normalize.to_str
		rescue
			return nil
		end
		characterInfo = JSON.parse(response)

		return construct(characterInfo)					
	end	

	def makeItems (itemhash) #item will be nil if no item is equipped in that slot
		@head=Item.new(itemhash['head'])
		@neck=Item.new(itemhash['neck'])
		@shoulder=Item.new(itemhash['shoulder'])
		@back=Item.new(itemhash['back'])
		@chest=Item.new(itemhash['chest'])
		@wrist=Item.new(itemhash['wrist'])
		@hands=Item.new(itemhash['hands'])
		@waist=Item.new(itemhash['waist'])
		@legs=Item.new(itemhash['legs'])
		@feet=Item.new(itemhash['feet'])
		@finger1=Item.new(itemhash['finger1'])
		@finger2=Item.new(itemhash['finger2'])
		@trinket1=Item.new(itemhash['trinket1'])
		@trinket2=Item.new(itemhash['trinket2'])
		@mainhand=Item.new(itemhash['mainHand'])
		@offhand=Item.new(itemhash['offHand'])
return
	end
	def findRace(id)
	
		races=[{"id"=>1, "name"=> "Human"},
		{"id"=>2, "name"=> "Orc"},
		{"id"=>3, "name"=> "Dwarf"},
		{"id"=>4, "name"=> "Night Elf"},
		{"id"=>5, "name"=> "Undead"},
		{"id"=>6, "name"=> "Tauren"},
		{"id"=>7, "name"=> "Gnome"},
		{"id"=>8, "name"=> "Troll"},
		{"id"=>9, "name"=> "Goblin"},
		{"id"=>10, "name"=> "Blood Elf"},
		{"id"=>11, "name"=> "Draenei"},
		{"id"=>22, "name"=> "Worgen"},
		{"id"=>24, "name"=> "Pandaren"},
		{"id"=>25, "name"=> "Pandaren"},
		{"id"=>26, "name"=> "Pandaren"}]
		i=0;
		while races[i]['id']!=id do
			i+=1
		end				
		return races[i]['name']		
	end
	def findClass(id)
			classarray=["Warrior","Paladin","Hunter","Rogue","Priest",
			  "Death Knight","Shaman","Mage","Warlock","Monk","Druid"]
			return classarray[id-1]	
	end	   	
	
	#gets for all the character's equipped items
	def getHead
		return @head
	end
	
	def getNeck
		return @neck
	end
	
	def getShoulder
		return @shoulder
	end
	
	def getBack
		return @back
	end
	
	def getChest
		return @chest
	end
	
	def getWrist
		return @wrist
	end
	
	def getHands
		return @hands
	end
	
	def getWaist
		return @waist
	end
	
	def getLegs
		return @legs
	end	
	
	def getFeet
		return @feet
	end
	
	def getFinger1
		return @finger1
	end
		
	def getFinger2
		return @finger2
	end
	
	def getTrinket1
		return @trinket1
	end
	
	def getTrinket2
		return @trinket2
	end
	
	def getMainHand
		return @mainhand
	end
	
	def getOffHand
		return @offhand
	end
	#end item gets
	
	def getClass
		return @charClass
	end
	
	def getName
		return @charName
	end
	def getThumbnail
		return @thumbnail
	end
	def getLevel
		return @charLevel
	end
	def getRealm
		return @charRealm
	end
	def getGuild
		return @charGuild
	end
	def getRace
		return @charRace
	end
	def getAchievementPoints
		return @charAchievementPoints
	end		 
	def getItemLevel
		return @avgIlvl
	end
	def get2v2Rating
		return @rating2v2
	end
	def get3v3Rating
		return @rating3v3
	end
	def get5v5Rating
		return @rating5v5
	end
	def getRBGRating
		return @ratingRBG
	end
	def getHonorableKills
		return @honorableKills
	end
end