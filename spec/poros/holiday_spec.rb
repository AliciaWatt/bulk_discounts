require "rails_helper"

RSpec.describe Holiday do
  describe "it has attributes" do
    it "initialize" do
      holiday = Holiday.new({name: "Christmas", date: "2022-12-25"})

      expect(holiday.name).to eq("Christmas")
      expect(holiday.date).to eq("2022-12-25")
    end
  end

  describe ".instance methods" do
    it "format_date" do
      holiday = Holiday.new({name: "Christmas", date: "2022-12-25"})

      expect(holiday.format_date).to eq("December 25, 2022")
    end
  end
end
