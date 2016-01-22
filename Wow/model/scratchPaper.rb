require_relative "Character.rb"
require_relative "Guild.rb"
require_relative "RealmList.rb"
require_relative "PvPLeaderboard.rb"
require "rubygems" 
require_relative "Item.rb"
require 'active_support'  
require 'rest-client' 
require 'roo' 
require 'ap' 
require 'json'
require 'addressable/uri'
require 'net/http'
char = Character.new
char.create({:name=>"liltwix",:realm=>"kalecgos",:region=>"us"})

char.makeModelParams
print char.getHead.getTransmog.nil?
#print char.getModelParams
=begin
arr=[
char.getHead.getID,
	
char.getNeck.getID,
	
char.getShoulder.getID,
	
char.getBack.getID,
	
char.getChest.getID,
	
char.getWrist.getID,
	
char.getHands.getID,
	
char.getWaist.getID,
	
char.getLegs.getID,
	
char.getFeet.getID,
	
char.getFinger1.getID,
	
char.getFinger2.getID,
	
char.getTrinket1.getID,
	
char.getTrinket2.getID,
	
char.getMainHand.getID]

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
=end
#print str
#print response.body

#response = RestClient.get Addressable::URI.parse("http://www.wowhead.com/item={113966}&xml").normalize.to_str
#print response
#print RestClient.get Addressable::URI.parse("&xml").normalize.to_str
