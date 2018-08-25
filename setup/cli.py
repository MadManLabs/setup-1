# -*- coding: utf-8 -*-

import click
import getpass
import semver
import sys

from strategies.mac import Mac
from utils import echo


required_os_version = '>=10.13.0'
cli_version = '1.0.0'

# strings to be formatted
version_success_msg = 'macOS version %s is allowed, continuing...'
version_err_msg = 'macOS version %s is not allowed. Please update to a version %s to continue.'
welcome = '''
Hello @%s, welcome to setup %s!

This program is designed to help you set up your computer for software development.

Here's a brief summary of what can be installed and configured:

    1. TBD

To start, simply enter your password when prompted.
'''


@click.command()
@click.version_option(cli_version)
@click.option('-v', '--verbose', is_flag=True, help='Enables verbose mode.')
@click.option('-a', '--install-all', is_flag=True, help='Install all programs, languages, and packages.')
@click.option('-d', '--dry-run', is_flag=True, help='Do not actually run any commands, and instead print them out')
def run(verbose, install_all, dry_run):
    echo.info(welcome % (getpass.getuser(), cli_version), bold=True)

    password = getpass.getpass('Enter your password: ')
    computer = Mac(password)

    # make sure macos version is correct
    echo.info('Checking macOS version...')

    if not semver.match(computer.version, required_os_version):
        echo.error(version_err_msg % (computer.version, required_os_version))
        sys.exit(1)
    else:
        echo.success(version_success_msg % computer.version)

    # xcode command line tools
    if not computer.has_command_line_tools:
        echo.info('Installing command line tools...')
        clt_success = computer.install_command_line_tools()

        if not clt_success:
            echo.error('Failed to install Command Line Tools. Try again or run: xcode-select --install', exit=True)

    else:
        echo.info('Command line tools already installed, continuing...')
