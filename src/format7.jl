# libDC1394.jl: interface to the libDC1394 library
# Copyright (c) 2016 tkato
# Copyright (C) 2017 Samuel Powell

export
  format7_get_max_image_size,
  format7_get_unit_size,
  format7_get_image_size,
  format7_set_image_size,
  format7_get_image_position,
  format7_set_image_position,
  format7_get_unit_position,
  format7_get_color_coding,
  format7_get_color_codings,
  format7_set_color_coding,
  format7_get_color_filter,
  format7_get_packet_parameters,
  format7_get_packet_size,
  format7_set_packet_size,
  format7_get_recommended_packet_size,
  format7_get_packets_per_frame,
  format7_get_data_depth,
  format7_get_frame_interval,
  format7_get_pixel_number,
  format7_get_total_bytes,
  format7_get_modeset,
  format7_get_mode_info,
  format7_set_roi,
  format7_get_roi

"""
enum dc1394color_coding_t
"""
@enum(dc1394color_coding_t,
      COLOR_CODING_MONO8 = (UInt32)(352),
      COLOR_CODING_YUV411 = (UInt32)(353),
      COLOR_CODING_YUV422 = (UInt32)(354),
      COLOR_CODING_YUV444 = (UInt32)(355),
      COLOR_CODING_RGB8 = (UInt32)(356),
      COLOR_CODING_MONO16 = (UInt32)(357),
      COLOR_CODING_RGB16 = (UInt32)(358),
      COLOR_CODING_MONO16S = (UInt32)(359),
      COLOR_CODING_RGB16S = (UInt32)(360),
      COLOR_CODING_RAW8 = (UInt32)(361),
      COLOR_CODING_RAW16 = (UInt32)(362))

const COLOR_CODING_MIN = COLOR_CODING_MONO8
const COLOR_CODING_MAX = COLOR_CODING_RAW16
const COLOR_CODING_NUM = (Int(COLOR_CODING_MAX) - Int(COLOR_CODING_MIN)) + 1

immutable dc1394color_codings_t
  num::UInt32
  codings::NTuple{11,dc1394color_coding_t}
  dc1394color_codings_t()=new(0,ntuple(i->COLOR_CODING_MIN,11))
end

show(io::IO,cs::dc1394color_codings_t)=0<cs.num<11? show(io,cs.codings[1:cs.num]):()

immutable dc1394format7mode_t
  present::dc1394bool_t
  size_x::UInt32
  size_y::UInt32
  max_size_x::UInt32
  max_size_y::UInt32
  pos_x::UInt32
  pos_y::UInt32
  unit_size_x::UInt32
  unit_size_y::UInt32
  unit_pos_x::UInt32
  unit_pos_y::UInt32
  color_codings::dc1394color_codings_t
  color_coding::dc1394color_coding_t
  pixnum::UInt32
  packet_size::UInt32
  unit_packet_size::UInt32
  max_packet_size::UInt32
  total_bytes::UInt64
  color_filter::dc1394color_filter_t
end

function show(io::IO, fm::dc1394format7mode_t)
  print(io,"dc1394format7mode_t:\n");
  for fname in fieldnames(fm)
      print(io,"\t$(fname):\t$(getfield(fm,fname))\n");
  end
end

function format7_get_max_image_size(camera::Camera,video_mode::dc1394video_mode_t)
  width=[UInt32(0)]
  height=[UInt32(0)]
  ccall((:dc1394_format7_get_max_image_size,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},dc1394video_mode_t,Ptr{UInt32},Ptr{UInt32}),
    camera.handle,video_mode,width,height)
  (Int(width[1]),Int(height[1]))
end
format7_get_max_image_size(camera::Camera)=format7_get_max_image_size(camera,video_get_mode(camera))

function format7_get_unit_size(camera::Camera,video_mode::dc1394video_mode_t)
  h_unit=[UInt32(0)]
  v_unit=[UInt32(0)]
  ccall((:dc1394_format7_get_unit_size,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},dc1394video_mode_t,Ptr{UInt32},Ptr{UInt32}),
    camera.handle,video_mode,h_unit,v_unit)
  (Int(h_unit[1]),Int(v_unit[1]))
end
format7_get_unit_size(camera::Camera)=get_unit_size(camera,video_get_mode(camera))

function format7_get_image_size(camera::Camera,video_mode::dc1394video_mode_t)
  width=[UInt32(0)]
  height=[UInt32(0)]
  ccall((:dc1394_format7_get_image_size,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},dc1394video_mode_t,Ptr{UInt32},Ptr{UInt32}),
    camera.handle,video_mode,width,height)
  (Int(width[1]),Int(height[1]))
end

function format7_set_image_size(camera::Camera,video_mode::dc1394video_mode_t,width::Int,height::Int)
  ccall((:dc1394_format7_set_image_size,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},dc1394video_mode_t,UInt32,UInt32),
    camera.handle,video_mode,width,height)
end
format7_set_image_size(camera::Camera,width::Int,height::Int)=format7_set_image_size(camera,video_get_mode(camera),width,height)

function format7_get_image_position(camera::Camera,video_mode::dc1394video_mode_t)
  top=[UInt32(0)]
  left=[UInt32(0)]
  ccall((:dc1394_format7_get_image_position,libdc1394),dc1394error_t,(Ptr{dc1394camera_info_t},dc1394video_mode_t,Ptr{UInt32},Ptr{UInt32}),camera.handle,video_mode,left,top)
  (Int(left[1]),Int(top[1]))
end
format7_get_image_position(camera::Camera)=format7_get_image_position(camera,video_get_mode(camera))

function format7_set_image_position(camera::Camera,video_mode::dc1394video_mode_t,left::Int,top::Int)
  ccall((:dc1394_format7_set_image_position,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},dc1394video_mode_t,UInt32,UInt32),
    camera.handle,video_mode,left,top)
end
format7_set_image_position(camera::Camera,left::Int,right::Int)=format7_set_image_position(camera,video_get_mode(camera),left,right)

function format7_get_unit_position(camera::Camera,video_mode::dc1394video_mode_t)
  h_unit=[UInt32(0)]
  v_unit=[UInt32(0)]
  ccall((:dc1394_format7_get_unit_position,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},dc1394video_mode_t,Ptr{UInt32},Ptr{UInt32}),
    camera.handle,video_mode,h_unit_pos,v_unit_pos)
  (Int(h_unit[1]),Int(v_unit[1]))
end
format7_get_unit_position(camera::Camera)=format7_get_unit_position(camera,video_get_mode(camera))

function format7_get_color_coding(camera::Camera,video_mode::dc1394video_mode_t)
  color_coding=Array{dc1394color_coding_t,1}(1)
  ccall((:dc1394_format7_get_color_coding,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},dc1394video_mode_t,Ptr{dc1394color_coding_t}),
    camera.handle,video_mode,color_coding)
  color_coding[1]
end

function format7_get_color_codings(camera::Camera,video_mode::dc1394video_mode_t)
  codings=Array{dc1394color_codings_t,1}(1)
  ccall((:dc1394_format7_get_color_codings,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},dc1394video_mode_t,Ptr{dc1394color_codings_t}),
    camera.handle,video_mode,codings)
  codings[1].codings[1:codings[1].num]
end
format7_get_color_codings(camera::Camera)=format7_get_color_codings(camera,video_get_mode(camera))

function format7_set_color_coding(camera::Camera,video_mode::dc1394video_mode_t,color_coding::dc1394color_coding_t)
  ccall((:dc1394_format7_set_color_coding,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},dc1394video_mode_t,dc1394color_coding_t),
    camera.handle,video_mode,color_coding)
end
format7_set_color_coding(camera::Camera,color_coding::dc1394color_coding_t)=format7_set_color_coding(camera,video_get_mode(camera),color_coding)

function format7_get_color_filter(camera::Camera,video_mode::dc1394video_mode_t)
  color_filter=Array{dc1394color_filter_t,1}(1)
  ccall((:dc1394_format7_get_color_filter,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},dc1394video_mode_t,Ptr{dc1394color_filter_t}),
    camera.handle,video_mode,color_filter)
  color_filter[1]
end
format7_get_color_filter(camera::Camera)=format7_get_color_filter(camera,video_get_mode(camera))

function format7_get_packet_parameters(camera::Camera,video_mode::dc1394video_mode_t)
  unit_bytes=[UInt32(0)]
  max_bytes=[UInt32(0)]
  ccall((:dc1394_format7_get_packet_parameters,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},dc1394video_mode_t,Ptr{UInt32},Ptr{UInt32}),
    camera.handle,video_mode,unit_bytes,max_bytes)
  (Int(unit_bytes[1]),Int(max_bytes[1]))
end
format7_get_packet_parameters(camera::Camera)=get_packet_parameters(camera,video_get_mode(camera))

function format7_get_packet_size(camera::Camera,video_mode::dc1394video_mode_t)
  packet_size=[UInt32(0)]
  ccall((:dc1394_format7_get_packet_size,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},dc1394video_mode_t,Ptr{UInt32}),
    camera.handle,video_mode,packet_size)
  Int(packet_size[1])
end
format7_get_packet_size(camera::Camera)=format7_get_packet_size(camera,video_get_mode(camera))

function format7_set_packet_size(camera::Camera,video_mode::dc1394video_mode_t,packet_size::Int)
  ccall((:dc1394_format7_set_packet_size,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},dc1394video_mode_t,UInt32),
    camera.handle,video_mode,packet_size)
end
format7_set_packet_size(camera::Camera,packet_size::Int)=format7_set_packet_size(camera,video_get_mode(camera),packet_size)

function format7_get_recommended_packet_size(camera::Camera,video_mode::dc1394video_mode_t)
  packet_size=[UInt32(0)]
  ccall((:dc1394_format7_get_recommended_packet_size,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},dc1394video_mode_t,Ptr{UInt32}),
    camera.handle,video_mode,packet_size)
  Int(packet_size[1])
end
format7_get_recommended_packet_size(camera::Camera)=format7_get_recommended_packet_size(camera,video_get_mode(camera))

function format7_get_packets_per_frame(camera::Camera,video_mode::dc1394video_mode_t)
  ppf=[UInt32(0)]
  ccall((:dc1394_format7_get_packets_per_frame,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},dc1394video_mode_t,Ptr{UInt32}),
    camera.handle,video_mode,ppf)
  Int(ppf[1])
end
format7_get_packets_per_frame(camera::Camera)=format7_get_packets_per_frame(camera,video_get_mode(camera))

function format7_get_data_depth(camera::Camera,video_mode::dc1394video_mode_t)
  data_depth=[UInt32(0)]
  ccall((:dc1394_format7_get_data_depth,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},dc1394video_mode_t,Ptr{UInt32}),
    camera.handle,video_mode,data_depth)
  Int(data_depth[1])
end
format7_get_data_depth(camera::Camera)=format7_get_data_depth(camera,video_get_mode(camera))

function format7_get_frame_interval(camera::Camera,video_mode::dc1394video_mode_t)
  interval=[Cfloat(0.0)]
  ccall((:dc1394_format7_get_frame_interval,libdc1394),
    dc1394error_t,(Ptr{dc1394camera_info_t},
    dc1394video_mode_t,Ptr{Cfloat}),
    camera.handle,video_mode,interval)
  interval[1]
end
format7_get_frame_interval(camera::Camera)=format7_get_frame_interval(camera,video_get_mode(camera))

function format7_get_pixel_number(camera::Camera,video_mode::dc1394video_mode_t)
  pixnum=[UInt32(0)]
  ccall((:dc1394_format7_get_pixel_number,libdc1394),
    dc1394error_t,(Ptr{dc1394camera_info_t},
    dc1394video_mode_t,Ptr{UInt32}),
    camera.handle,video_mode,pixnum)
  Int(pixnum[1])
end
format7_get_pixel_number(camera::Camera)=format7_get_pixel_number(camera,video_get_mode(camera))

function format7_get_total_bytes(camera::Camera,video_mode::dc1394video_mode_t)
  total_bytes=[UInt64(0)]
  ccall((:dc1394_format7_get_total_bytes,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},dc1394video_mode_t,Ptr{UInt64}),
    camera.handle,video_mode,total_bytes)
  total_bytes[1]
end
format7_get_total_bytes(camera::Camera)=format7_get_total_bytes(camera,video_get_mode(camera))

function format7_get_modeset(camera::Camera)
  info=Array{dc1394format7mode_t,1}(8)
  ccall((:dc1394_format7_get_modeset,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},Ptr{dc1394format7mode_t}),
    camera.handle,info)
  info
end

function format7_get_mode_info(camera::Camera,video_mode::dc1394video_mode_t)
  f7_mode=Array{dc1394format7mode_t,1}(1)
  ccall((:dc1394_format7_get_mode_info,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t}, dc1394video_mode_t,Ptr{dc1394format7mode_t}),
    camera.handle,video_mode,f7_mode)
  f7_mode[1]
end
format7_get_mode_info(camera::Camera)=format7_get_mode_info(camera,video_get_mode(camera))

function format7_set_roi(camera::Camera,video_mode::dc1394video_mode_t,color_coding::dc1394color_coding_t,packet_size::Int,left::Int,top::Int,width::Int,height::Int)
  ccall((:dc1394_format7_set_roi,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},dc1394video_mode_t,dc1394color_coding_t,Int32,Int32,Int32,Int32,Int32),
    camera.handle,video_mode,color_coding,packet_size,left,top,width,height)
end
format7_set_roi(camera::Camera,color_coding::dc1394color_coding_t,packet_size::Int,left::Int,top::Int,width::Int,height::Int)=format7_set_roi(camera,video_get_mode(camera),color_coding,packet_size,left,top,width,height)

function format7_get_roi(camera::Camera,video_mode::dc1394video_mode_t)
  color_coding=Array{dc1394color_coding_t,1}(1)
  packet_size=[UInt32(0)]
  left=[UInt32(0)]
  top=[UInt32(0)]
  width=[UInt32(0)]
  height=[UInt32(0)]
  ccall((:dc1394_format7_get_roi,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},dc1394video_mode_t,Ptr{dc1394color_coding_t},Ptr{UInt32},Ptr{UInt32},Ptr{UInt32},Ptr{UInt32},Ptr{UInt32}),
    camera.handle,video_mode,color_coding,packet_size,left,top,width,height)
  (color_coding[1],Int(packet_size[1]),Int(left[1]),Int(top[1]),Int(width[1]),Int(height[1]))
end
format7_get_roi(camera::Camera)=format7_get_roi(camera,video_get_mode(camera))
