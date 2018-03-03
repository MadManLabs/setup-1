# -*- coding: utf-8 -*-

from click import secho


class Logger(object):
    '''
    
    '''

    def __init__(self):
        '''
        
        '''

    def __log(self, message, **kwargs):
        '''
        Logs a message to the console, passing arguments to click.secho

        Args:
            **kwargs: Arguments to pass to click.secho. See http://click.pocoo.org/6/api/#utilities for more info.
        '''

        secho(message, **kwargs)


    def log(self, message, silent=False):
        '''
        Log a normal message with no styles applied.

        Args:
            message (str): Message to log
            silent (bool=False): Suppress output. Default is False.
        '''

        if not silent:
            self.__log(message)

    def info(self, message, bold=True, silent=False):
        '''
        Log white-colored text, bold by default.

        Args:
            message (str): Message to log
            bold (bool=True): Bold output. Default is True.
            silent (bool=False): Suppress output. Default is False.
        '''

        if not silent:
            self.__log(message, bold=True, fg='white', )

    def warn(self, message, silent=False):
        '''

        '''

    def error(self, message, silent=False):
        '''

        '''

    def success(self, message, silent=False):
        '''

        '''

