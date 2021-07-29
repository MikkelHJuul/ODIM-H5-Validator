package odim_hdf5

vs: ["V2_0", "V2_1", "V2_2", "V2_3", "V2_4"]
supportedVersions: or(vs)

from: [name=supportedVersions]: [...supportedVersions]

for i, v in vs {
	from: "\(v)": vs[i:len(vs)]
}

v: *vs[len(vs)-1] | string @tag(version)

versionTexts: [name=supportedVersions]: #VersionItems
versionTexts: {
	"V2_4": #VersionItems & {
		Conventions: "ODIM_H5/V2_4"
		what: version: "H5rad 2.4"
	}
	"V2_3": #VersionItems & {
		Conventions: "ODIM_H5/V2_3"
		what: version: "H5rad 2.3"
	}
	"V2_2": #VersionItems & {
		Conventions: "ODIM_H5/V2_2"
		what: version: "H5rad 2.2"
	}
	"V2_1": #VersionItems & {
		Conventions: "ODIM_H5/V2_1"
		what: version: "H5rad 2.1"
	}
	"V2_0": #VersionItems & {
		Conventions: "ODIM_H5/V2_0"
		what: version: "H5rad 2.0"
	}
}
