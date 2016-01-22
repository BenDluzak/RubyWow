class PvPCharacter
	def construct(pvpInfo)
		@rating = pvpInfo['rating']
		@name = pvpInfo['name']
		@realm=pvpInfo['realmName']
		@race = findRace(pvpInfo['raceId'])
		@class = findClass(pvpInfo['classId'])
		@spec = findSpec(@class,pvpInfo['specId'])
		@seasonWins = pvpInfo['seasonWins']
		@seasonLosses = pvpInfo['seasonLosses']
		@winRatio = (@seasonWins.to_f/(@seasonLosses+@seasonWins))*100
		@winRatio = ('%.1f' % @winRatio).to_f
		@faction = pvpInfo['factionId']==0 ? "Alliance" : "Horde"

		return self
	end
	def getRating
		return @rating
	end	
	def getName
		return @name
	end
	def getRealm
		return @realm
	end
	def getRace
		return @race
	end
	def getClass
		return @class
	end
	def getSpec
		return @spec
	end
	def getSeasonWins
		return @seasonWins
	end
	def getSeasonLosses
		return @seasonLosses
	end
	def getWinRatio
		return @winRatio
	end
	def getFaction
		return @faction
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
				classArray=["Warrior","Paladin","Hunter","Rogue","Priest",
				  "Death Knight","Shaman","Mage","Warlock","Monk","Druid"]
				return classArray[id-1]	
		end	   	
		def findSpec(className,specId)	
			if className == "Mage"
				if specId == 62   
					return "Arcane"
				elsif specId==63    
					return  "Fire"
				else 
					return    "Frost"
				end
			
			
			elsif className == "Paladin"
				if specId == 65   
					return   "Holy"
				elsif specId==66   
					return  "Protection"
				else 
					return   "Retribution"
				end
			
			elsif className == "Warrior"
				if specId == 71   
					return   "Arms"
				elsif specId==72  
					return   "Fury"
				else 
					return    "Protection"
				end
			
			elsif className == "Druid"
				if specId == 102   
					return  "Balance"
				elsif specId==103  
					return  "Feral"
				elsif specId==104  
					return  "Guardian"
				else 
					return   "Restoration"
				end
			
			elsif className == "Death Knight"
				if specId == 250   
					return  "Blood"
				elsif specId==251  
					return  "Frost"
				else 
					return   "Unholy"
				end
			
			elsif className == "Hunter"
				if specId == 253   
					return  "Beast Mastery"
				elsif specId==254   
					return  "Marksmanship"
				else 
					return    "Survival"
				end
			
			
			elsif className == "Priest"
				if specId == 256   
					return  "Discipline"
				elsif specId==257   
					return  "Holy"
				else 
					return    "Shadow"
				end
			
			elsif className == "Rogue"
				if specId == 259  
					return   "Assassination"
				elsif specId==260  
					return  "Combat"
				else 
					return   "Subtlety"
				end
			
			elsif className == "Shaman"
				if specId == 262   
					return  "Elemental"
				elsif specId==263   
					return  "Enhancement"
				else 
					return    "Restoration"
				end
			
			elsif className == "Warlock"
				if specId == 265   
					return  "Affliction"
				elsif specId==266   
					return  "Demonology"
				else 
					return    "Destruction"
				end
			
			else
				if specId == 268  
					return   "Brewmaster"
				elsif specId==269  
					return  "Windwalker"
				else 
					return   "Mistweaver"
				end
			end			
		end
end
