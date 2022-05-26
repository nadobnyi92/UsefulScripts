from dataclasses import dataclass


@dataclass
class Journal:
    """journal data"""
    year: int = 1900
    name: str = ""
    filename: str = ""