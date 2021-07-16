import json
import numbers
import sys
from typing import List

import h5py
import numpy as np

ignore_fields = []


# https://stackoverflow.com/questions/50916422/python-typeerror-object-of-type-int64-is-not-json-serializable/50916741
class NpEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, np.integer):
            return int(obj)
        elif isinstance(obj, np.floating):
            return float(obj)
        elif isinstance(obj, np.ndarray):
            return obj.tolist()
        else:
            return super(NpEncoder, self).default(obj)


def parents(name: str) -> List[str]:
    """hdf5 paths have root slashes
    also must be closest to root parent first, in order to correctly override at lower levels
    i.e. list ordering is relevant: /some/named/group -> ['/group','/some/group']
     """
    string_list = []
    path = name[1:].split("/")  # remove prefixed '/'
    for i in range(0, len(path) - 1):
        string_list += ["/" + "/".join(path[0:i] + [path[len(path) - 1]])]
    return string_list


def unpack_group(h5file_root: h5py.Group, g: h5py.Group) -> dict:
    def attribute_values(attributes: dict) -> dict:  # attributes is a dict-like object
        return {_k: decode(v) for _k, v in attributes.items() if _k not in ignore_fields}
    vals = {}
    if 'how' in g.name or 'where' in g.name:  # to my knowledge only 'how' and 'where' groups inherit
        for p in parents(g.name):
            if parent := h5file_root.get(p, {}):
                vals.update(dict(parent.attrs))
    vals.update(dict(g.attrs))
    di = attribute_values(vals)
    for k, grp in g.items():
        if k in ignore_fields:
            continue
        if isinstance(grp, h5py.Group):
            di[k] = unpack_group(h5file_root, grp)
        elif isinstance(grp, h5py.Dataset):
            # this is a fallback, and should always only be named 'data'
            # don't unpack parent attributes (inheritance) from these
            di[k] = attribute_values(dict(grp.attrs))
    return di


def decode(anything):
    if isinstance(anything, numbers.Number):
        return anything
    try:
        return str(anything, 'utf-8')
    except UnicodeDecodeError:
        return str(anything)


if __name__ == '__main__':
    """
    usage: python hdf5_json.py <some_h5_file> [-- <list of key names to ignore in the tree>]
    """
    f = h5py.File(sys.argv[1], "r")
    if len(sys.argv) > 3 and sys.argv[2] == "--":  # don't trigger if sys.argv[3] cannot be resolved < len is 3 not 2
        ignore_fields = list(sys.argv[3:])
    print(json.dumps(unpack_group(f, f), indent=2, cls=NpEncoder))
