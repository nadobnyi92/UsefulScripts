import time
from pathlib import Path # pylint: disable=missing-module-docstring
from urllib.request import urlopen
from urllib.request import urlretrieve
from urllib.request import Request
import logging
import traceback
from journal import Journal
from journal_parser import RadioLocmanMainPageParser, RadioLocmanPageParser

class JournalManager:
    """Manage local journals storage"""
    def __init__( self, path: Path ) -> None:
        self._path = path
        self.journals = []
        self.load()

    def load( self ) -> None:
        """get loaded journals info"""

    def reload( self ) -> None:
        """load journals from remoute url"""
        main_url = 'https://www.rlocman.ru'
        req = Request(main_url+'/magazine')
        #req.add_header('User-Agent', UserAgent().chrome)
        main_page = urlopen(req).read().decode('utf-8')
        parser = RadioLocmanMainPageParser( main_page )
        for link in parser.get_links():
            try:
                page = urlopen( main_url + link ).read().decode( 'utf-8' )
                journal = self.parse_journal_page( page )
                self.journals.append( journal )
                logging.log( logging.INFO, f"read journal {journal}" )
            except Exception as err:
                logging.log( logging.ERROR, f"""failed read journal {main_url + link}: {err}
                            {traceback.format_exc()}""" )
            time.sleep(0.5) # TODO remove it

    def parse_journal_page(self, content: str ) -> Journal:
        """parse journal page and download it

        Args:
            content (str): page content

        Returns:
            Journal: parsed journal data
        """
        parser = RadioLocmanPageParser( content )
        journal = Journal()
        journal.year = parser.get_year()
        journal.name = parser.get_name()
        journal_path = self._path / str( journal.year )
        if not journal_path.exists():
            journal_path.mkdir( parents=True )
        journal.filename = journal_path / (journal.name + '.jpg')
        urlretrieve(parser.get_link(), journal.filename)
        return journal

if __name__=='__main__':
    logging.basicConfig( level=logging.DEBUG, filename='parser.log', filemode='w',
                        format='%(levelname)s - %(message)s' )
    STORAGE_PATH=Path.home() / '.local' / 'radio_locman'
    radio_locman = JournalManager( STORAGE_PATH )
    radio_locman.reload()
