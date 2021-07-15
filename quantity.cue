package odim_hdf5

import "list"

#Quantities: [...#VersionEnum]

#Quantities: [
	#VersionEnum & {
		name:        "SQI"
		description: "Signal quality index"
		versions: ["V20", "V21"]
	},
	#VersionEnum & {
		name:        "dbz"
		description: "[dBZ] Logged radar reflectivity factor"
		versions: ["V20", "V21"]
	},
	#VersionEnum & {
		name:        "dbz_dev"
		description: "[dBZ] Variability of logged radar reflectivity factor"
		versions: ["V20", "V21"]
	},
	#VersionEnum & {
		name:        "z"
		description: "[Z] Linear radar reflectivity factor"
		versions: ["V20", "V21"]
	},
	#VersionEnum & {
		name:        "z_dev"
		description: "[Z] Variability of linear radar reflectivity factor"
		versions: ["V20", "V21"]
	},
	#VersionEnum & {
		name:        "chi2"
		description: "Chi-square value of wind profile fit"
		versions: ["V20", "V21"]
	},
	#VersionEnum & {
		name:        "rhohv"
		description: "ρhv [0-1] Correlation between Zh and Zv"
		versions: ["V20", "V21"]
	},
	#VersionEnum & {
		name:        "VRAD"
		description: "[m/s] Radial velocity"
		versions: ["V20", "V21", "V22"]
	},
	#VersionEnum & {
		name:        "WRAD"
		description: "[m/s] Spectral width of radial velocity"
		versions: ["V20", "V21", "V22"]
	},
	#VersionEnum & {
		name:        "ZDR"
		description: "ZDR [dB] Logged differential reflectivity"
	},
	#VersionEnum & {
		name:        "RHOHV"
		description: "ρhv [0-1] Correlation between Zh and Zv"
	},
	#VersionEnum & {
		name:        "LDR"
		description: "Ldr [dB] Linear depolarization ratio"
	},
	#VersionEnum & {
		name:        "PHIDP"
		description: "φdp [degrees] Differential phase"
	},
	#VersionEnum & {
		name:        "KDP"
		description: "Kdp [degrees/km] Specific differential phase"
	},
	#VersionEnum & {
		name:        "RATE"
		description: "RR [mm/h] Rain rate"
	},
	#VersionEnum & {
		name:        "ACRR"
		description: "RRaccum. [mm] Accumulated precipitation"
	},
	#VersionEnum & {
		name:        "HGHT"
		description: "H [km] Height above mean sea level"
	},
	#VersionEnum & {
		name:        "VIL"
		description: "VIL [kg/m2] Vertical Integrated Liquid water"
	},
	#VersionEnum & {
		name:        "UWND"
		description: "U [m/s] Component of wind in x-direction"
	},
	#VersionEnum & {
		name:        "VWND"
		description: "V [m/s] Component of wind in y-direction"
	},
	#VersionEnum & {
		name:        "w"
		description: "[m/s] Vertical velocity (positive upwards)"
	},
	#VersionEnum & {
		name:        "w_dev"
		description: "[m/s] Vertical velocity variability"
	},
	#VersionEnum & {
		name:        "div"
		description: "[s−1] Divergence"
	},
	#VersionEnum & {
		name:        "div_dev"
		description: "[s−1] Divergence variation"
	},
	#VersionEnum & {
		name:        "def"
		description: "[s−1] Deformation"
	},
	#VersionEnum & {
		name:        "def_dev"
		description: "[s−1] Deformation variation"
	},
	#VersionEnum & {
		name:        "ad"
		description: "[degrees] Axis of dialation (0-360)"
	},
	#VersionEnum & {
		name:        "ad_dev"
		description: "[degrees] Variability of axis of dialation (0-360)"
	},
	#VersionEnum & {
		name:        "rhohv_dev"
		description: "ρhv [0-1] ρhv variation"
	},
	#VersionEnum & {
		name:        "QIND"
		description: "Quality [0-1] Spatially analyzed quality indicator, according to OPERA II, normalized to between 0 (poorest quality) to 1 (best quality)"
	},
	#VersionEnum & {
		name:        "CLASS"
		description: "Classification Indicates that data are classified and that the classes are specified according to the associated legend object (Section 6.2) whichmust be present."
	},
	#VersionEnum & {
		name:        "ff"
		description: "[m/s] Mean horizontal wind velocity"
	},
	#VersionEnum & {
		name:        "dd"
		description: "[degrees] Mean horizontal wind direction (degrees)"
	},
	#VersionEnum & {
		name:        "ff_dev"
		description: "[m/s] Velocity variability"
	},
	#VersionEnum & {
		name:        "dd_dev"
		description: "[m/s] Direction variability"
	},
	#VersionEnum & {
		name:        "n"
		description: "– Sample size."
		versions: ["V20", "V21", "V22", "V23"]
	},
	#VersionEnum & {
		name:        "BRDR"
		description: "0 or 1 1 denotes a border where data from two or more radars meet incomposites, otherwise 0"
	},
	#VersionEnum & {
		name:        "DBZH"
		description: "Zh [dBZ] Logged horizontally-polarized (corrected) reflectivity factor"
	},
	#VersionEnum & {
		name:        "DBZV"
		description: "Zv [dBZ] Logged vertically-polarized (corrected) reflectivity factor"
	},
	#VersionEnum & {
		name:        "TH"
		description: "Th [dBZ] Logged horizontally-polarized total (uncorrected) reflectivity factor"
	},
	#VersionEnum & {
		name:        "TV"
		description: "Tv [dBZ] Logged vertically-polarized total (uncorrected) reflectivity factor"
	},
	#VersionEnum & {
		name:        "SNR"
		description: "SNR [dB] Signal-to-noise ratio"
	},
	#VersionEnum & {
		name:        "SQIH"
		description: "SQIh [0-1] Signal quality index - horizontally-polarized"
		versions: ["V22", "V23", "V24"]
	},
	#VersionEnum & {
		name:        "USQIH"
		description: "SQIh [0-1] Signal quality index - horizontally-polarized - that has not been subject to a Doppler filter"
		versions: ["V23", "V24"]
	},
	#VersionEnum & {
		name:        "SQIV"
		description: "SQIv [0-1] Signal quality index - vertically-polarized"
		versions: ["V22", "V23", "V24"]
	},
	#VersionEnum & {
		name:        "USQIV"
		description: "SQIv [0-1] Signal quality index - vertically-polarized - that has not been subject to a Doppler filter"
		versions: ["V23", "V24"]
	},
	#VersionEnum & {
		name:        "SNRH"
		description: "SNRh [0-1] Normalized signal-to-noise ratio - horizontally-polarized."
		versions: ["V22", "V23"]
	},
	#VersionEnum & {
		name:        "SNRV"
		description: "SNRv [0-1] Normalized signal-to-noise ratio - vertically-polarized."
		versions: ["V22", "V23"]
	},
	#VersionEnum & {
		name:        "SNRHC"
		description: "SNRh,c [dB] Signal-to-noise ratio co-polar H"
		versions: ["V23", "V24"]
	},
	#VersionEnum & {
		name:        "SNRHX"
		description: "SNRh,x [dB] Signal-to-noise ratio cross-polar H"
		versions: ["V23", "V24"]
	},
	#VersionEnum & {
		name:        "SNRVC"
		description: "SNRv,c [dB] Signal-to-noise ratio co-polar V"
		versions: ["V23", "V24"]
	},
	#VersionEnum & {
		name:        "SNRVX"
		description: "SNRv,x [dB] Signal to noise ratio cross polar V"
		versions: ["V23", "V24"]
	},
	#VersionEnum & {
		name:        "CCORH"
		description: "CCh [dB] Clutter correction - horizontally-polarized"
		versions: ["V22", "V23", "V24"]
	},
	#VersionEnum & {
		name:        "CCORV"
		description: "CCv [dB] Clutter correction - vertically-polarized"
		versions: ["V22", "V23", "V24"]
	},
	#VersionEnum & {
		name:        "VRADH"
		description: "Vrad,h [m/s] Radial velocity - horizontally-polarized. Radial winds towards the radar are negative, while radial winds away from the radar are positive (PANT)."
		versions: ["V22", "V23", "V24"]
	},
	#VersionEnum & {
		name:        "UVRADH"
		description: "Vrad,h [m/s] Radial velocity - horizontally-polarized - that has not been subject to any filter or correction. Radial winds towards the radar are negative, while radial winds away from the radar are positive (PANT)."
		versions: ["V23", "V24"]
	},
	#VersionEnum & {
		name:        "VRADV"
		description: "Vrad,v [m/s] Radial velocity - vertically-polarized. Radial winds towards the radar are negative, while radial winds away from the radar are positive (PANT)."
		versions: ["V22", "V23", "V24"]
	},
	#VersionEnum & {
		name:        "UVRADV"
		description: "Vrad,v [m/s] Radial velocity - vertically-polarized - that has not been subject to any filter or correction. Radial winds towards the radar are negative, while radial winds away from the radar are positive (PANT)."
		versions: ["V23", "V24"]
	},
	#VersionEnum & {
		name:        "VRADDH"
		description: "Vrad,d [m/s] Dealiased horizontally-polarized radial velocity"
		versions: ["V22", "V23", "V24"]
	},
	#VersionEnum & {
		name:        "VRADDV"
		description: "Vrad,d [m/s] Dealiased vertically-polarized radial velocity"
		versions: ["V22", "V23", "V24"]
	},
	#VersionEnum & {
		name:        "WRADH"
		description: "Wrad,h [m/s] Spectral width of radial velocity - horizontally-polarized"
		versions: ["V22", "V23", "V24"]
	},
	#VersionEnum & {
		name:        "UWRADH"
		description: "Wrad,h [m/s] Spectral width of radial velocity - horizontally-polarized - that has not been subject to any filter or correction"
		versions: ["V22", "V23", "V24"]
	},
	#VersionEnum & {
		name:        "WRADV"
		description: "Wrad,v [m/s] Spectral width of radial velocity - vertically-polarized"
		versions: ["V22", "V23", "V24"]
	},
	#VersionEnum & {
		name:        "UWRADV"
		description: "Wrad,v [m/s] Spectral width of radial velocity - vertically-polarized - that has not been subject to any filter or correction"
		versions: ["V23", "V24"]
	},
	#VersionEnum & {
		name:        "PSPH"
		description: "PSP [dBm] Power spectrum peak - horizontally-polarized"
		versions: ["V23", "V24"]
	},
	#VersionEnum & {
		name:        "PSPV"
		description: "PSP [dBm] Power spectrum peak - vertically-polarized"
		versions: ["V23", "V24"]
	},
	#VersionEnum & {
		name:        "UPSPH"
		description: "PSP [dBm] Power spectrum peak - horizontally-polarized - that has not been subject to any filter or correction"
		versions: ["V23", "V24"]
	},
	#VersionEnum & {
		name:        "UPSPV"
		description: "PSP [dBm] Power spectrum peak - vertically-polarized - that has not been subject to any filter or correction"
		versions: ["V23", "V24"]
	},
	#VersionEnum & {
		name:        "DBZH_dev"
		description: "[dBZ] Variability of logged horizontally-polarized (corrected) reflectivity factor"
		versions: ["V22", "V23", "V24"]
	},
	#VersionEnum & {
		name:        "DBZV_dev"
		description: "[dBZ] Variability of logged vertically-polarized (corrected) reflectivity factor"
		versions: ["V22", "V23", "V24"]
	},
	#VersionEnum & {
		name:        "UZDR"
		description: "ZDR [dB] Logged differential reflectivity that has not been subject to a Doppler filter"
		versions: ["V23", "V24"]
	},
	#VersionEnum & {
		name:        "URHOHV"
		description: "ρhv [0-1] Correlation between Zh and Zv that has not been subject to any filter or correction"
		versions: ["V23", "V24"]
	},
	#VersionEnum & {
		name:        "ULDR"
		description: "Ldr [dB] Linear depolarization ratio that has not been subject to a Doppler filter"
		versions: ["V23", "V24"]
	},
	#VersionEnum & {
		name:        "UPHIDP"
		description: "φdp [degrees] Differential phase that has not been subject to any filter or correction"
		versions: ["V23", "V24"]
	},
	#VersionEnum & {
		name:        "PIA"
		description: "PIA [dB] Path Integrated Attenuation"
		versions: ["V23", "V24"]
	},
	#VersionEnum & {
		name:        "UKDP"
		description: "Kdp [degrees/km] Specific differential phase that has not been subject to any filter or correction"
		versions: ["V23", "V24"]
	},
	#VersionEnum & {
		name:        "CPA"
		description: "CPA [0-1] Clutter phase alignment (0: low probability of clutter, 1: high probability of clutter)"
		versions: ["V23", "V24"]
	},
	#VersionEnum & {
		name:        "URATE"
		description: "URR [mm/h] Uncorrected rain rate"
		versions: ["V22", "V23", "V24"]
	},
	#VersionEnum & {
		name:        "POR"
		description: "POR [0-1] Probability of rain (0: low probability, 1: high probability)"
		versions: ["V23", "V24"]
	},
	#VersionEnum & {
		name:        "HI"
		description: "HI [dBZ] Hail intensity"
		versions: ["V22", "V23", "V24"]
	},
	#VersionEnum & {
		name:        "HP"
		description: "HP [%] Hail probability."
		versions: ["V22", "V23"]
	},
	#VersionEnum & {
		name:        "POH"
		description: "POH [0-1] Probability of hail (0: low probability, 1: high probability)"
		versions: ["V23", "V24"]
	},
	#VersionEnum & {
		name:        "POSH"
		description: "POSH [0-1] Probability of severe hail (0: low probability, 1: high probability)"
		versions: ["V23", "V24"]
	},
	#VersionEnum & {
		name:        "MESH"
		description: "MESH [cm] Maximum expected severe hail size"
		versions: ["V23", "V24"]
	},
	#VersionEnum & {
		name:        "RSHR"
		description: "SHRr [m/s km] Radial shear"
		versions: ["V22", "V23", "V24"]
	},
	#VersionEnum & {
		name:        "ASHR"
		description: "SHRa [m/s km] Azimuthal shear"
		versions: ["V22", "V23", "V24"]
	},
	#VersionEnum & {
		name:        "CSHR"
		description: "SHRc [m/s km] Range-azimuthal shear"
		versions: ["V22", "V23", "V24"]
	},
	#VersionEnum & {
		name:        "ESHR"
		description: "SHRe [m/s km] Elevation shear"
		versions: ["V22", "V23", "V24"]
	},
	#VersionEnum & {
		name:        "OSHR"
		description: "SHRo [m/s km] Range-elevation shear"
		versions: ["V22", "V23", "V24"]
	},
	#VersionEnum & {
		name:        "HSHR"
		description: "SHRh [m/s km] Horizontal shear"
		versions: ["V22", "V23", "V24"]
	},
	#VersionEnum & {
		name:        "VSHR"
		description: "SHRv [m/s km] Vertical shear"
		versions: ["V22", "V23", "V24"]
	},
	#VersionEnum & {
		name:        "TSHR"
		description: "SHRt [m/s km] Three-dimensional shear"
		versions: ["V22", "V23", "V24"]
	},
	#VersionEnum & {
		name:        "USNRHC"
		description: "dB Signal-to-noise ratio co-polar H that has not been subject to a Doppler filter. This attribute should be used for a STAR mode radar."
		versions: ["V24"]
	},
	#VersionEnum & {
		name:        "USNRVC"
		description: "dB Signal-to-noise ratio co-polar V that has not been subject to a Doppler filter. This attribute should be used for a STAR mode radar."
		versions: ["V24"]
	},
]

//uncomment test object, then
//		//cue eval quantities.cue types.cue -e test -e testlen
//		//cue help eval  # for more info
//test: list.Sort([for q in #Quantities if list.Contains(q.versions, "V24") {q.name}], list.Ascending)
//testlen: len(test)
