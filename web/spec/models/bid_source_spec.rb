require "rails_helper"

RSpec.describe BidSource, type: :model do
  describe "associations" do
    it "belongs to a bid" do
      association = described_class.reflect_on_association(:bid)

      expect(association.macro).to eq(:belongs_to)
    end

    it "belongs to a source" do
      association = described_class.reflect_on_association(:source)

      expect(association.macro).to eq(:belongs_to)
    end
  end

  describe "validations" do
    let(:bid) do
      Bid.new(
        title: "沖縄県庁舎清掃業務委託"
      )
    end

    let(:municipality) do
      Municipality.new(
        name: "沖縄県",
        prefecture: "沖縄県"
      )
    end

    let(:source) do
      Source.new(
        municipality: municipality,
        name: "沖縄県 入札情報",
        source_system: "html",
        url: "https://example.com/bids"
      )
    end

    it "is valid with required attributes" do
      bid_source = described_class.new(
        bid: bid,
        source: source,
        format: "html",
        source_url: "https://example.com/bids/123",
        fetched_at: Time.current
      )

      expect(bid_source).to be_valid
    end

    it "is invalid without a format" do
      bid_source = described_class.new(
        bid: bid,
        source: source,
        format: nil,
        source_url: "https://example.com/bids/123",
        fetched_at: Time.current
      )

      expect(bid_source).to be_invalid
    end

    it "is invalid without a source_url" do
      bid_source = described_class.new(
        bid: bid,
        source: source,
        format: "html",
        source_url: nil,
        fetched_at: Time.current
      )

      expect(bid_source).to be_invalid
    end

    it "is invalid without a fetched_at" do
      bid_source = described_class.new(
        bid: bid,
        source: source,
        format: "html",
        source_url: "https://example.com/bids/123",
        fetched_at: nil
      )

      expect(bid_source).to be_invalid
    end
  end
end
