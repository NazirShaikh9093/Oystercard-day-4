require_relative '../lib/station.rb'
require_relative '../lib/journey.rb'

class Oystercard
attr_reader :balance, :MINIMUM_FARE, :entry_station, :exit_station, :journey_class, :journeys

MAX_LIMIT = 90

  def initialize(balance=0, minimum_fare=1, journey_class=Journey.new)
    @balance = balance
    @MINIMUM_FARE = minimum_fare
    @journey_class = journey_class
    @journey_history = []
  end

  def top_up(amount)
    fail "Reached max limit of £90" if reached_limit?(amount)
    @balance += amount
  end

  def touch_in(station)
    raise ("You need at least #{@MINIMUM_FARE} to touch in") if under_fare?
    @journey_class.start_journey(station)
  end

  def touch_out(station)
    @journey_history << @journey_class.finish_journey(station)
    self.deduct(@journey_class.fare)
  end

  private
  def deduct(value)
    @balance -= value
  end

  def reached_limit?(amount)
    @balance + amount > MAX_LIMIT
  end

  def under_fare?
    @balance < @MINIMUM_FARE
  end
end
