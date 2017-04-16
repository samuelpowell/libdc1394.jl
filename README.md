## DC1394.jl

[![Build Status](https://travis-ci.org/samuelpowell/DC1394.jl.svg?branch=master)](https://travis-ci.org/samuelpowell/DC1394.jl)

[![Coverage Status](https://coveralls.io/repos/samuelpowell/DC1394.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/samuelpowell/DC1394.jl?branch=master)

[![codecov.io](http://codecov.io/github/samuelpowell/DC1394.jl/coverage.svg?branch=master)](http://codecov.io/github/samuelpowell/DC1394.jl?branch=master)

This package is a low-level Julia wrapper of the [libdc1394](http://damien.douxchamps.net/ieee1394/libdc1394/) library, currently targeting v2.2.4 (the latest version on libdc1394 (v2.2.5) has build errors on macOS which have been fixed in the development version).

This is a fork of the original work by [TakekazuKATO](https://github.com/TakekazuKATO/DC1394.jl), with the following small changes:

+ updates for Julia 0.5;
+ libSDL dependencies managed by library;
+ fixes for segfaults when using polling transfers;
+ removal of aliased format 7 functions (avoiding method ambiguities);
+ more direct mapping of library names to Julia names;
+ error handling on all library calls.

## Compatibility

DC1394.jl has been tested with Julia 0.5 on MacOS (with an Hamamatsu ORCA-03G camera), and should work without modification on Linux. Windows compatability will require the addition of a binary source for the libDC1394 library (PR welcome!).

## Installation

Clone and build the package as follows.

```
julia> Pkg.clone("git@github.com:samuelpowell/DC1394.jl.git")
julia> Pkg.build("libdc1394")
```

The package depends upon libSDL and libdc1394 which are downloaded or built from source, as appropriate, by the build process.

## Example usage

WIP

## API

DC1394.jl adheres closely to the libdc1394 API with some exceptions:

+ functions are not prefixed by `dc1394`;
+ the module creates a libdc1394 context upon loading which is held internally and freed when the module is unloaded, there is no need therefore to call `dc1394_new()` or `dc1394_free()`;
+ references to cameras are managed by a `Camera` type;
+ references to video frames are managed by a `VideoFrame` type, created from a frame handle.

The following subsections detail differences in the API mappings from those detailed on the [libdc1394](http://damien.douxchamps.net/ieee1394/libdc1394/) homepage.

### System & Camera

System functions are mostly handled internally through automatic context creation and management, and the `Camera` and `VideoFrame` types detailed above. The implementation is split between `DC1394.jl` and `camera.jl`.

### Capture

Two additional functions are used to extract the frame information and the video data from a video frame pointer returned by libdc1394.

```
get_info
get_image
```