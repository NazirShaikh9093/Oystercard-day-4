class Journey
  attr_reader :journey

  def initialize
    @entry_station
    @exit_station
    @journey 
  end

  def start_journey(entry_station)
    @entry_station = entry_station
  end

  def finish_journey(exit_station)
    @exit_station = exit_station
    @journey = { @entry_station => @exit_station }
    @entry_station = nil
    @exit_station = nil
    @journey
  end

  def fare
    journey_complete?(@journey) ? 1 : 6
  end

  def journey_complete?(journey)
    journey.each { |key, value|
      if key == nil || value == nil
        return false
      else
        return true
      end 
      }
  end
end