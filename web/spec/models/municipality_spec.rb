require "rails_helper"

RSpec.describe Municipality, type: :model do
  describe "associations" do
    it "has many sources" do
      association = described_class.reflect_on_association(:sources)

      expect(association.macro).to eq(:has_many)
    end
  end

  describe "validations" do
    it "is valid with a name and prefecture" do
      municipality = described_class.new(
        name: "沖縄県",
        prefecture: "沖縄県"
      )

      expect(municipality).to be_valid
    end

    it "is invalid without a name" do
      municipality = described_class.new(
        name: nil,
        prefecture: "沖縄県"
      )

      expect(municipality).to be_invalid
    end

    it "is invalid without a prefecture" do
      municipality = described_class.new(
        name: "沖縄県",
        prefecture: nil
      )

      expect(municipality).to be_invalid
    end
  end
end
