package odim_hdf5

#DatasetName: =~"dataset[0-9]{1,3}" // 1000 are quite a lot, but hey, why not??
#DataName:    =~"data[0-9]{1,3}"
#QualityName: =~"quality[0-9]{1,3}"

#Group: {
	how?:  #How
	what?:  #DatasetWhat
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

#_Root: {
	[name=#DatasetName]: #DatasetGroup
	how:                 #How
	what: {
		date: #Date
		time: #Time
	}
}

versionTexts: [name=#supportedVersions]: {
	conventions: string
	what: version: string
}

versionTexts: {
	"V23": {
		conventions: "ODIM_H5/V2_3"
		what: version: "H5rad 2.3"
	}
	"V22": {
		conventions: "ODIM_H5/V2_2"
		what: version: "H5rad 2.2"
	}
	"V21": {
		conventions: "ODIM_H5/V2_1"
		what: version: "H5rad 2.1"
	}
	"V20": {
		conventions: "ODIM_H5/V2_0"
		what: version: "H5rad 2.0"
	}
}

for v, vals in versionTexts {
	quant: or([for q in #Quantities if list.Contains(q.versions, v) {q.name}])
	"#Root\(v)": {
		vals
		#_Root
		what: {
			source: sources[v]
			objects: or([ for o in #Objects if list.Contains(o.versions, v) {o.name}])
		}

		//wheres
		where: or([for g in whereMap[v]["top"] { g } ])
		[name=#DatasetName]: where: or([for g in whereMap[v]["dataset"] { g } ])
		[name=#DatasetName]: [name=#DataName]: where: or([for g in whereMap[v]["data"] { g } ])
		[name=#DatasetName]: [name=#QualityName]: where:  or([for g in whereMap[v]["data"] { g } ])

		[name=#DatasetName]: what: #DataWhat & {
			quantity?: quant
		}
		[name=#DatasetName]: [name=#DataName]: what: #DataWhat & {
			quantity?: quant
		}
		[name=#DatasetName]: [name=#QualityName]: what: #DataWhat & {
			quantity?: quant
		}
		[name=#DatasetName]: [name=#DataName]: [name=#QualityName]: what: #DataWhat & {
			quantity?: quant
		}
	}
}

#RootV21: {
	[name=#DatasetName]: how: azangles: #sequenceOfPairs // should this be done more elaborately?
	[name=#DatasetName]: how: aztimes:  #sequenceOfPairs
}

#RootV20: {
	[name=#DatasetName]: how: azangles: #sequenceOfPairs // should this be done more elaborately?
	[name=#DatasetName]: how: aztimes:  #sequenceOfPairs
}
