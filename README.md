## libdc1394.jl

This package is a low-level Julia wrapper of the [libdc1394](http://damien.douxchamps.net/ieee1394/libdc1394/) library, currently targeting v2.2.4 (the latest version on libdc1394 (v2.2.5) has build errors on macOS which have been fixed in the development version).

This is a fork of the original work by [TakekazuKATO](https://github.com/TakekazuKATO/DC1394.jl), with the following small changes:

+ updates for Julia 0.5;
+ libSDL dependencies managed by library;
+ fixes for segfaults when using polling transfers;
+ removal of aliased format 7 functions (avoiding method ambiguities);
+ more direct mapping of library names to Julia names. 

## Compatibility

libdc1394.jl has been tested with Julia 0.5 on MacOS (with an Hamamatsu ORCA-03G camera), and should work without modification on Linux. Windows compatability will require the addition of a binary source for the libDC1394 library (PR welcome!).

## Installation

Clone and build the package as follows.

```
julia> Pkg.clone("git@github.com:samuelpowell/libdc1394.jl.git")
julia> Pkg.build("libdc1394")
```

The package depends upon libSDL and libdc1394 which are downloaded or built from source, as appropriate, by the build process.

## API

libdc1394.jl adheres closely to the libdc1394 API with some exceptions:

+ functions are not prefixed by `dc1394`;
+ the module creates a libdc1394 context upon loading which is held internally and freed when the module is unloaded, there is no need therefore to call `dc1394_new()` or `dc1394_free()`;
+ references to cameras are managed by a `Camera` type;
+ references to video frames are managed by a `VideoFrame` type, created from a frame handle.

The following subsections detail the specifics of the API mappings as detailed on the [libdc1394](http://damien.douxchamps.net/ieee1394/libdc1394/) homepage.

### Types & Structures

### System

System functions are mostly handled internally through automatic context creation and management, camera and video frame types, as detailed above.

### Triggers

All trigger functions are directly mapped to Julia functions (these functions are part of the `control.h` header in libdc1394).

```
dc1394_external_trigger_set_polarity
dc1394_external_trigger_get_polarity
dc1394_external_trigger_has_polarity

dc1394_external_trigger_set_power
dc1394_external_trigger_get_power

dc1394_external_trigger_set_mode
dc1394_external_trigger_get_mode

dc1394_external_trigger_set_source
dc1394_external_trigger_get_source
dc1394_external_trigger_get_supported_sources

dc1394_software_trigger_set_power
dc1394_software_trigger_get_power
```

### Features

WIP

### Video

All video functions are directly mapped to Julia functions.

```
dc1394_video_get_supported_modes
dc1394_video_get_supported_framerates

dc1394_video_get_framerate
dc1394_video_set_framerate

dc1394_video_get_mode
dc1394_video_set_mode
dc1394_video_get_operation_mode
dc1394_video_set_operation_mode

dc1394_video_get_iso_speed
dc1394_video_set_iso_speed
dc1394_video_get_iso_channel
dc1394_video_set_iso_channel

dc1394_video_get_data_depth

dc1394_video_set_transmission
dc1394_video_get_transmission

dc1394_video_set_one_shot
dc1394_video_get_one_shot
dc1394_video_set_multi_shot
dc1394_video_get_multi_shot

dc1394_video_get_bandwidth_usage
```

### Capture

All capture functions are directly mapped to Julia functions.

```
dc1394_capture_setup
dc1394_capture_stop
dc1394_capture_get_fileno
dc1394_capture_dequeue
dc1394_capture_enqueue
dc1394_capture_is_frame_corrupt
dc1394_capture_set_callback
```

Two additional functions are used to extract the frame information and the video data from a video frame pointer returned by libDC1394.

```
get_info
get_image
```

### Format 7

All format 7 functions are directly mapped to Julia functions. For functions which take a camera object and a video mode, convenience functions are provided which take only a camera object, and use the current video mode of the camera.

```
dc1394_format7_get_max_image_size
dc1394_format7_get_unit_size
dc1394_format7_get_image_size
dc1394_format7_set_image_size

dc1394_format7_get_image_position
dc1394_format7_set_image_position
dc1394_format7_get_unit_position

dc1394_format7_get_color_coding
dc1394_format7_get_color_codings
dc1394_format7_set_color_coding
dc1394_format7_get_color_filter

dc1394_format7_get_packet_parameters
dc1394_format7_get_packet_size
dc1394_format7_set_packet_size
dc1394_format7_get_recommended_packet_size
dc1394_format7_get_packets_per_frame

dc1394_format7_get_data_depth
dc1394_format7_get_frame_interval
dc1394_format7_get_pixel_number
dc1394_format7_get_total_bytes
dc1394_format7_get_modeset
dc1394_format7_get_mode_info

dc1394_format7_set_roi
dc1394_format7_get_roi
```

### Conversions

The following functions are directly mapped to Julia.

```
dc1394_convert_frames
dc1394_debayer_frames
dc1394_deinterlace_stereo_frames
```

The remaining functions are not currently mapped.

```
dc1394_convert_to_YUV422
dc1394_convert_to_MONO8
dc1394_convert_to_RGB8
dc1394_deinterlace_stereo
dc1394_bayer_decoding_8bit
dc1394_bayer_decoding_16bit
```

### Utilities

```
dc1394_get_image_size_from_video_mode
dc1394_get_color_coding_data_depth
dc1394_get_color_coding_bit_size
dc1394_get_color_coding_from_video_mode
dc1394_is_color
dc1394_is_video_mode_scalable
dc1394_is_video_mode_still_image
dc1394_error_get_string
dc1394_checksum_crc16
```

The remaining functions are not currently mapped.

```
dc1394_framerate_as_float
dc1394_is_same_camera
dc1394_feature_get_string
```

There are additional functions which should be moved (WIP)

### Errors

WIP







