require_relative "Realm.rb"
class RealmList
  def create
    response = RestClient.get "http://us.battle.net/api/wow/realm/status"
    realmInfo = JSON.parse(response)
    #puts realmInfo
   realmArray = Array.new
   #puts realmInfo["realms"].length 
    for  i in 0 ..245
      realmArray.push Realm.new.create(realmInfo["realms"][i])
  end
  return realmArray
end
end