from bs4 import BeautifulSoup
import re


class RadioLocmanMainPageParser:
    """get journals pages by html"""
    def __init__( self, content ):
        self.soup = BeautifulSoup(content, "html.parser")

    def get_links( self ) -> set:
        """get journals pages links

        Returns:
            set: container with loaded journals
        """
        links = set()
        for table in self.soup.select('#my_center > div.colcenter > table'):
            is_journal_link = lambda x: x['href'].startswith('/book')
            links.update( link['href'] for link in table.find_all('a') if is_journal_link( link ) )
        return links


class RadioLocmanPageParser:
    """reading journal data by html page"""
    def __init__( self, content ):
        self.soup = BeautifulSoup(content, "html.parser")

    def get_year( self ) -> int:
        """get journal year from html page

        Args:
            soup (BeautifulSoup): parsed page

        Returns:
            int: journal year
        """
        b_tags = (tag.contents[0] for tag in self.soup.select( 'article > table' )[0].find_all('b'))
        is_numeric_tag = lambda x: isinstance(x, str) and x.isnumeric()
        year = next( int( tag ) for tag in b_tags if is_numeric_tag( tag ) )
        return year

    def get_name( self ) -> str:
        """get journal name from html page

        Args:
            soup (BeautifulSoup): parsed page

        Returns:
            str: journal name
        """
        return self.soup.select( 'article > h1' )[0].contents[0]

    def get_link( self ) -> str:
        """get journal file link from html page

        Args:
            soup (BeautifulSoup): parsed page

        Returns:
            str: journal file link
        """
        base_link='https://www.rlocman.ru/forum/'
        regexp = r'krfilesmanager.php\?do=downloadfile&dlfileid=[0-9]*'
        pattern = lambda x: re.search( regexp, x['href'] )
        links = ( pattern( link ) for link in self.soup.select( 'article > div.my_content > p > a' ) )
        return next( base_link + link.group(0) for link in links if link )
