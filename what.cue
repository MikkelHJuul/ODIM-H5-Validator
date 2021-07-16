package odim_hdf5

//?? generate ??
sources: {
	"V2_0": =~"^(WMO|RAD|ORG|PLC|CTY|CMT):([^,]+)(,(WMO|RAD|ORG|PLC|CTY|CMT):([^,]+))*$"
	"V2_1": =~"^(WMO|RAD|ORG|PLC|CTY|CMT|NOD):([^,]+?)(,(WMO|RAD|ORG|PLC|CTY|CMT|NOD):([^,]+))*$"
	"V2_2": =~"^(WMO|RAD|ORG|PLC|CTY|CMT|NOD):([^,]+?)(,(WMO|RAD|ORG|PLC|CTY|CMT|NOD):([^,]+))*$"
	"V2_3": =~"^(WMO|RAD|ORG|PLC|CTY|CMT|NOD|WIGOS):([^,]+?)(,(WMO|RAD|ORG|PLC|CTY|CMT|NOD|WIGOS):([^,]+))*$"
	//TODO V2_4 mandatory `NOD` for single-radar products...
	"V2_4": =~"^(WMO|RAD|ORG|PLC|CTY|CMT|NOD|WIGOS):([^,]+?)(,(WMO|RAD|ORG|PLC|CTY|CMT|NOD|WIGOS):([^,]+))*$"
}

//Table 2
#Objects: [
	#VersionEnum & {
		name:        "PVOL"
		description: "Polar volume"
	},
	#VersionEnum & {
		name:        "CVOL"
		description: "Cartesian volume"
	},
	#VersionEnum & {
		name:        "SCAN"
		description: "Polar scan"
	},
	#VersionEnum & {
		name:        "RAY"
		description: "Single polar ray"
	},
	#VersionEnum & {
		name:        "AZIM"
		description: "Azimuthal object"
	},
	#VersionEnum & {
		name:        "ELEV"
		description: "Elevational object"
		versions: ["V2_2", "V2_3", "V2_4"]
	},
	#VersionEnum & {
		name:        "IMAGE"
		description: "2-D cartesian image"
	},
	#VersionEnum & {
		name:        "COMP"
		description: "Cartesian composite image(s)"
	},
	#VersionEnum & {
		name:        "XSEC"
		description: "2-D vertical cross section(s)"
	},
	#VersionEnum & {
		name:        "VP"
		description: "1-D vertical profile"
	},
	#VersionEnum & {
		name:        "PIC"
		description: "Embedded graphical image"
	},
]

#DataWhat: close({
	product?:   #Product //- According to Table 15
	prodname?:  string   //- Product name
	quantity?:  string
	prodpar?:   string  // - According to Table 16 for products. Only used for cartesian products.
	startdate?: #Date   //Starting YYYYMMDD Year, Month, and Day for the product
	starttime?: #Time   //Hour, Minute, and Second for the product
	enddate?:   #Date   // Year, Month, and Day for the product
	endtime?:   #Time   // Hour, Minute, and Second for the product
	gain?:      float64 //- Coefficient in quantity_value = offset + gain × raw_value used to convert to physical unit. Default value is 1.0.
	offset?:    float64 //- Coefficient in quantity_value = offset + gain × raw_value used to convert to physical unit. Default value is 0.0.
	nodata?:    float64 //- Raw value used to denote areas void of data (never radiated). Note that this Attribute is always a float64 even if the data in question is in another format.
	undetect?:  float64 //- Raw value used to denote areas below the measurement detection threshold (radiated but nothing detected). Note that this Attribute is always a float64 even if the data in question is in another format.
})

#Product: {
	"SCAN"//A scan of polar data
} | {
	"PPI"//Plan position indicator (cartesian)
} | {
	"CAPPI"//Constant altitude PPI
} | {
	"PCAPPI"//Pseudo-CAPPI
} | {
	"ETOP"//Echo top
} | {
	"EBASE"//Echo base
} | {
	"MAX"//Maximum
} | {
	"RR"//Accumulation
} | {
	"VIL"//Vertically integrated liquid water
} | {
	"SURF"//Information valid at the Earth’s surface
} | {
	"COMP"//Composite
} | {
	"VP"//Vertical profile
} | {
	"RHI"//Range height indicator
} | {
	"XSEC"//Arbitrary vertical slice
} | {
	"VSP"//Vertical side panel
} | {
	"HSP"//Horizontal side panel
} | {
	"RAY"//Ray
} | {
	"AZIM"//Azimuthal type product
} | {
	"QUAL"//Quality metric
}
