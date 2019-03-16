require_relative 'Oystercard'

class Journey

  attr_reader :journeys_array, :exit_station, :entry_station, :PENALTY_FARE

  def initialize
    @journeys_array = []
    @entry_station = nil
  end

  def in_journey?
    @entry_station.nil? ? false : true
  end

  def create_journey(station)
    @entry_station = station
    current_journey = { entry_station => nil }
    @journeys_array.push(current_journey)
  end

  def end_journey(exit_station)
    if @entry_station == nil
      current_journey = { nil => exit_station } 
    else
    @exit_station = exit_station
    store_journey
    @entry_station = nil
    @exit_station = nil
  end
  end

private

  def store_journey
    current_journey = journeys_array[-1]
    current_journey[@entry_station] = exit_station
  end

end
