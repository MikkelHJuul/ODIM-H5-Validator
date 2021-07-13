package odim_hdf5

import "list"

#Quantity: close({
	name:        string
	description: string
	versions:    [...#supportedVersions] | *vs
})

#Quantities: [...#Quantity]

#Quantities: [
	#Quantity & {
		name:        "SQI"
		description: "Signal quality index"
		versions: ["V20", "V21"]
	},
	#Quantity & {
		name:        "dbz"
		description: "[dBZ] Logged radar reflectivity factor"
		versions: ["V20", "V21"]
	},
	#Quantity & {
		name:        "dbz_dev"
		description: "[dBZ] Variability of logged radar reflectivity factor"
		versions: ["V20", "V21"]
	},
	#Quantity & {
		name:        "z"
		description: "[Z] Linear radar reflectivity factor"
		versions: ["V20", "V21"]
	},
	#Quantity & {
		name:        "z_dev"
		description: "[Z] Variability of linear radar reflectivity factor"
		versions: ["V20", "V21"]
	},
	#Quantity & {
		name:        "chi2"
		description: "Chi-square value of wind profile fit"
		versions: ["V20", "V21"]
	},
	#Quantity & {
		name:        "rhohv"
		description: "ρhv [0-1] Correlation between Zh and Zv"
		versions: ["V20", "V21"]
	},
	#Quantity & {
		name:        "VRAD"
		description: "[m/s] Radial velocity"
		versions: ["V20", "V21", "V22"]
	},
	#Quantity & {
		name:        "WRAD"
		description: "[m/s] Spectral width of radial velocity"
		versions: ["V20", "V21", "V22"]
	},
	#Quantity & {
		name:        "ZDR"
		description: "ZDR [dB] Logged differential reflectivity"
	},
	#Quantity & {
		name:        "RHOHV"
		description: "ρhv [0-1] Correlation between Zh and Zv"
	},
	#Quantity & {
		name:        "LDR"
		description: "Ldr [dB] Linear depolarization ratio"
	},
	#Quantity & {
		name:        "PHIDP"
		description: "φdp [degrees] Differential phase"
	},
	#Quantity & {
		name:        "KDP"
		description: "Kdp [degrees/km] Specific differential phase"
	},
	#Quantity & {
		name:        "RATE"
		description: "RR [mm/h] Rain rate"
	},
	#Quantity & {
		name:        "ACRR"
		description: "RRaccum. [mm] Accumulated precipitation"
	},
	#Quantity & {
		name:        "HGHT"
		description: "H [km] Height above mean sea level"
	},
	#Quantity & {
		name:        "VIL"
		description: "VIL [kg/m2] Vertical Integrated Liquid water"
	},
	#Quantity & {
		name:        "UWND"
		description: "U [m/s] Component of wind in x-direction"
	},
	#Quantity & {
		name:        "VWND"
		description: "V [m/s] Component of wind in y-direction"
	},
	#Quantity & {
		name:        "w"
		description: "[m/s] Vertical velocity (positive upwards)"
	},
	#Quantity & {
		name:        "w_dev"
		description: "[m/s] Vertical velocity variability"
	},
	#Quantity & {
		name:        "div"
		description: "[s−1] Divergence"
	},
	#Quantity & {
		name:        "div_dev"
		description: "[s−1] Divergence variation"
	},
	#Quantity & {
		name:        "def"
		description: "[s−1] Deformation"
	},
	#Quantity & {
		name:        "def_dev"
		description: "[s−1] Deformation variation"
	},
	#Quantity & {
		name:        "ad"
		description: "[degrees] Axis of dialation (0-360)"
	},
	#Quantity & {
		name:        "ad_dev"
		description: "[degrees] Variability of axis of dialation (0-360)"
	},
	#Quantity & {
		name:        "rhohv_dev"
		description: "ρhv [0-1] ρhv variation"
	},
	#Quantity & {
		name:        "QIND"
		description: "Quality [0-1] Spatially analyzed quality indicator, according to OPERA II, normalized to between 0 (poorest quality) to 1 (best quality)"
	},
	#Quantity & {
		name:        "CLASS"
		description: "Classification Indicates that data are classified and that the classes are specified according to the associated legend object (Section 6.2) whichmust be present."
	},
	#Quantity & {
		name:        "ff"
		description: "[m/s] Mean horizontal wind velocity"
	},
	#Quantity & {
		name:        "dd"
		description: "[degrees] Mean horizontal wind direction (degrees)"
	},
	#Quantity & {
		name:        "ff_dev"
		description: "[m/s] Velocity variability"
	},
	#Quantity & {
		name:        "dd_dev"
		description: "[m/s] Direction variability"
	},
	#Quantity & {
		name:        "n"
		description: "– Sample size. Marked for DEPRECATION."
	},
	#Quantity & {
		name:        "BRDR"
		description: "0 or 1 1 denotes a border where data from two or more radars meet incomposites, otherwise 0"
	},
	#Quantity & {
		name:        "DBZH"
		description: "Zh [dBZ] Logged horizontally-polarized (corrected) reflectivity factor"
	},
	#Quantity & {
		name:        "DBZV"
		description: "Zv [dBZ] Logged vertically-polarized (corrected) reflectivity factor"
	},
	#Quantity & {
		name:        "TH"
		description: "Th [dBZ] Logged horizontally-polarized total (uncorrected) reflectivity factor"
	},
	#Quantity & {
		name:        "TV"
		description: "Tv [dBZ] Logged vertically-polarized total (uncorrected) reflectivity factor"
	},
	#Quantity & {
		name:        "SNR"
		description: "SNR [dB] Signal-to-noise ratio"
	},
	#Quantity & {
		name:        "SQIH"
		description: "SQIh [0-1] Signal quality index - horizontally-polarized"
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "USQIH"
		description: "SQIh [0-1] Signal quality index - horizontally-polarized - that has not been subject to a Doppler filter"
		versions: ["V23"]
	},
	#Quantity & {
		name:        "SQIV"
		description: "SQIv [0-1] Signal quality index - vertically-polarized"
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "USQIV"
		description: "SQIv [0-1] Signal quality index - vertically-polarized - that has not been subject to a Doppler filter"
		versions: ["V23"]
	},
	#Quantity & {
		name:        "SNRH"
		description: "SNRh [0-1] Normalized signal-to-noise ratio - horizontally-polarized. Marked for DEPRECATION."
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "SNRV"
		description: "SNRv [0-1] Normalized signal-to-noise ratio - vertically-polarized. Marked for DEPRECATION."
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "SNRHC"
		description: "SNRh,c [dB] Signal-to-noise ratio co-polar H"
		versions: ["V23"]
	},
	#Quantity & {
		name:        "SNRHX"
		description: "SNRh,x [dB] Signal-to-noise ratio cross-polar H"
		versions: ["V23"]
	},
	#Quantity & {
		name:        "SNRVC"
		description: "SNRv,c [dB] Signal-to-noise ratio co-polar V"
		versions: ["V23"]
	},
	#Quantity & {
		name:        "SNRVX"
		description: "SNRv,x [dB] Signal to noise ratio cross polar V"
		versions: ["V23"]
	},
	#Quantity & {
		name:        "CCORH"
		description: "CCh [dB] Clutter correction - horizontally-polarized"
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "CCORV"
		description: "CCv [dB] Clutter correction - vertically-polarized"
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "VRADH"
		description: "Vrad,h [m/s] Radial velocity - horizontally-polarized. Radial winds towards the radar are negative, while radial winds away from the radar are positive (PANT)."
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "UVRADH"
		description: "Vrad,h [m/s] Radial velocity - horizontally-polarized - that has not been subject to any filter or correction. Radial winds towards the radar are negative, while radial winds away from the radar are positive (PANT)."
		versions: ["V23"]
	},
	#Quantity & {
		name:        "VRADV"
		description: "Vrad,v [m/s] Radial velocity - vertically-polarized. Radial winds towards the radar are negative, while radial winds away from the radar are positive (PANT)."
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "UVRADV"
		description: "Vrad,v [m/s] Radial velocity - vertically-polarized - that has not been subject to any filter or correction. Radial winds towards the radar are negative, while radial winds away from the radar are positive (PANT)."
		versions: ["V23"]
	},
	#Quantity & {
		name:        "VRADDH"
		description: "Vrad,d [m/s] Dealiased horizontally-polarized radial velocity"
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "VRADDV"
		description: "Vrad,d [m/s] Dealiased vertically-polarized radial velocity"
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "WRADH"
		description: "Wrad,h [m/s] Spectral width of radial velocity - horizontally-polarized"
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "UWRADH"
		description: "Wrad,h [m/s] Spectral width of radial velocity - horizontally-polarized - that has not been subject to any filter or correction"
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "WRADV"
		description: "Wrad,v [m/s] Spectral width of radial velocity - vertically-polarized"
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "UWRADV"
		description: "Wrad,v [m/s] Spectral width of radial velocity - vertically-polarized - that has not been subject to any filter or correction"
		versions: ["V23"]
	},
	#Quantity & {
		name:        "PSPH"
		description: "PSP [dBm] Power spectrum peak - horizontally-polarized"
		versions: ["V23"]
	},
	#Quantity & {
		name:        "PSPV"
		description: "PSP [dBm] Power spectrum peak - vertically-polarized"
		versions: ["V23"]
	},
	#Quantity & {
		name:        "UPSPH"
		description: "PSP [dBm] Power spectrum peak - horizontally-polarized - that has not been subject to any filter or correction"
		versions: [ "V23"]
	},
	#Quantity & {
		name:        "UPSPV"
		description: "PSP [dBm] Power spectrum peak - vertically-polarized - that has not been subject to any filter or correction"
		versions: [ "V23"]
	},
	#Quantity & {
		name:        "DBZH_dev"
		description: "[dBZ] Variability of logged horizontally-polarized (corrected) reflectivity factor"
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "DBZV_dev"
		description: "[dBZ] Variability of logged vertically-polarized (corrected) reflectivity factor"
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "UZDR"
		description: "ZDR [dB] Logged differential reflectivity that has not been subject to a Doppler filter"
		versions: [ "V23"]
	},
	#Quantity & {
		name:        "URHOHV"
		description: "ρhv [0-1] Correlation between Zh and Zv that has not been subject to any filter or correction"
		versions: [ "V23"]
	},
	#Quantity & {
		name:        "ULDR"
		description: "Ldr [dB] Linear depolarization ratio that has not been subject to a Doppler filter"
		versions: ["V23"]
	},
	#Quantity & {
		name:        "UPHIDP"
		description: "φdp [degrees] Differential phase that has not been subject to any filter or correction"
		versions: ["V23"]
	},
	#Quantity & {
		name:        "PIA"
		description: "PIA [dB] Path Integrated Attenuation"
		versions: ["V23"]
	},
	#Quantity & {
		name:        "UKDP"
		description: "Kdp [degrees/km] Specific differential phase that has not been subject to any filter or correction"
		versions: ["V23"]
	},
	#Quantity & {
		name:        "CPA"
		description: "CPA [0-1] Clutter phase alignment (0: low probability of clutter, 1: high probability of clutter)"
		versions: ["V23"]
	},
	#Quantity & {
		name:        "URATE"
		description: "URR [mm/h] Uncorrected rain rate"
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "POR"
		description: "POR [0-1] Probability of rain (0: low probability, 1: high probability)"
		versions: ["V23"]
	},
	#Quantity & {
		name:        "HI"
		description: "HI [dBZ] Hail intensity"
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "HP"
		description: "HP [%] Hail probability. Marked for DEPRECATION."
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "POH"
		description: "POH [0-1] Probability of hail (0: low probability, 1: high probability)"
		versions: ["V23"]
	},
	#Quantity & {
		name:        "POSH"
		description: "POSH [0-1] Probability of severe hail (0: low probability, 1: high probability)"
		versions: ["V23"]
	},
	#Quantity & {
		name:        "MESH"
		description: "MESH [cm] Maximum expected severe hail size"
		versions: ["V23"]
	},
	#Quantity & {
		name:        "RSHR"
		description: "SHRr [m/s km] Radial shear"
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "ASHR"
		description: "SHRa [m/s km] Azimuthal shear"
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "CSHR"
		description: "SHRc [m/s km] Range-azimuthal shear"
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "ESHR"
		description: "SHRe [m/s km] Elevation shear"
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "OSHR"
		description: "SHRo [m/s km] Range-elevation shear"
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "HSHR"
		description: "SHRh [m/s km] Horizontal shear"
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "VSHR"
		description: "SHRv [m/s km] Vertical shear"
		versions: ["V22", "V23"]
	},
	#Quantity & {
		name:        "TSHR"
		description: "SHRt [m/s km] Three-dimensional shear"
		versions: ["V22", "V23"]
	},
]

#QuantityV20: or([ for q in #Quantities if list.Contains(q.versions, "V20") {q.name}])
#QuantityV21: or([ for q in #Quantities if list.Contains(q.versions, "V21") {q.name}])
#QuantityV22: or([ for q in #Quantities if list.Contains(q.versions, "V22") {q.name}])
#QuantityV23: or([ for q in #Quantities if list.Contains(q.versions, "V23") {q.name}])
