# -*- coding: utf-8 -*-

import os
import platform
import subprocess


class Mac(object):
    '''
    Provides utility functions for working with a macOS computer.

    Attributes:
        version (str): macOS version
    '''

    def __init__(self, password):
        '''
        Creates an instance of the Mac class.

        Args:
           password (str): User's password
        '''

        machine_os = platform.uname()[0]

        if machine_os != 'Darwin':
            raise ValueError('Host machine is not a Mac; got %s' % machine_os)

        self.__password = password

        self.version = platform.mac_ver()[0]
        self.command_line_tools_path = '/Library/Developer/CommandLineTools'

    def __run(self, args_list, is_sudo=False):
        '''
        Runs a shell command using subprocess.Popen

        Args:
            args_list (list): List containing command line inputs, i.e. ['cat', '/path/to/file']
            is_sudo (bool=False): Whether or not to run as sudo with password.

        Returns:
            tuple: stdout, stderr, return code
        '''

        try:
            pipe = subprocess.PIPE
            proc = subprocess.Popen(args_list, stdin=pipe, stdout=pipe, stderr=pipe, universal_newlines=True)

            if is_sudo:
                out, err = proc.communicate(self.__password + '\n')
            else:
                out, err = proc.communicate()

            return (out, err, proc.returncode)
        except OSError as err:
            raise err  # need to handle this error much better

    def cmd(self, command):
        '''
        Run a shell command.

        Args:
            command (str): Shell command to execute

        Returns:
            tuple: stdout, stderr, return code
        '''

        args = command.split()
        return self.__run(args)

    def sudo(self, command):
        '''
        Run a shell command as superuser.

        Args:
            command (str)

        Returns:
            tuple: stdout, stderr, return code
        '''

        args = ['sudo', '-S'] + command.split()
        return self.__run(args, is_sudo=True)

    def has_command_line_tools(self):
        '''
        Checks for the existence of the XCode Command Line Tools

        Returns:
            bool: True if installed, False if not
        '''

        # same way Homebrew does it
        git_exists = os.path.isfile(self.command_line_tools_path + '/usr/bin/git')
        iconv_exists = os.path.isfile('/usr/include/iconv.h')

        return True if git_exists and iconv_exists else False

    def install_command_line_tools(self):
        '''
        Install the XCodeCommand Line Tools

        Returns:
            bool: True if succeeded, False if failed
        '''

        # tell 'softwareupdate' to include Command Line Tools
        tmp_file = '/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress'
        self.sudo('/usr/bin/touch %s' % tmp_file)

        # install tools
        clt_label = 'softwareupdate -l | grep "\*.*Command Line" | head -n 1 | awk -F"*" "{print $2}" | sed -e "s/^ *//" | tr -d "\n"'
        self.sudo('/usr/sbin/softwareupdate -i %s' % clt_label)

        # clean up
        self.sudo('/bin/rm -f ' % tmp_file)
        self.sudo('/usr/bin/xcode-select --switch %s' % self.command_line_tools_path)

        return True if self.has_command_line_tools() else False

