from bs4 import BeautifulSoup

from app.parsers.html_parser import HtmlParser


class BidListParser:
    def __init__(self):
        self.html_parser = HtmlParser()

    def parse(self, html: str, base_url: str) -> list[dict[str, str]]:
        soup = self.html_parser.parse(html)
        links = self.html_parser.extract_links(soup, base_url)

        bids = []

        for link in links:
            text = link["text"]

            # 案件ページと思われるリンクを抽出する。
            # 現段階では対象ページの実HTMLを確認するため、
            # 「業務」「工事」「修繕」「製造」「設計」などを対象にする。
            keywords = (
                "業務",
                "工事",
                "修繕",
                "製造",
                "設計",
            )

            if not any(keyword in text for keyword in keywords):
                continue

            bids.append(
                {
                    "title": text,
                    "url": link["href"],
                }
            )

        return bids
