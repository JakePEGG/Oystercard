require_relative 'journey'

class Oystercard
  attr_reader :balance, :deduct, :entry_station, :journeys, :exit_station

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  PENALTY_FARE = 6


  def initialize(balance = 0, journey = Journey.new)
    @balance = balance
    @journeys = journey.journeys_array
    @journey = journey
  end

  def top_up(amount)
    raise "Maximum is 90 DENIED" if @balance + amount > MAXIMUM_BALANCE
    return new_balance(amount)
  end

  def new_balance(amount)
    @balance += amount
    return @balance
  end

  def touch_in(station)
    fail "not enough money, please top up" if @balance < MINIMUM_FARE

    @journey.create_journey(station)

  end

  def touch_out(exit_station)
    deduct(fare)

    @journey.end_journey(exit_station)

  end

  def fare
    if journeys[-1].include? nil
      PENALTY_FARE
    else
      MINIMUM_FARE
    end
  end

  private

  def deduct(amount)
  @balance -= amount
  end

end
