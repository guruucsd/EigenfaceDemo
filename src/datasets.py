"""Contains functions to load CAFE and POFA datasets.
"""
__author__ = 'ttsuchid@ucsd.edu'

from numpy import *
import pickle

def fetch_cafe():
    """Loads The CAlifornia Facial Expressions dataset (CAFE).
    This dataset is available from http://cseweb.ucsd.edu/users/gary/CAFE/ .
    """
    with open('cafe.pkl', 'r') as f:
        return pickle.load(f)

def fetch_pofa():
    """Loads the Pictures of Facial Expression dataset (POFA).
    """
    with open('pofa.pkl', 'r') as f:
        return pickle.load(f)