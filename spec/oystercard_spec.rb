require 'oystercard.rb'


  RSpec.describe Oystercard do

  let(:station) { double :station }
  let(:exit_station) {double :exit_station}


it "Should return a balance" do
expect(subject.balance).to be_kind_of Integer
end

it "should respond to top_up method" do
  expect(subject).to respond_to(:top_up).with(1).argument
end

it "top_up should be an integer" do
  expect(subject.top_up(5)).to be_kind_of Numeric
end

it "Should raise and error if balance is going to be greater than 90" do
  expect {subject.top_up(Oystercard::MAXIMUM_BALANCE + 1)}.to raise_error "Maximum is #{Oystercard::MAXIMUM_BALANCE} DENIED"
end

# it "Should be an integer" do
#   expect(subject.new_balance(1)).to be_kind_of Numeric
# end

  it "should check that top_up changes by the given value" do
    expect { subject.top_up(3) }.to change { subject.balance }. by(3)
  end


# it "should return an Integer" do
#   allow(subject).to receive(:balance).and_return(20)
#   expect(subject.deduct(3)).to be_kind_of Integer
# end

# it 'deducts an amount from the balance' do
#   subject.top_up(20)
#   expect{ subject.deduct 3}.to change{ subject.balance }.by -3
# end

# it "records station that journey begins at" do
#   subject.top_up(5)
#   subject.touch_in(station)
#   expect(subject.entry_station).to eq(station)

# it "checks the card is in use" do
#   expect(subject.in_journey?).to be false
# end

# it "returns the oystercard back to a state of false" do
#   subject.top_up(5)
#   subject.touch_in(station)
#   subject.touch_out(exit_station)
#   expect(subject.in_journey?).to eq false
# end

it "Raises an error for minimum fare" do
  subject.top_up(5)
  expect(subject.touch_in(station)).to raise_error "not enough money, please top up" if subject.balance < Oystercard::MINIMUM_FARE
end

it "deducts fare from balance when touched out" do
  subject.top_up(5)
  subject.touch_in(station)
  expect { subject.touch_out(exit_station) }.to change { subject.balance }. by (-Oystercard::MINIMUM_FARE)
end

it "stores the most recent journey and pushes to the array" do
  exit_station = double (:exit_station)
  subject.top_up(5)
  subject.touch_in(station)
  subject.touch_out(exit_station)
  expected_hash = { station => exit_station }
  expect(subject.journeys[-1]).to eq expected_hash
end

end
