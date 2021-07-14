package odim_hdf5

whereMap: #VersionLocationTree & {
	for w in #whereObjects {
		for v in w.versions {
			"\(v)": {
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
	}
}

//The group RHI and side-panel are not decisively clear on what they mean.
// RHI is interpreted as a group, the side-panel section of the table is interpreted as data/dataset-specific values
whereGroups: ["polar", "vertical", "cross-section", "geo", "RHI"]
allowedWhereGroups: or(whereGroups)

#WhereObject: #VersionObject & {
	groups: [...allowedWhereGroups]
}

#whereObjects: [
	#WhereObject & {
		keys: lat: float
		description: "Latitude position of the radar antenna (degrees). Fractions of a degree are given in decimal notation"
		groups: ["polar", "vertical", "RHI"]
	},
	#WhereObject & {
		keys: lon: float
		description: "Longitude position of the radar antenna (degrees). Fractions of a degree are given in decimal notation"
		groups: ["polar", "vertical", "RHI"]
	},
	#WhereObject & {
		keys: height: float
		description: "Height of the centre of the antenna in meters above sea level."
		groups: ["polar", "vertical"]
	},
	#WhereObject & {
		keys: elangle: float
		description: "  //Antenna elevation angle (degrees) above the horizon."
		groups: ["polar"]
		locations: ["dataset"]
	},
	#WhereObject & {
		keys: elangle: >=0 & <=90
		description: "everything else just doesnt make sense (90 doesn't really either)"
		groups: ["polar"]
		locations: ["dataset"]
	},
	#WhereObject & {
		keys: nbins: int
		description: "Number of range bins in each ray"
		groups: ["polar"]
		locations: ["dataset"]
	},
	#WhereObject & {
		keys: rstart: float
		description: "The range (km) of the start of the first range bin"
		groups: ["polar"]
		locations: ["dataset"]
	},
	#WhereObject & {
		keys: rscale: float
		description: "The distance in meters between two successive range bins"
		groups: ["polar"]
		locations: ["dataset"]
	},
	#WhereObject & {
		keys: nrays: int
		description: "Number of azimuth or elevation gates (rays) in the object"
		groups: ["polar"]
		locations: ["dataset"]
	},
	#WhereObject & {
		keys: a1gate: int
		description: "Index of the first azimuth gate radiated in the scan"
		groups: ["polar"]
		locations: ["dataset"]
	},
	//Sector specific is interpreted as data-specific (the specification is, once again, unclear on this)
	#WhereObject & {
		keys: startaz: float & >=0 & <=360
		description: "The azimuth angle of the start of the first gate in the sector (degrees)"
		groups: ["polar"]
		locations: ["data"]
	},
	#WhereObject & {
		keys: stopaz: float & >=0 & <=360
		description: "The azimuth angle of the end of the last gate in the sector (degrees)"
		groups: ["polar"]
		locations: ["data"]
	},
	#WhereObject & {
		keys: startel: float & >=0 & <=360
		description: "The elevation angle of the start of the first gate in the sector (degrees)"
		groups: ["polar"]
		locations: ["data"]
		versions: ["V23"]
	},
	#WhereObject & {
		keys: stopel: float & >=0 & <=360
		description: "The elevation angle of the end of the last gate in the sector (degrees)"
		groups: ["polar"]
		locations: ["data"]
		versions: ["V23"]
	},
	#WhereObject & {
		keys: projdef: string
		description: "The projection definition arguments, PROJ4 stuff, see specification"
		groups: ["geo"]
	},
	#WhereObject & {
		keys: xsize: int & >0
		description: "Number of pixels in the X dimension"
		groups: ["geo", "cross-section", "RHI"]
	},
	#WhereObject & {
		keys: ysize: int & >0
		description: "Number of pixels in the Y dimension"
		groups: ["geo", "cross-section", "RHI"]
	},
	#WhereObject & {
		keys: zsize: int & >0
		description: "Number of pixels in the Z dimension"
		groups: ["geo"]
		versions: ["V23"]
	},
	#WhereObject & {
		keys: zstart: float
		description: "Height in meters above mean sea level of the lowest pixel in the Z dimension"
		groups: ["geo"]
		versions: ["V23"]
	},
	#WhereObject & {
		keys: zscale: float & >0
		description: "Pixel size in the Z dimension (meters)"
		groups: ["geo"]
		versions: ["V23"]
	},
	#WhereObject & {
		keys: xscale: float & >0
		description: "Pizel size in the X dimension, in projection-specific coordinates (often meters)"
		groups: ["geo", "cross-section", "RHI"]
	},
	#WhereObject & {
		keys: yscale: float & >0
		description: "Pixel size in the Y dimension, in projection-specific coordinates (often meters)"
		groups: ["geo", "cross-section", "RHI"]
	},
	#WhereObject & {
		keys: LL_lon: float
		description: "Longitude of the lower left corner of the lower left pixel"
		groups: ["geo"]
	},
	#WhereObject & {
		keys: LL_lat: float
		description: "Latitude of the lower left corner of the lower left pixel"
		groups: ["geo"]
	},
	#WhereObject & {
		keys: UL_lon: float
		description: "Longitude of the upper left corner of the upper left pixel"
		groups: ["geo"]
	},
	#WhereObject & {
		keys: UL_lat: float
		description: "Latitude of the upper left corner of the upper left pixel"
		groups: ["geo"]
	},
	#WhereObject & {
		keys: UR_lon: float
		description: "Longitude of the upper right corner of the upper right pixel"
		groups: ["geo"]
	},
	#WhereObject & {
		keys: UR_lat: float
		description: "Latitude of the upper right corner of the upper right pixel"
		groups: ["geo"]
	},
	#WhereObject & {
		keys: LR_lon: float
		description: "Longitude of the lower right corner of the lower right pixel"
		groups: ["geo"]
	},
	#WhereObject & {
		keys: LR_lat: float
		description: "Latitude of the lower right corner of the lower right pixel"
		groups: ["geo"]
	},
	#WhereObject & {
		keys: minheight: float
		description: "Minimum height in meters above mean sea level"
		groups: ["cross-section", "vertical", "RHI"]
	},
	#WhereObject & {
		keys: maxheight: float
		description: "Maximum height in meters above mean sea level"
		groups: ["cross-section", "vertical", "RHI"]
	},
	#WhereObject & {
		keys: az_angle: float
		description: "Azimuth angle"
		groups: ["RHI"]
	},
	#WhereObject & {
		keys: range: float
		description: "Maximum range in km"
		groups: ["RHI"]
	},
	#WhereObject & {
		keys: angles: #simpleArrayOfDoubles
		description: "Elevation angles, in degrees, in the order of acquisition"
		groups: ["RHI"]
		versions: ["V20", "V21", "V22"]
	},
	#WhereObject & {
		keys: angles?: #simpleArrayOfDoubles
		description: "Elevation angles, in degrees, in the order of acquisition, DEPRECATED"
		groups: ["RHI"]
		versions: ["V23"]
	},
	#WhereObject & {
		keys: interval: float
		description: "Vertical distance (m) between height intervals, or 0.0 if variable"
		groups: ["vertical"]
	},
	#WhereObject & {
		keys: levels: int & >0
		description: "Number of points in the profile"
		groups: ["vertical"]
	},
	  #WhereObject & {
  	keys: start_lon: float
  	description: "Start position’s longitude"
  	groups: ["cross-section", "RHI"]
  	locations: ["dataset", "data"]
  },
  #WhereObject & {
  	keys: start_lat: float
  	description: "Start position’s latitude"
  	groups: ["cross-section", "RHI"]
  	locations: ["dataset", "data"]
  },
  #WhereObject & {
  	keys: stop_lon: float
  	description: "Stop position’s longitude"
  	groups: ["cross-section", "RHI"]
  	locations: ["dataset", "data"]
  },
  #WhereObject & {
  	keys: stop_lat: float
  	description: "Stop position’s latitude"
  	groups: ["cross-section", "RHI"]
  	locations: ["dataset", "data"]
  },
]