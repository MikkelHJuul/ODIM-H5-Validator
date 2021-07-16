from unittest import TestCase
from hdf5_json import parents


class TestHdf5Json(TestCase):
    def test_parents(self):
        test_l = parents("/some/parent/folder")
        assert test_l == ['/folder', "/some/folder"]  # ordering is relevant
