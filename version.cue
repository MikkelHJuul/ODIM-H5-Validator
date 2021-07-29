package odim_hdf5

import "strings"

_vs: ["V2_0", "V2_1", "V2_2", "V2_3", "V2_4"]
#supportedVersions: or(_vs)

_from: [Name=#supportedVersions]: [...#supportedVersions]

for i, v in _vs {
	_from: "\(v)": _vs[i:len(_vs)]
}

_v: #supportedVersions
_v: *_vs[len(_vs)-1] | string @tag(version)

_dotVersion: strings.Replace(strings.TrimPrefix(_v, "V"), "_", ".", 1)
