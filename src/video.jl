# DC1394.jl: interface to the libDC1394 library
# Copyright (c) 2016 tkato
# Copyright (C) 2017 Samuel Powell

export
  video_get_supported_modes,
  video_get_supported_framerates,
  video_get_framerate,
  video_set_framerate,
  video_get_mode,
  video_set_mode,
  video_get_operation_mode,
  video_set_operation_mode,
  video_get_iso_speed,
  video_set_iso_speed,
  video_get_iso_channel,
  video_set_iso_channel,
  video_get_data_depth,
  video_set_transmission,
  video_get_transmission,
  video_set_one_shot,
  video_get_one_shot,
  video_set_multi_shot,
  video_get_multi_shot,
  video_get_bandwidth_usage

"""
enum dc1394video_mode_t
"""
@enum(dc1394video_mode_t,
      VIDEO_MODE_160x120_YUV444 = (UInt32)(64),
      VIDEO_MODE_320x240_YUV422 = (UInt32)(65),
      VIDEO_MODE_640x480_YUV411 = (UInt32)(66),
      VIDEO_MODE_640x480_YUV422 = (UInt32)(67),
      VIDEO_MODE_640x480_RGB8 = (UInt32)(68),
      VIDEO_MODE_640x480_MONO8 = (UInt32)(69),
      VIDEO_MODE_640x480_MONO16 = (UInt32)(70),
      VIDEO_MODE_800x600_YUV422 = (UInt32)(71),
      VIDEO_MODE_800x600_RGB8 = (UInt32)(72),
      VIDEO_MODE_800x600_MONO8 = (UInt32)(73),
      VIDEO_MODE_1024x768_YUV422 = (UInt32)(74),
      VIDEO_MODE_1024x768_RGB8 = (UInt32)(75),
      VIDEO_MODE_1024x768_MONO8 = (UInt32)(76),
      VIDEO_MODE_800x600_MONO16 = (UInt32)(77),
      VIDEO_MODE_1024x768_MONO16 = (UInt32)(78),
      VIDEO_MODE_1280x960_YUV422 = (UInt32)(79),
      VIDEO_MODE_1280x960_RGB8 = (UInt32)(80),
      VIDEO_MODE_1280x960_MONO8 = (UInt32)(81),
      VIDEO_MODE_1600x1200_YUV422 = (UInt32)(82),
      VIDEO_MODE_1600x1200_RGB8 = (UInt32)(83),
      VIDEO_MODE_1600x1200_MONO8 = (UInt32)(84),
      VIDEO_MODE_1280x960_MONO16 = (UInt32)(85),
      VIDEO_MODE_1600x1200_MONO16 = (UInt32)(86),
      VIDEO_MODE_EXIF = (UInt32)(87),
      VIDEO_MODE_FORMAT7_0 = (UInt32)(88),
      VIDEO_MODE_FORMAT7_1 = (UInt32)(89),
      VIDEO_MODE_FORMAT7_2 = (UInt32)(90),
      VIDEO_MODE_FORMAT7_3 = (UInt32)(91),
      VIDEO_MODE_FORMAT7_4 = (UInt32)(92),
      VIDEO_MODE_FORMAT7_5 = (UInt32)(93),
      VIDEO_MODE_FORMAT7_6 = (UInt32)(94),
      VIDEO_MODE_FORMAT7_7 = (UInt32)(95))

const VIDEO_MODE_MIN = VIDEO_MODE_160x120_YUV444
const VIDEO_MODE_MAX = VIDEO_MODE_FORMAT7_7
const VIDEO_MODE_NUM = (Int(VIDEO_MODE_MAX) - Int(VIDEO_MODE_MIN)) + 1
const VIDEO_MODE_FORMAT7_MIN = VIDEO_MODE_FORMAT7_0
const VIDEO_MODE_FORMAT7_MAX = VIDEO_MODE_FORMAT7_7
const VIDEO_MODE_FORMAT7_NUM = (Int(VIDEO_MODE_FORMAT7_MAX) - Int(VIDEO_MODE_FORMAT7_MIN)) + 1

const VIDEO_MODE_FORMAT0_MIN = VIDEO_MODE_160x120_YUV444
const VIDEO_MODE_FORMAT0_MAX = VIDEO_MODE_640x480_MONO16
const VIDEO_MODE_FORMAT0_NUM = (Int(VIDEO_MODE_FORMAT0_MAX) - Int(VIDEO_MODE_FORMAT0_MIN)) + 1
const VIDEO_MODE_FORMAT1_MIN = VIDEO_MODE_800x600_YUV422
const VIDEO_MODE_FORMAT1_MAX = VIDEO_MODE_1024x768_MONO16
const VIDEO_MODE_FORMAT1_NUM = (Int(VIDEO_MODE_FORMAT1_MAX) - Int(VIDEO_MODE_FORMAT1_MIN)) + 1
const VIDEO_MODE_FORMAT2_MIN = VIDEO_MODE_1280x960_YUV422
const VIDEO_MODE_FORMAT2_MAX = VIDEO_MODE_1600x1200_MONO16
const VIDEO_MODE_FORMAT2_NUM = (Int(VIDEO_MODE_FORMAT2_MAX) - Int(VIDEO_MODE_FORMAT2_MIN)) + 1
const VIDEO_MODE_FORMAT6_MIN = VIDEO_MODE_EXIF
const VIDEO_MODE_FORMAT6_MAX = VIDEO_MODE_EXIF
const VIDEO_MODE_FORMAT6_NUM = (Int(VIDEO_MODE_FORMAT6_MAX) - Int(VIDEO_MODE_FORMAT6_MIN)) + 1

immutable dc1394video_modes_t
    num::UInt32
    modes::NTuple{32,dc1394video_mode_t}
    dc1394video_modes_t()=new(UInt32(0),ntuple(x->VIDEO_MODE_MIN,32))
end

show(io::IO,vms::dc1394video_modes_t)=0<vms.num<32? show(io,vms.modes[1:vms.num]) :()

# begin enum dc1394speed_t
@enum(dc1394speed_t,
      ISO_SPEED_100 = (UInt32)(0),
      ISO_SPEED_200 = (UInt32)(1),
      ISO_SPEED_400 = (UInt32)(2),
      ISO_SPEED_800 = (UInt32)(3),
      ISO_SPEED_1600 = (UInt32)(4),
      ISO_SPEED_3200 = (UInt32)(5))
# end enum dc1394speed_t

const ISO_SPEED_MIN = ISO_SPEED_100
const ISO_SPEED_MAX = ISO_SPEED_3200
const ISO_SPEED_NUM = (Int(ISO_SPEED_MAX) - Int(ISO_SPEED_MIN)) + 1

# begin enum dc1394framerate_t
@enum(dc1394framerate_t,
      FRAMERATE_1_875 = (UInt32)(32),
      FRAMERATE_3_75 = (UInt32)(33),
      FRAMERATE_7_5 = (UInt32)(34),
      FRAMERATE_15 = (UInt32)(35),
      FRAMERATE_30 = (UInt32)(36),
      FRAMERATE_60 = (UInt32)(37),
      FRAMERATE_120 = (UInt32)(38),
      FRAMERATE_240 = (UInt32)(39))
# end enum dc1394framerate_t

const FRAMERATE_MIN = FRAMERATE_1_875
const FRAMERATE_MAX = FRAMERATE_240
const FRAMERATE_NUM = (Int(FRAMERATE_MAX) - Int(FRAMERATE_MIN)) + 1

immutable dc1394framerates_t
  num::UInt32
  framerates::NTuple{8,dc1394framerate_t}
  dc1394framerates_t()=new(0,ntuple(i->FRAMERATE_MIN,8))
end

show(io::IO,fm::dc1394framerates_t)=0<fm.num<8? show(io,fm.framerates[1:fm.num]):()

function convert(::Type{Float32},framerate_enum::dc1394framerate_t)
  framerate=[Cfloat(0)]
  ccall((:dc1394_framerate_as_float,libdc1394),
    dc1394error_t,
    (dc1394framerate_t,Ptr{Cfloat}),
    framerate_enum,framerate)
  Float32(framerate[1])
end

# begin enum dc1394operation_mode_t
@enum(dc1394operation_mode_t,
      OPERATION_MODE_LEGACY = (UInt32)(480),
      OPERATION_MODE_1394B = (UInt32)(481))
# end enum dc1394operation_mode_t

const OPERATION_MODE_MIN = OPERATION_MODE_LEGACY
const OPERATION_MODE_MAX = OPERATION_MODE_1394B
const OPERATION_MODE_NUM = (Int(OPERATION_MODE_MAX) - Int(OPERATION_MODE_MIN)) + 1


function video_get_supported_modes(camera::Camera)
  modes=Array{dc1394video_modes_t,1}(1)
  ccall((:dc1394_video_get_supported_modes,libdc1394),
        dc1394error_t,
        (Ptr{dc1394camera_info_t},Ptr{dc1394video_modes_t}),
        camera.handle,modes)
  modes[1].modes[1:modes[1].num]
end

function video_get_mode(camera::Camera)
  video_mode=Array{dc1394video_mode_t,1}(1)
  ccall((:dc1394_video_get_mode,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},Ptr{dc1394video_mode_t}),
    camera.handle,video_mode)
  video_mode[1]
end

function video_set_mode(camera::Camera,video_mode::dc1394video_mode_t)
  ccall((:dc1394_video_set_mode,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},dc1394video_mode_t),
    camera.handle,video_mode)
end

function video_get_supported_framerates(camera::Camera,video_mode::dc1394video_mode_t)
  framerates=Array{dc1394framerates_t,1}(1)
  ccall((:dc1394_video_get_supported_framerates,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},dc1394video_mode_t,Ptr{dc1394framerates_t}),
    camera.handle,video_mode,framerates)
  framerates[1].framerates[1:framerates[1].num]
end

function video_get_framerate(camera::Camera)
  framerate=Array{dc1394framerate_t,1}(1)
  ccall((:dc1394_video_get_framerate,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},Ptr{dc1394framerate_t}),
    camera.handle,framerate)
  framerate[1]
end

function video_set_framerate(camera::Camera,framerate::dc1394framerate_t)
  ccall((:dc1394_video_set_framerate,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},dc1394framerate_t),
    camera.handle,framerate)
end

function video_get_operation_mode(camera::Camera)
  mode=Array{dc1394operation_mode_t,1}(1)
  ccall((:dc1394_video_get_operation_mode,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},Ptr{dc1394operation_mode_t}),
    camera.handle,mode)
  mode[1]
end

function video_set_operation_mode(camera::Camera,mode::dc1394operation_mode_t)
  ccall((:dc1394_video_set_operation_mode,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},dc1394operation_mode_t),
    camera.handle,mode)
end

function video_get_iso_speed(camera::Camera)
  speed=Array{dc1394speed_t,1}(1)
  ccall((:dc1394_video_get_iso_speed,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},Ptr{dc1394speed_t}),
    camera.handle,speed)
  speed[1]
end

function video_set_iso_speed(camera::Camera,speed::dc1394speed_t)
  ccall((:dc1394_video_set_iso_speed,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},dc1394speed_t),
    camera.handle,speed)
end

function video_get_iso_channel(camera::Camera)
  channel=[UInt32(0)]
  ccall((:dc1394_video_get_iso_channel,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},Ptr{UInt32}),
    camera.handle,channel)
  Int(channel[1])
end

function video_set_iso_channel(camera::Camera,channel::Int)
  ccall((:dc1394_video_set_iso_channel,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt32),
    camera.handle,channel)
end

function video_get_data_depth(camera::Camera)
  depth=[UInt32(0)]
  ccall((:dc1394_video_get_data_depth,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},Ptr{UInt32}),
    camera.handle,depth)
  Int(depth[1])
end

function video_set_transmission(camera::Camera,pwr::dc1394switch_t)
  ccall((:dc1394_video_set_transmission,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},dc1394switch_t),
    camera.handle,pwr)
end

function video_get_transmission(camera::Camera)
  pwr=[dc1394switch_t(OFF)]
  ccall((:dc1394_video_get_transmission,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},Ptr{dc1394switch_t}),
    camera.handle,pwr)
  pwr[1]
end

function video_set_one_shot(camera::Camera,pwr::dc1394switch_t)
  ccall((:dc1394_video_set_one_shot,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},dc1394switch_t),
    camera.handle,pwr)
end

function video_get_one_shot(camera::Camera)
  is_on=[dc1394bool_t(FALSE)]
  ccall((:dc1394_video_get_one_shot,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},Ptr{dc1394bool_t}),
    camera.handle,is_on)
  is_on[1]==TRUE
end

function video_set_multi_shot(camera::Camera,numFrames::Int,pwr::dc1394switch_t)
  ccall((:dc1394_video_set_multi_shot,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt32,dc1394switch_t),
    camera.handle,numFrames,pwr)
end

function video_get_multi_shot(camera::Camera)
  is_on=[dc1394bool_t(OFF)]
  numFrames=[UInt32(0)]
  ccall((:dc1394_video_get_multi_shot,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},Ptr{dc1394bool_t},Ptr{UInt32}),
    camera.handle,is_on,numFrames)
  is_on[1],Int(numFrames(1))
end

function video_get_bandwidth_usage(camera::Camera)
  bandwidth=[UInt32(0)]
  ccall((:dc1394_video_get_bandwidth_usage,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},Ptr{UInt32}),
    camera.handle,bandwidth)
  Int(bandwidth[1])
end
