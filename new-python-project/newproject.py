from sys import argv
import os
from os import path
name = argv[1]
os.mkdir(name)
os.chdir(name)
os.mkdir(name)
os.mkdir("bin")
os.mkdir("tests")
os.mkdir("docs")
file_path = path.join(os.getcwd(),name,"__init__.py")
open(path.abspath(file_path),'w')
file_path = path.join(os.getcwd(),"tests","__init__.py")
open(path.abspath(file_path),'w')
file_path = path.join(os.getcwd(),"setup.py")
setup_py = open(path.abspath(file_path),'w')
setup_code = '''\
try:
    from setuptools import setup
except ImportError:
    from distutils.core import setup

config = {
    'author': 'harunurhan',
    'author_email': 'harunurhan17@gmail.com',
    'version': '0.1',
    'install_requires': ['nose'],
    'packages': ['%s'],
    'scripts': [],
    'name': '%s'
}
setup(**config)
''' %(name,name)
setup_py.write(setup_code)
setup_py.close()
file_path = path.join(os.getcwd(),"tests",name+"_tests.py")
tests_py = open(path.abspath(file_path),'w')
tests_code = '''\
from nose.tools import *
import %s

def setup():
    print "SETUP!"

def teardown():
    print "TEAR DOWN!"

def test_basic():
    print "I RAN!"
''' %name
tests_py.write(tests_code)
tests_py.close()
os.system("nosetests")
