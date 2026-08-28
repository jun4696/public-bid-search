require "rails_helper"

RSpec.describe Source, type: :model do
  describe "associations" do
    it "belongs to a municipality" do
      association = described_class.reflect_on_association(:municipality)

      expect(association.macro).to eq(:belongs_to)
    end

    it "has many bid_sources" do
      association = described_class.reflect_on_association(:bid_sources)

      expect(association.macro).to eq(:has_many)
    end

    it "has many bids through bid_sources" do
      association = described_class.reflect_on_association(:bids)

      expect(association.macro).to eq(:has_many)
      expect(association.options[:through]).to eq(:bid_sources)
    end
  end

  describe "validations" do
    let(:municipality) do
      Municipality.new(
        name: "沖縄県",
        prefecture: "沖縄県"
      )
    end

    it "is valid with required attributes" do
      source = described_class.new(
        municipality: municipality,
        name: "沖縄県 入札情報",
        source_system: "html",
        url: "https://example.com/bids"
      )

      expect(source).to be_valid
    end

    it "is invalid without a name" do
      source = described_class.new(
        municipality: municipality,
        name: nil,
        source_system: "html",
        url: "https://example.com/bids"
      )

      expect(source).to be_invalid
    end

    it "is invalid without a source_system" do
      source = described_class.new(
        municipality: municipality,
        name: "沖縄県 入札情報",
        source_system: nil,
        url: "https://example.com/bids"
      )

      expect(source).to be_invalid
    end

    it "is invalid without a url" do
      source = described_class.new(
        municipality: municipality,
        name: "沖縄県 入札情報",
        source_system: "html",
        url: nil
      )

      expect(source).to be_invalid
    end
  end
end
