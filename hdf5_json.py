# This is a sample Python script.

# Press Shift+F10 to execute it or replace it with your code.
# Press Double Shift to search everywhere for classes, files, tool windows, actions, and settings.
import json
import numbers
import sys

import h5py
import numpy as np


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
    di = {k: decode(v) for k, v in dict(g.attrs).items()}
    for k, grp in g.items():
        if isinstance(grp, h5py.Group):
            if k.lower().startswith("data"):
                groups = di.get("groups", [])
                groups.append(unpack_group(grp))
                di["groups"] = groups
            else:
                di[k] = unpack_group(grp)
        elif isinstance(grp, h5py.Dataset):
            di[k] = {k: decode(v) for k, v in dict(grp.attrs).items()}
    return di


def decode(anything):
    if isinstance(anything, numbers.Number):
        return anything
    try:
        return str(anything, 'utf-8')
    except UnicodeDecodeError:
        return str(anything)


# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    f = h5py.File(sys.argv[1], "r")
    print(json.dumps(unpack_group(f), indent=2, cls=NpEncoder))

# See PyCharm help at https://www.jetbrains.com/help/pycharm/
