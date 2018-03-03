# -*- coding: utf-8 -*-

try:
    from setuptools import setup
except ImportError:
    from distutils.core import setup

config = {
    'name': 'setup-cli',
    'version': '1.0.0',
    'description': 'Set up a computer for software development',
    'author': 'Ty-Lucas Kelley',
    'author_email': 'tylucaskelley@gmail.com',
    'license': 'MIT',
    'url': 'https://github.com/tylucaskelley/setup',
    'long_description': open('README.md').read(),
    'classifiers': [
        'Development Status :: 5 - Production/Stable',
        'Intended Audience :: Developers',
        'Natural Language :: English',
        'License :: OSI Approved :: MIT License',
        'Operating System :: MacOS :: MacOS X',
        'Programming Language :: Python',
        'Programming Language :: Python :: 2.7',
        'Topic :: Software Development :: Libraries :: Python Modules',
        'Topic :: Utilities'
    ],
    'entry_points': {
        'console_scripts': [
            'setup = setup:main'
        ]
    },
    'keywords': [
        'cli',
        'macos',
        'env',
        'homebrew',
        'automation'
    ],
    'packages': [
        'setup'
    ],
    'package_dir': {
        'setup': 'setup'
    }
}

setup(**config)
