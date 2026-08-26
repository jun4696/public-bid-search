import requests


class HttpFetcher:
    def __init__(self, timeout: int = 30):
        self.timeout = timeout

    def fetch(self, url: str) -> requests.Response:
        response = requests.get(
            url,
            timeout=self.timeout,
            headers={
                "User-Agent": "public-bid-search/0.1"
            },
        )
        response.raise_for_status()

        # HTTPヘッダーの文字コード指定が不正な場合があるため、
        # requestsが推測した文字コードを使用する。
        if response.apparent_encoding:
            response.encoding = response.apparent_encoding

            
        return response
