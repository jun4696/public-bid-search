from bs4 import BeautifulSoup

from app.parsers.html_parser import HtmlParser


class BidDetailParser:
    def __init__(self):
        self.html_parser = HtmlParser()

    def parse(self, html: str, base_url: str) -> dict:
        soup = self.html_parser.parse(html)

        return {
            "title": self._extract_title(soup),
            "page_number": self._extract_page_number(soup),
            "updated_at": self._extract_updated_at(soup),
            "application_period": self._extract_text_after(
                soup, "募集期間"
            ),
            "business_name": self._extract_text_after(
                soup, "業務名称"
            ),
            "business_period": self._extract_text_after(
                soup, "業務期間"
            ),
            "overview": self._extract_text_after(
                soup, "業務概要"
            ),
            "eligibility": self._extract_text_after(
                soup, "参加資格"
            ),
            "bid_date": self._extract_text_after(
                soup, "入札日時"
            ),
            "documents": self._extract_documents(soup, base_url),
        }

    def _extract_title(self, soup: BeautifulSoup) -> str:
        heading = soup.find("h1")

        if heading:
            return heading.get_text(" ", strip=True)

        if soup.title:
            return soup.title.get_text(" ", strip=True).split("｜")[0]

        return ""

    def _extract_page_number(self, soup: BeautifulSoup) -> str:
        text = soup.get_text("\n", strip=True)
        lines = text.splitlines()

        for line in lines:
            if line.startswith("ページ番号"):
                value = line.replace("ページ番号", "", 1).strip()

                if value.isdigit():
                    return value

        return ""

    def _extract_updated_at(self, soup: BeautifulSoup) -> str:
        return self._extract_text_after(soup, "更新日")

    def _extract_text_after(
        self,
        soup: BeautifulSoup,
        label: str,
    ) -> str:
        text = soup.get_text("\n", strip=True)
        lines = text.splitlines()

        for index, line in enumerate(lines):
            if line == label and index + 1 < len(lines):
                return lines[index + 1]

        return ""

    def _extract_documents(
        self,
        soup: BeautifulSoup,
        base_url: str,
    ) -> list[dict[str, str]]:
        links = self.html_parser.extract_links(soup, base_url)
        documents = []

        extensions = (
            ".pdf",
            ".xlsx",
            ".xls",
            ".docx",
            ".doc",
        )

        for link in links:
            url = link["href"].lower()

            if not url.split("?")[0].endswith(extensions):
                continue

            documents.append(
                {
                    "name": link["text"],
                    "url": link["href"],
                }
            )

        return documents
