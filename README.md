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
> cue vet [--ignore] <my_output_file_from_python_script> *.cue -d 'root' -t version=<version>
```
This validates the output file vs. the data-specification written in [`odim_schema.cue`](odim_schema.cue).




## Known bugs/limitations/interpretation/notes
 - The v2.01 specification is used, the v2.0 specification is fully disregarded.
 - While not expressly stated in the specification, this script expect that datasets and data groups are called `dataset[n]` and `data[n]` respectively, they are never referenced in any other way.
 - deprecations in the specification do not trigger warnings/errors
 - `/what/source` is validated through regex that allow defining the same key multiple times in the string without triggering an error
 - the data type `simpleArrayOfDoubles` is used for validation of `sequence`-types for versions before it was introduced, as it really is a subset of the sequence type but with more specificity, this way it is used to validate the v2.01 specification objects where a sequence was expected to follow the more specific syntax of `simple array [of doubles]`.
 - `where`-objects are interpreted to require all the stated keys, deprecated members are allowed to be missing (RHI specific member `angles`, since v2.3)
 - `how` can in version 2.3 and up have allowed subgroups; generally the specification allow additional fields. The validation here does not! filter these using the python program's filter-mechanism. (this is safer than allowing anything, as the developer will then be required to double-check their errors; this weeds out spelling mistakes and earlier defined keys that were removed in the specification, requiring your validation to be specific about which fields to ignore)
 - the dataset (and group) `what` object has no specifically "required" attributes; allowed attributes are all allowed to be missing independently of all other sibling attributes.
 - This project does not offer validation of cross-cutting terms like: adding "vertical"-only where attributes at `dataset group` level encompassing data that is not of type: "vertical".
 - In v2.4 many `how`attributes became mandatory (for single radar products). Since the mandate is conditional, and have exceptions, I have left it out so far.
 
