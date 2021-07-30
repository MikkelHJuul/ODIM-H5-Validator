package odim_hdf5

import "list"

Conventions: "ODIM_H5/\(_v)"
what: {
	version: "H5rad \(_dotVersion)"
	date:    #Date
	time:    #Time
	source:  =~#whatSourceRegex
	object:  or([ for o in _objects if list.Contains(o.versions, _v) {o.name}])
	if _singleSite {
		source: =~".*NOD.*" //MUST contain NOD!
	}
}

how?: #How

where?: #TopWhere

[Name=#DatasetName]: #DatasetGroup
