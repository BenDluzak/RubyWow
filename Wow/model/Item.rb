=begin
	LIST OF SUPPORTED ITEM GETS:
		-getID
		-getName
		-getItemLevel
		-getTransmog
		-getGem     		#returns the ID of the item's gem, if any
		-getEnchant 		#returns the ID of the item's enchant, if any
		-getBonus   		#returns an array of the item's bonus IDs, if any
		-getTooltipParams 	#returns string of tooltip paramaters formatted for the display link
			+Example for Head html tooltip display:
					<br><a href="http://wowhead.com/item=<%= $Response.getHead().getID() %> " rel= "<%= $Response.getHead().getTooltipParams() %>"><%= $Response.getHead().getName() %></a></br>

=end

class Item
	def initialize (itemhash)
		bonus=""
		set=""

		if(!itemhash.nil?)
		#	print itemhash['tooltipParams']
			@id=itemhash['id']
			@name=itemhash['name']
			@itemlevel=itemhash['itemLevel']
			@gem=itemhash['tooltipParams']['gem0']
			@enchant=itemhash['tooltipParams']['enchant']
			@bonus = itemhash['bonusLists'] #can be an array
			@set = itemhash['tooltipParams']['set']
			@transmog=itemhash['tooltipParams']['transmogItem']
			if(!itemhash['tooltipParams']['set'].nil?)
				i=0
				while (i<itemhash['tooltipParams']['set'].length)
					if(i==0)
						set << "#{itemhash['tooltipParams']['set'][i]}"
					else 
						set << ":#{itemhash['tooltipParams']['set'][i]}"
					end
					i+=1
				end
				
			end

			#print "#{set} \n"
			if (!itemhash['bonusLists'].empty?)
				i=0
				while (i<itemhash['bonusLists'].length)
					if (i==0)
						bonus << "#{itemhash['bonusLists'][i]}"
					else
						bonus << ":#{itemhash['bonusLists'][i]}"
					end
					i+=1
				end		
			end	
		else 
			@name="No Item Equipped"			
		end
			@tooltipparams = "gems=#{getGem};ench=#{getEnchant};bonus=#{bonus};pcs=#{set}"
		
	end
	def getID
		return @id
	end
	def getName
		return @name
	end
	def getItemlLevel
		return @itemlevel
	end
	def getGem #returns gem id
		return @gem
	end
	def getEnchant #returns enchant id
		return @enchant
	end
	def getBonus #returns array of bonus id(s)
		return @bonus
	end
	def getTransmog
		return @transmog
	end

	def getTooltipParams
		return @tooltipparams
	end
end