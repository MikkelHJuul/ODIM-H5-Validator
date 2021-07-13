package odim_hdf5

#Where: #TopLevelPolarWhere | #SectorPolarWhere | #DatasetPolarWhere | #GeoImageWhere | #CrossSectionWhere | #VerticalWhere | #RHICrossSectionWhere

//table 4
#TopLevelPolarWhere: {
	lat:    float
	lon:    float
	height: float
}

//table 4
#SectorPolarWhere: {
	elangle: float      //Antenna elevation angle (degrees) above the horizon.
	elangle: >=0 & <=90 //everything else just doesnt make sense (90 doesn't really either)
	nbins:   int        //Number of range bins in each ray
	rstart:  float      //The range (km) of the start of the first range bin
	rscale:  float      //The distance in meters between two successive range bins
	nrays:   int        //Number of azimuth or elevation gates (rays) in the object
	a1gate:  int        //Index of the first azimuth gate radiated in the scan
}

//table 4
#DatasetPolarWhere: {
	startaz: float & >=0 & <=360 //The azimuth angle of the start of the first gate in the sector (degrees)
	stopaz:  float & >=0 & <=360 //The azimuth angle of the end of the last gate in the sector (degrees)
	startel: float & >=0 & <=360 //The elevation angle of the start of the first gate in the sector (degrees)
	stopel:  float & >=0 & <=360 //The elevation angle of the end of the last gate in the sector (degrees)
}

//TODO only the containing group of an image data type...??
//table 5
#GeoImageWhere: {
	projdef: string //The projection definition arguments, described above, which can be
	//used with PROJ.4. See the PROJ.4 documentation for usage.
	//Longitude/Latitude coordinates are normalized to the WGS-84 ellipsoid and
	//geodetic datum.
	xsize:  int & >0   //Number of pixels in the X dimension
	ysize:  int & >0   //Number of pixels in the Y dimension
	zsize:  int & >0   //Number of pixels in the Z dimension
	zstart: float      //Height in meters above mean sea level of the lowest pixel in the Z dimension
	xscale: float & >0 //Pizel size in the X dimension, in projection-specific coordinates (often meters)
	yscale: float & >0 //Pixel size in the Y dimension, in projection-specific coordinates (often meters)
	zscale: float & >0 //Pixel size in the Z dimension (meters)
	LL_lon: float      //Longitude of the lower left corner of the lower left pixel
	LL_lat: float      //Latitude of the lower left corner of the lower left pixel
	UL_lon: float      //Longitude of the upper left corner of the upper left pixel
	UL_lat: float      //Latitude of the upper left corner of the upper left pixel
	UR_lon: float      //Longitude of the upper right corner of the upper right pixel
	UR_lat: float      //Latitude of the upper right corner of the upper right pixel
	LR_lon: float      //Longitude of the lower right corner of the lower right pixel
	LR_lat: float      //Latitude of the lower right corner of the lower right pixel
}

//table 6
#CrossSectionWhere: {
	xsize:     int & >0   //Number of pixels in the horizontal dimension
	ysize:     int & >0   //Number of pixels in the vertical dimension
	xscale:    float & >0 //Horizontal resolution in m
	yscale:    float & >0 //Vertical resolution in m
	minheight: float      //Minimum height in meters above mean sea level
	maxheight: float      //Maximum height in meters above mean sea level
}

#RHICrossSectionWhere: {
	lon:      float //Longitude position of the radar antenna (degrees). Fractions of a degree are given in decimal notation.
	lat:      float //Latitude position of the radar antenna (degrees). Fractions of a degree are given in decimal notation.
	az_angle: float //Azimuth angle
	range:    float //Maximum range in km

	//Deprecation trigger allow not there
	//Marked for DEPRECATION.
	angles?: #simpleArrayOfDoubles //Elevation angles, in degrees, in the order of acquisition.
}

//table 7
#VerticalWhere: {
	#TopLevelPolarWhere

	//Height of the centre of the antenna in meters above mean sea level.
	interval:  float    //Vertical distance (m) between height intervals, or 0.0 if variable
	minheight: float    //Minimum height in meters above mean sea level
	maxheight: float    //Maximum height in meters above mean sea level
	levels:    int & >0 //Number of points in the profile
}
