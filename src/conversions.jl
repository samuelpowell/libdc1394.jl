# libDC1394.jl: interface to the libDC1394 library
# Copyright (c) 2016 tkato
# Copyright (C) 2017 Samuel Powell

export
  convert_frames,
  debayer_frames,
  deinterlace_stereo_frames

# begin enum dc1394bayer_method_t
@enum(dc1394bayer_method_t,
      BAYER_METHOD_NEAREST = (UInt32)(0),
      BAYER_METHOD_SIMPLE = (UInt32)(1),
      BAYER_METHOD_BILINEAR = (UInt32)(2),
      BAYER_METHOD_HQLINEAR = (UInt32)(3),
      BAYER_METHOD_DOWNSAMPLE = (UInt32)(4),
      BAYER_METHOD_EDGESENSE = (UInt32)(5),
      BAYER_METHOD_VNG = (UInt32)(6),
      BAYER_METHOD_AHD = (UInt32)(7))
# end enum dc1394bayer_method_t

const BAYER_METHOD_MIN = BAYER_METHOD_NEAREST
const BAYER_METHOD_MAX = BAYER_METHOD_AHD
const BAYER_METHOD_NUM = (Int(BAYER_METHOD_MAX) - Int(BAYER_METHOD_MIN)) + 1

# begin enum dc1394stereo_method_t
@enum(dc1394stereo_method_t,
      STEREO_METHOD_INTERLACED = (UInt32)(0),
      STEREO_METHOD_FIELD = (UInt32)(1))
# end enum dc1394stereo_method_t

const STEREO_METHOD_MIN = STEREO_METHOD_INTERLACED
const STEREO_METHOD_MAX = STEREO_METHOD_FIELD
const STEREO_METHOD_NUM = (Int(STEREO_METHOD_MAX) - Int(STEREO_METHOD_MIN)) + 1

function convert_frames(_in::VideoFrame,out::VideoFrame)
  ccall((:dc1394_convert_frames,libdc1394),
    dc1394error_t,
    (Ptr{dc1394video_frame_t},Ptr{dc1394video_frame_t}),
    _in.handle,out.handle)
end

function debayer_frames(_in::VideoFrame,out::VideoFrame,method::dc1394bayer_method_t)
  ptr::Ptr{dc1394video_frame_t}=out.handle
  if ptr==C_NULL
    ptr=Ptr{dc1394video_frame_t}(Libc.calloc(1,sizeof(dc1394video_frame_t)))
  end
  err=ccall((:dc1394_debayer_frames,libdc1394),
    dc1394error_t,(Ptr{dc1394video_frame_t},
    Ptr{dc1394video_frame_t},dc1394bayer_method_t),
    _in.handle,ptr,method)
  VideoFrame(ptr)
end

debayer_frames(_in::VideoFrame,method::dc1394bayer_method_t)=debayer(_in,VideoFrame(C_NULL),method)

function deinterlace_stereo_frames(_in::VideoFrame,out::VideoFrame,method::dc1394stereo_method_t)
  ptr::Ptr{dc1394video_frame_t}=out.handle
  if ptr==C_NULL
    ptr=Ptr{dc1394video_frame_t}(Libc.calloc(1,sizeof(dc1394video_frame_t)))
  end
  ccall((:dc1394_deinterlace_stereo_frames,libdc1394),
    dc1394error_t,
    (Ptr{dc1394video_frame_t},Ptr{dc1394video_frame_t},dc1394stereo_method_t),
    _in,out,method)
  VideoFrame(ptr)
end

deinterlace_stereo_frames(_in::VideoFrame,method::dc1394bayer_method_t)=deinterlace_stereo(_in,VideoFrame(C_NULL),method)

# function convert_to_YUV422(src::Ptr{UInt8},dest::Ptr{UInt8},width::Int,height::Int,byte_order::dc1394byte_order_t,source_coding::dc1394color_coding_t,bits::Int)
#     ccall((:dc1394_convert_to_YUV422,libdc1394),dc1394error_t,(Ptr{UInt8},Ptr{UInt8},UInt32,UInt32,dc1394byte_order_t,dc1394color_coding_t,UInt32),src,dest,width,height,byte_order,source_coding,bits)
# end

# function convert_to_MONO8(src::Ptr{UInt8},dest::Ptr{UInt8},width::Int,height::Int,byte_order::dc1394byte_order_t,source_coding::dc1394color_coding_t,bits::Int)
#     ccall((:dc1394_convert_to_MONO8,libdc1394),dc1394error_t,(Ptr{UInt8},Ptr{UInt8},UInt32,UInt32,dc1394byte_order_t,dc1394color_coding_t,UInt32),src,dest,width,height,byte_order,source_coding,bits)
# end

# function convert_to_RGB8(src::Ptr{UInt8},dest::Ptr{UInt8},width::Int,height::Int,dc1394byte_order_t::Int,source_coding::dc1394color_coding_t,bits::Int)
#     ccall((:dc1394_convert_to_RGB8,libdc1394),dc1394error_t,(Ptr{UInt8},Ptr{UInt8},UInt32,UInt32,dc1394byte_order_t,dc1394color_coding_t,UInt32),src,dest,width,height,byte_order,source_coding,bits)
# end

# function deinterlace_stereo(src::Ptr{UInt8},dest::Ptr{UInt8},width::Int,height::Int)
#     ccall((:dc1394_deinterlace_stereo,libdc1394),dc1394error_t,(Ptr{UInt8},Ptr{UInt8},UInt32,UInt32),src,dest,width,height)
# end

# function bayer_decoding_8bit(bayer::Ptr{UInt8},rgb::Ptr{UInt8},width::Int,height::Int,tile::dc1394color_filter_t,method::dc1394bayer_method_t)
#     ccall((:dc1394_bayer_decoding_8bit,libdc1394),dc1394error_t,(Ptr{UInt8},Ptr{UInt8},UInt32,UInt32,dc1394color_filter_t,dc1394bayer_method_t),bayer,rgb,width,height,tile,method)
# end

# function bayer_decoding_16bit(bayer::Ptr{UInt16},rgb::Ptr{UInt16},width::Int,height::Int,tile::dc1394color_filter_t,method::dc1394bayer_method_t,bits::Int)
#     ccall((:dc1394_bayer_decoding_16bit,libdc1394),dc1394error_t,(Ptr{UInt16},Ptr{UInt16},UInt32,UInt32,dc1394color_filter_t,dc1394bayer_method_t,UInt32),bayer,rgb,width,height,tile,method,bits)
# end
