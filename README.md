#ODIM HDF5 Validator
ODIM is a specification for how to store Radar data in an HDF5 file.
This project has a mapping routine in python and a write-up of the ODIM specification in CUE.

The Python program has been tested using python 3.9. I believe any python3 will do.

The command
```shell
> python3 hdf5_json.py <my_hdf5_file.h5>
```
maps the hdf5 file metadata to out. pipe that to a file and read using cue:
```shell
> cue vet [--ignore] <my_output_file_from_python_script> *.cue -d 'root' 
        -t version=<version> [-t single_site=true] [-t mixed_polarization=true]
```
This validates the output file vs. the data-specification written in [`odim_schema.cue`](odim_schema.cue).

The project has a wrapping script that handles versions and allow overwriting the version to validate against (if one wish to validate a current file vs. another version than it actually has)
```shell
    validate_odim_h5 [-as <version> | -single-site | -mixed-polarization] 
            <file> [[--] <ignore fields>]
```
The script is purely to tie the two other products together.

## Docker container
The docker container collect the dependencies, and use the `validate_odim_h5` bash script as entrypoint.

Usage:
```shell
    docker run -v /path/to/file.h5:/file/in/container.h5 <containerId> 
           <same input as validate_odim_h5 script -- use path /file/in/container.h5>
```

## V2.4 Mandatory Single Site data
The addition of mandatory `how`-attributes and `/what/source: NOD` prompted a change for the validation leaving me to revisit the way `*H` and `*V` attributes were handled.

I have now interpreted values to not be allowed to mix both `*H` and `*V` attributes in a single `how`-group. This behavior can be controlled by the feature-flag `--mixed-source`; allowing mixing of the polarization-specific-attributes.

## Known bugs/limitations/interpretation/notes
 - The v2.01 specification is used, the v2.0 specification is fully disregarded.
 - While not expressly stated in the specification, this script expect that datasets, data groups and quality groups are called `dataset[n]`, `data[n]` and `quality[n]` respectively, they are never referenced in any other way.
 - deprecations in the specification do not trigger warnings/errors
 - `/what/source` is validated through regex that allow defining the same key multiple times in the string without triggering an error
 - the data type `simpleArrayOfDoubles` is used for validation of `sequence`-types for versions before it was introduced, as it really is a subset of the sequence type but with more specificity, this way it is used to validate the v2.01 specification objects where a sequence was expected to follow the more specific syntax of `simple array [of doubles]`.
 - `where`-objects are interpreted to require all the stated keys, deprecated members are allowed to be missing (RHI specific member `angles`, since v2.3)
 - `how` can in version 2.3 and up have allowed subgroups; generally the specification allow additional fields. The validation here does not! filter these using the python program's filter-mechanism. (this is safer than allowing anything, as the developer will then be required to double-check their errors; this weeds out spelling mistakes and earlier defined keys that were removed in the specification, requiring your validation to be specific about which fields to ignore)
 - the dataset (and group) `what` object has no specifically "required" attributes; allowed attributes are all allowed to be missing independently of all other sibling attributes.
 - This project does not offer validation of cross-cutting terms like: adding "vertical"-only where attributes at `dataset group` level encompassing data that is not of type: "vertical".
