from urllib.parse import urljoin

from bs4 import BeautifulSoup


class HtmlParser:
    def parse(self, html: str) -> BeautifulSoup:
        return BeautifulSoup(html, "html.parser")

    def extract_links(
        self,
        soup: BeautifulSoup,
        base_url: str | None = None,
    ) -> list[dict[str, str]]:
        links = []

        for link in soup.find_all("a", href=True):
            text = link.get_text(" ", strip=True)
            href = link["href"]

            if not text:
                continue

            if base_url:
                href = urljoin(base_url, href)

            links.append(
                {
                    "text": text,
                    "href": href,
                }
            )

        return links
