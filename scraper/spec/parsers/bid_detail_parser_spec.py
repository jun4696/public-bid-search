import unittest

from app.fetchers.http_fetcher import HttpFetcher
from app.parsers.bid_detail_parser import BidDetailParser


URL = "https://www.pref.okinawa.lg.jp/shigoto/nyusatsukeiyaku/1015342/1025081/1037588/1041135.html"


class BidDetailParserTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        response = HttpFetcher().fetch(URL)

        if response.status_code != 200:
            raise RuntimeError(
                f"HTTP request failed: {response.status_code}"
            )

        cls.bid = BidDetailParser().parse(response.text, URL)

    def test_title(self):
        self.assertEqual(
            self.bid["title"],
            "読谷高校火災受信機取替工事に係る一般競争入札",
        )

    def test_page_number(self):
        self.assertEqual(self.bid["page_number"], "1041135")

    def test_updated_at(self):
        self.assertEqual(
            self.bid["updated_at"],
            "2026年8月21日",
        )

    def test_business_name(self):
        self.assertEqual(
            self.bid["business_name"],
            "読谷高校　火災受信機取替工事",
        )

    def test_bid_date(self):
        self.assertEqual(
            self.bid["bid_date"],
            "令和8年9月10日（木曜日）　午前10時",
        )

    def test_documents(self):
        self.assertEqual(len(self.bid["documents"]), 10)

    def test_documents_include_pdf_and_excel(self):
        urls = [document["url"] for document in self.bid["documents"]]

        self.assertTrue(
            any(url.lower().endswith(".pdf") for url in urls)
        )

        self.assertTrue(
            any(url.lower().endswith(".xlsx") for url in urls)
        )


if __name__ == "__main__":
    unittest.main()
