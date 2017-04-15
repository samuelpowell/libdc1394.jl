# libDC1394.jl: interface to the libDC1394 library
# Copyright (c) 2016 tkato
# Copyright (C) 2017 Samuel Powell

export
  iso_set_persist,
  iso_allocate_channel,
  iso_release_channel,
  iso_allocate_bandwidth,
  iso_release_bandwidth,
  iso_release_all

function iso_set_persist(camera::Camera)
  ccall((:dc1394_iso_set_persist,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},),
    camera.handle)
end

function iso_allocate_channel(camera::Camera,channels_allowed::Integer)
  channel=[Cint(0)]
  ccall((:dc1394_iso_allocate_channel,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt64,Ptr{Cint}),
    camera.handle,channels_allowed,channel)
  channel[1]
end

function iso_release_channel(camera::Camera,channel::Integer)
  ccall((:dc1394_iso_release_channel,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},Cint),
    camera.handle,channel)
end

function iso_allocate_bandwidth(camera::Camera,bandwidth_units::Integer)
  ccall((:dc1394_iso_allocate_bandwidth,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},Cint),
    camera.handle,bandwidth_units)
end

function iso_release_bandwidth(camera::Camera,bandwidth_units::Integer)
  ccall((:dc1394_iso_release_bandwidth,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},Cint),
    camera.handle,bandwidth_units)
end

function iso_release_all(camera::Camera)
  ccall((:dc1394_iso_release_all,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},),
    camera.handle)
end
