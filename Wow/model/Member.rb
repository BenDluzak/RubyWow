class Member
  
  def construct(member)
    @name = member['character']['name'] 
    @race = findRace(member['character']['race'])
    @rank = member['rank']
    @thumbNail = member['character']['thumbnail']
    @level = member['character']['level']
    @class = findClass(member['character']['class'])  
      return self
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
  
  def getName
    return @name
  end
  def getRace
    return @race
  end
  def getRank
    return @rank
  end
  def getThumbNail
    return @thumbNail
  end
  def getLevel
    return @level
  end
  def getClass
    return @class
  end
  
end