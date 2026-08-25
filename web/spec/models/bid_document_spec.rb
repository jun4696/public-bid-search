require "rails_helper"

RSpec.describe BidDocument, type: :model do
  describe "associations" do
    it "belongs to a bid" do
      association = described_class.reflect_on_association(:bid)

      expect(association.macro).to eq(:belongs_to)
    end
  end

  describe "validations" do
    let(:bid) do
      Bid.new(
        title: "沖縄県庁舎清掃業務委託"
      )
    end

    it "is valid with required attributes" do
      document = described_class.new(
        bid: bid,
        name: "入札公告.pdf",
        format: "pdf",
        url: "https://example.com/documents/123.pdf",
        fetched_at: Time.current
      )

      expect(document).to be_valid
    end

    it "is invalid without a name" do
      document = described_class.new(
        bid: bid,
        name: nil,
        format: "pdf",
        url: "https://example.com/documents/123.pdf",
        fetched_at: Time.current
      )

      expect(document).to be_invalid
    end

    it "is invalid without a format" do
      document = described_class.new(
        bid: bid,
        name: "入札公告.pdf",
        format: nil,
        url: "https://example.com/documents/123.pdf",
        fetched_at: Time.current
      )

      expect(document).to be_invalid
    end

    it "is invalid without a url" do
      document = described_class.new(
        bid: bid,
        name: "入札公告.pdf",
        format: "pdf",
        url: nil,
        fetched_at: Time.current
      )

      expect(document).to be_invalid
    end

    it "is invalid without a fetched_at" do
      document = described_class.new(
        bid: bid,
        name: "入札公告.pdf",
        format: "pdf",
        url: "https://example.com/documents/123.pdf",
        fetched_at: nil
      )

      expect(document).to be_invalid
    end
  end
end
