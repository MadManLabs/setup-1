# -*- coding: utf-8 -*-

import sys
from click import secho


def __log(message, silent, **kwargs):
    if not silent:
        secho(message + '\n', **kwargs)


def info(message, bold=False, silent=False):
    __log(message, silent, bold=bold, fg='white')


def warn(message, bold=True, silent=False):
    __log(message, silent, bold=bold, fg='yellow')


def error(message, bold=True, silent=False, exit=False):
    __log(message, silent, bold=bold, fg='red', err=True)

    if exit:
        sys.exit(1)


def success(message, bold=True, silent=False):
    __log(message, silent, bold=bold, fg='green')
