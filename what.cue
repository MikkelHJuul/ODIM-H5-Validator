package odim_hdf5

//?? generate ??
sources: {
	"V2_0": =~"^(WMO|RAD|ORG|PLC|CTY|CMT):([^,]+)(,(WMO|RAD|ORG|PLC|CTY|CMT):([^,]+))*$"
	"V2_1": =~"^(WMO|RAD|ORG|PLC|CTY|CMT|NOD):([^,]+?)(,(WMO|RAD|ORG|PLC|CTY|CMT|NOD):([^,]+))*$"
	"V2_2": =~"^(WMO|RAD|ORG|PLC|CTY|CMT|NOD):([^,]+?)(,(WMO|RAD|ORG|PLC|CTY|CMT|NOD):([^,]+))*$"
	"V2_3": =~"^(WMO|RAD|ORG|PLC|CTY|CMT|NOD|WIGOS):([^,]+?)(,(WMO|RAD|ORG|PLC|CTY|CMT|NOD|WIGOS):([^,]+))*$"
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
	product?:   string //- According to Table 15
	prodname?:  string //- Product name
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

#Product: [
	#VersionEnum & {
		name:        "SCAN"
		description: "A scan of polar data"
	},
	#VersionEnum & {
		name:        "PPI"
		description: "Plan position indicator (cartesian)"
	},
	#VersionEnum & {
		name:        "CAPPI"
		description: "Constant altitude PPI"
	},
	#VersionEnum & {
		name:        "PCAPPI"
		description: "Pseudo-CAPPI"
	},
	#VersionEnum & {
		name:        "ETOP"
		description: "Echo top"
	},
	#VersionEnum & {
		name:        "EBASE"
		description: "Echo base"
		versions:    from["V2_3"]
	},
	#VersionEnum & {
		name:        "MAX"
		description: "Maximum"
	},
	#VersionEnum & {
		name:        "RR"
		description: "Accumulation"
	},
	#VersionEnum & {
		name:        "VIL"
		description: "Vertically integrated liquid water"
	},
	#VersionEnum & {
		name:        "SURF"
		description: "Information valid at the Earth’s surface"
		versions:    from["V2_2"]
	},
	#VersionEnum & {
		name:        "COMP"
		description: "Composite"
	},
	#VersionEnum & {
		name:        "VP"
		description: "Vertical profile"
	},
	#VersionEnum & {
		name:        "RHI"
		description: "Range height indicator"
	},
	#VersionEnum & {
		name:        "XSEC"
		description: "Arbitrary vertical slice"
	},
	#VersionEnum & {
		name:        "VSP"
		description: "Vertical side panel"
	},
	#VersionEnum & {
		name:        "HSP"
		description: "Horizontal side panel"
	},
	#VersionEnum & {
		name:        "RAY"
		description: "Ray"
	},
	#VersionEnum & {
		name:        "AZIM"
		description: "Azimuthal type product"
	},
	#VersionEnum & {
		name:        "QUAL"
		description: "Quality metric"
	},
]
