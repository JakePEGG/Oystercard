require 'journey'

  RSpec.describe Journey do

    it "changes state of oystercard to be in journey" do
      subject.create_journey("")
      expect(subject.in_journey?).to eq true
    end

#     it "expects penalty fare when there's no touch_in data" do
#       expect(subject.fare)to eq fare:PENALTY_FARE
#
# end
  end
