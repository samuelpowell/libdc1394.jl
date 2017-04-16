# DC1394.jl: interface to the libDC1394 library
# Copyright (c) 2016 tkato
# Copyright (C) 2017 Samuel Powell

export
  pio_set,
  pio_get,
  get_image_size_from_video_mode,
  get_color_coding_data_depth,
  get_color_coding_bit_size,
  get_color_coding_from_video_mode,
  is_color,
  is_video_mode_scalable,
  is_video_mode_still_image,
  error_get_string,
  checksum_crc16

function pio_set(camera::Camera,value::Int)
  ccall((:dc1394_pio_set,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt32),
    camera.handle,value)
end

function pio_get(camera::Camera)
  value=[UInt32(0)]
  ccall((:dc1394_pio_get,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},Ptr{UInt32}),
    camera.handle,value)
  Int(value[1])
end

function get_registers(camera::Camera,offset::Integer,num_regs::Integer)
  value=Array{UInt32,1}(num_regs)
  ccall((:dc1394_get_registers,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt64,Ptr{UInt32},UInt32),
    camera.handle,offset,value,num_regs)
  value
end

function get_register(camera::Camera,offset::Integer)
  value=[UInt32(0)]
  ccall((:dc1394_get_register,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt64,Ptr{UInt32}),
    camera.handle,offset,value)
  value[1]
end

function set_registers(camera::Camera,offset::Integer,value::Array{UInt32,1})
  num_regs=UInt32(size(value,1))
  ccall((:dc1394_set_registers,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt64,Ptr{UInt32},UInt32),
    camera.handle,offset,value,num_regs)
end

function set_register(camera::Camera,offset::Integer,value::Integer)
  ccall((:dc1394_set_register,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt64,UInt32),
    camera.handle,offset,value)
end

function get_control_registers(camera::Camera,offset::Integer,num_regs::Integer)
  value=Array{UInt32,1}(num_regs)
  ccall((:dc1394_get_control_registers,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt64,Ptr{UInt32},UInt32),
    camera.handle,offset,value,num_regs)
  value
end

function get_control_register(camera::Camera,offset::Integer)
  value=[UInt32(0)]
  ccall((:dc1394_get_control_register,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt64,Ptr{UInt32}),
    camera.handle,offset,value)
  value[1]
end

function set_control_registers(camera::Camera,offset::Integer,value::Array{UInt32,1})
  num_regs=UInt32(size(value,1))
  ccall((:dc1394_set_control_registers,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt64,Ptr{UInt32},UInt32),
    camera.handle,offset,value,num_regs)
end

function set_control_register(camera::Camera,offset::Integer,value::Integer)
  ccall((:dc1394_set_control_register,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt64,UInt32),
    camera.handle,offset,value)
end

function get_adv_control_registers(camera::Camera,offset::Integer,num_regs::Integer)
  value=Array{UInt32,1}(num_regs)
  ccall((:dc1394_get_adv_control_registers,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt64,Ptr{UInt32},UInt32),
    camera.handle,offset,value,num_regs)
  value
end

function get_adv_control_register(camera::Camera,offset::Integer)
  value=[UInt32(0)]
  ccall((:dc1394_get_adv_control_register,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt64,Ptr{UInt32}),
    camera.value,offset,value)
  value[1]
end

function set_adv_control_registers(camera::Camera,offset::Integer,value::Array{UInt32,1})
  num_regs=UInt32(size(value,1))
  ccall((:dc1394_set_adv_control_registers,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt64,Ptr{UInt32},UInt32),
    camera.handle,offset,value,num_regs)
end

function set_adv_control_register(camera::Camera,offset::Integer,value::Integer)
  ccall((:dc1394_set_adv_control_register,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt64,UInt32),
    camera.handle,offset,value)
end

function get_format7_register(camera::Camera,mode::Integer,offset::Integer)
  value=[UInt32(0)]
  ccall((:dc1394_get_format7_register,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt32,UInt64,Ptr{UInt32}),
    camera.handle,mode,offset,value)
  value[1]
end

function set_format7_register(camera::Camera,mode::Integer,offset::Integer,value::Integer)
  ccall((:dc1394_set_format7_register,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt32,UInt64,UInt32),
    camera.handle,mode,offset,value)
end

function get_absolute_register(camera::Camera,feature::Integer,offset::Integer)
  value=[UInt32(0)]
  ccall((:dc1394_get_absolute_register,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt32,UInt64,Ptr{UInt32}),
    camera.handle,feature,offset,value)
  value[1]
end

function set_absolute_register(camera::Camera,feature::Integer,offset::Integer,value::Integer)
  ccall((:dc1394_set_absolute_register,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt32,UInt64,UInt32),
    camera.handle,feature,offset,value)
end

function get_PIO_register(camera::Camera,offset::Integer)
  value=[UInt32(0)]
  ccall((:dc1394_get_PIO_register,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt64,Ptr{UInt32}),
    camera.handle,offset,value)
  value[1]
end

function set_PIO_register(camera::Camera,offset::Integer,value::Integer)
  ccall((:dc1394_set_PIO_register,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt64,UInt32),
    camera.handle,offset,value)
end

function get_SIO_register(camera::Camera,offset::Integer)
  value=[UInt32(0)]
  ccall((:dc1394_get_SIO_register,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt64,Ptr{UInt32}),
    camera.handle,offset,value)
  value[1]
end

function set_SIO_register(camera::Camera,offset::Integer,value::Integer)
  ccall((:dc1394_set_SIO_register,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt64,UInt32),
    camera.handle,offset,value)
end

function get_strobe_register(camera::Camera,offset::UInt64)
  value=[UInt32(0)]
  ccall((:dc1394_get_strobe_register,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt64,Ptr{UInt32}),
    camera.handle,offset,value)
  value[1]
end

function set_strobe_register(camera::Camera,offset::UInt64,value::Int)
  ccall((:dc1394_set_strobe_register,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt64,UInt32),
    camera.handle,offset,value)
end

function get_image_size_from_video_mode(camera::Camera,video_mode::dc1394video_mode_t)
  width=Array{UInt32,1}(1)
  height=Array{UInt32,1}(1)
  ccall((:dc1394_get_image_size_from_video_mode_from_video_mode,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},dc1394video_mode_t,Ptr{UInt32},Ptr{UInt32}),
    camera.handle,video_mode,width,height)
  (Int(width[1]),Int(height[1]))
end

get_image_size_from_video_mode(camera::Camera)=get_image_size_from_video_mode(camera,video_get_mode(camera))


function get_color_coding_data_depth(color_coding::dc1394color_coding_t)
  bits=[UInt32(0)]
  ccall((:dc1394_get_color_coding_from_video_mode_data_depth,libdc1394),
    dc1394error_t,
    (dc1394color_coding_t,Ptr{UInt32}),
    color_coding,bits)
  Int(bits[1])
end

function get_color_coding_bit_size(color_coding::dc1394color_coding_t)
  bits=[UInt32(0)]
  ccall((:dc1394_get_color_coding_from_video_mode_bit_size,libdc1394),
    dc1394error_t,
    (dc1394color_coding_t,Ptr{UInt32}),
    color_coding,bits)
  Int(bits[1])
end

function get_color_coding_from_video_mode(camera::Camera,video_mode::dc1394video_mode_t)
  color_coding=Array{dc1394color_coding_t,1}(1)
  ccall((:dc1394_get_color_coding_from_video_mode_from_video_mode,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},dc1394video_mode_t,Ptr{dc1394color_coding_t}),
    camera.handle,video_mode,color_coding)
  color_coding[1]
end

get_color_coding_from_video_mode(camera::Camera)=get_color_coding_from_video_mode(camera,video_get_mode(camera))

function is_color(color_mode::dc1394color_coding_t)
  is_color=[dc1394bool_t(FALSE)]
  ccall((:dc1394_is_color,libdc1394),
    dc1394error_t,
    (dc1394color_coding_t,Ptr{dc1394bool_t}),
    color_mode,is_color)
  is_color[1]==TRUE
end

function is_video_mode_scalable(video_mode::dc1394video_mode_t)
  val=ccall((:dc1394_is_video_mode_scalable,libdc1394),
    dc1394bool_t,
    (dc1394video_mode_t,),
    video_mode)
  val==TRUE
end

function is_video_mode_still_image(video_mode::dc1394video_mode_t)
  val=ccall((:dc1394_is_video_mode_still_image,libdc1394),
    dc1394bool_t,
    (dc1394video_mode_t,),
    video_mode)
  val==TRUE
end

function error_get_string(error::dc1394error_t)
  ptr=ccall((:dc1394_error_get_string,libdc1394),
    Cstring,
    (dc1394error_t,),
    error)
  unsafe_string(ptr)
end

function checksum_crc16(buffer::Ptr{UInt8},buffer_size::Int)
  ccall((:dc1394_checksum_crc16,libdc1394),
    UInt16,
    (Ptr{UInt8},UInt32),
    buffer,buffer_size)
end
