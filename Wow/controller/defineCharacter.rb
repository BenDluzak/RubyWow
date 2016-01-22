require "rubygems" 

require 'active_support'  
require 'rest_client' 

require 'roo' 
require 'ap' 
def findCharacter
    @character = Character.create("name" => @params['characterName'],"realm" => @params['realm'])
     if @character != null
            render :action => :found, :back => url_for(:action => :character)
            # place holder until we have a character page for retrieved data
            
     else
       @error = "Character Not Found"
            render :action => :character
            #case where no character is found 
     end
end