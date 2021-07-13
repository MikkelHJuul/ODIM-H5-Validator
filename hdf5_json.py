import json
import numbers
import sys

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


def unpack_group(g: h5py.Group) -> dict:
    def attribute_values(attributes: dict) -> dict:  # attributes is a dict-like object
        return {_k: decode(v) for _k, v in attributes.items() if _k not in ignore_fields}
    di = attribute_values(dict(g.attrs))
    for k, grp in g.items():
        if k in ignore_fields:
            continue
        if isinstance(grp, h5py.Group):
            di[k] = unpack_group(grp)
        elif isinstance(grp, h5py.Dataset):
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
    print(json.dumps(unpack_group(f), indent=2, cls=NpEncoder))
