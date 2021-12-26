#!/usr/bin/python3

import os
import sys

def get_audio_files( path ):
    audio_files = []
    AUDIO_EXTENSIONS=[ '.mp3', '.flac', '.wav', '.m4a' ]
    for root, subFolder, files in os.walk( path ):
        for item in files:
            if any( item.endswith( ext ) for ext in AUDIO_EXTENSIONS ) :
                audio_files.append( os.path.relpath( os.path.join(root, item), path ) )
    return audio_files
    

def create_m3u( files ):
    TEMPLATE_FILE='''
    #EXTM3U
    {}'''

    TEMPLATE_SECTION='''
    #EXTINF:,
    {}'''

    sections = [ TEMPLATE_SECTION.format(f) for f in files ]

    return TEMPLATE_FILE.format( '\n'.join( sections ) )

def create_playlist_name( path ):
    filename = os.path.basename( os.path.dirname( path ) ) + ".m3u8"
    return path + filename

if __name__=='__main__':
    if len( sys.argv ) == 1:
        exit( 0 )
    path = sys.argv[1]
    with open( create_playlist_name( path ), 'w' ) as f:
        f.write( create_m3u( get_audio_files( path ) ) )

