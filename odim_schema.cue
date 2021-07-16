package odim_hdf5

import "list"

#DatasetName: =~"dataset[0-9]{1,3}" // 1000 are quite a lot, but hey, why not??
#DataName:    =~"data[0-9]{1,3}"
#QualityName: =~"quality[0-9]{1,3}"

#Group: {
	what?: #DataWhat
}

#DatasetGroup: {
	#Group
	[name=#DataName]:    #DataGroup
	[name=#QualityName]: #QualityGroup
}

#DataGroup: {
	#QualityGroup
	[name=#QualityName]: #QualityGroup
}

#QualityGroup: {
	#Group
	data?:    #Data
	palette?: _ // I have no idea what the structure is of this item
	legend?:  _ // I have no idea what the structure is of this item
}

#Root: {
	[name=#DatasetName]: #DatasetGroup
	what: {
		date: #Date
		time: #Time
	}
}

VersionItems: close({
	Conventions: string
	what: version: string
})

versionTexts: [name=supportedVersions]: VersionItems

versionTexts: {
	"V2_4": VersionItems & {
		Conventions: "ODIM_H5/V2_4"
		what: version: "H5rad 2.4"
	}
	"V2_3": VersionItems & {
		Conventions: "ODIM_H5/V2_3"
		what: version: "H5rad 2.3"
	}
	"V2_2": VersionItems & {
		Conventions: "ODIM_H5/V2_2"
		what: version: "H5rad 2.2"
	}
	"V2_1": VersionItems & {
		Conventions: "ODIM_H5/V2_1"
		what: version: "H5rad 2.1"
	}
	"V2_0": VersionItems & {
		Conventions: "ODIM_H5/V2_0"
		what: version: "H5rad 2.0"
	}
}
v:     *vs[len(vs)-1] | string @tag(version)
quant: or([ for q in #Quantities if list.Contains(q.versions, v) {q.name}])
root: {
	versionTexts[v]
	#Root
	what: {
		source:  sources[v]
		object: or([ for o in #Objects if list.Contains(o.versions, v) {o.name}])
	}
	_how: {for h in Hows if list.Contains(h.versions, v) {h.keys}}
	how?: _how
	[name=#DatasetName]: how?: _how
	[name=#DatasetName]: [name=#DataName]: how?:    _how
	[name=#DatasetName]: [name=#QualityName]: how?: _how

	_whereGroups: {
		for w in whereObjects if list.Contains(w.versions, v) {
			for l in w.locations {
				"\(l)": {
					for g in w.groups {
						"\(g)": {
							w.keys
						}
					}
				}
			}
		}
	}
	where?: or([ for g in _whereGroups["top"] {g}])
	[name=#DatasetName]: where?: or([for g in _whereGroups["dataset"] {g}])
	[name=#DatasetName]: [name=#DataName]: where?:    or([ for g in _whereGroups["data"] {g}])
	[name=#DatasetName]: [name=#QualityName]: where?: or([ for g in _whereGroups["data"] {g}])

	[name=#DatasetName]: what?: #DataWhat & {
		quantity?: quant
	}
	[name=#DatasetName]: [name=#DataName]: what?: #DataWhat & {
		quantity?: quant
	}
	[name=#DatasetName]: [name=#QualityName]: what?: #DataWhat & {
		quantity?: quant
	}
	[name=#DatasetName]: [name=#DataName]: [name=#QualityName]: what?: #DataWhat & {
		quantity?: quant
	}
}
