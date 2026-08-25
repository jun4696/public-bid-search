require "rails_helper"

RSpec.describe Bid, type: :model do
  describe "associations" do
    it "has many bid_sources" do
      association = described_class.reflect_on_association(:bid_sources)

      expect(association.macro).to eq(:has_many)
    end

    it "has many sources through bid_sources" do
      association = described_class.reflect_on_association(:sources)

      expect(association.macro).to eq(:has_many)
      expect(association.options[:through]).to eq(:bid_sources)
    end

    it "has many bid_documents" do
      association = described_class.reflect_on_association(:bid_documents)

      expect(association.macro).to eq(:has_many)
    end
  end

  describe "validations" do
    it "is valid with a title" do
      bid = described_class.new(
        title: "沖縄県庁舎清掃業務委託"
      )

      expect(bid).to be_valid
    end

    it "is invalid without a title" do
      bid = described_class.new(
        title: nil
      )

      expect(bid).to be_invalid
    end
  end
end
