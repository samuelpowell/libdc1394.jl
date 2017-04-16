# DC1394.jl: interface to the libDC1394 library
# Copyright (C) 2016 tkato, 2017 Samuel Powell

# control.jl - function mappings for control.h (complete, see includes)

export
  pio_set,
  pio_get,
  camera_reset,
  camera_set_power,
  memory_busy,
  memory_save,
  memory_load

function pio_set(camera::Camera,value::Int)
  @dcassert ccall((:dc1394_pio_set,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt32),
    camera.handle,value)
end

function pio_get(camera::Camera)
  value=[UInt32(0)]
  @dcassert ccall((:dc1394_pio_get,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},Ptr{UInt32}),
    camera.handle,value)
  Int(value[1])
end

function camera_reset(camera::Camera)
  @dcassert ccall((:dc1394_camera_reset,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},),
    camera.handle)
end

function camera_set_power(camera::Camera,pwr::dc1394switch_t)
  @dcassert ccall((:dc1394_camera_set_power,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},dc1394switch_t),
    camera.handel,pwr)
end

function memory_busy(camera::Camera)
  value=[dc1394bool_t(FALSE)]
  @dcassert ccall((:dc1394_memory_busy,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},Ptr{dc1394bool_t}),
    camera.handle,value)
  value[1]==TRUE
end

function memory_save(camera::Camera,channel::Int)
  @dcassert ccall((:dc1394_memory_save,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt32),
    camera.handle,channel)
end

function memory_load(camera::Camera,channel::Int)
  @dcassert ccall((:dc1394_memory_load,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt32),
    camera.handle,channel)
end

include("control_trigger.jl")
include("control_feature.jl")
