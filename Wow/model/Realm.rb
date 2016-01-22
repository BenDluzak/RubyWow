class Realm
  def create(params)
    @population = params["population"]
    @name = params["name"]
    @queue = params["queue"]
    @status = params["status"]
    @type = params["type"]  
      return self
  end
  def getPopulation
    return @population
  end
  def getName
    return @name
  end
  def getQueue
    return @queue
  end
  def getStatus
    return @status
  end
  def getType
    return @type
  end
end

