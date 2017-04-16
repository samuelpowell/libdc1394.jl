# DC1394.jl: interface to the libDC1394 library
# Copyright (C) 2016 tkato, 2017 Samuel Powell

# register.jl - function mappings for register.h (complete)

export
  get_registers,
  set_registers,
  get_register,
  set_register,
  get_control_registers,
  set_control_registers,
  get_control_register,
  set_control_register,
  get_adv_control_registers,
  set_adv_control_registers,
  get_adv_control_register,
  set_adv_control_registers,
  get_format7_register,
  set_format7_register,
  get_absolute_register,
  set_absolute_register,
  get_PIO_register,
  set_PIO_register,
  get_PIO_register,
  set_PIO_register,
  get_strobe_register,
  set_strobe_register

function get_registers(camera::Camera,offset::Integer,num_regs::Integer)
  value=Array{UInt32,1}(num_regs)
  @dcassert ccall((:dc1394_get_registers,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt64,Ptr{UInt32},UInt32),
    camera.handle,offset,value,num_regs)
  value
end

function get_register(camera::Camera,offset::Integer)
  value=[UInt32(0)]
  @dcassert ccall((:dc1394_get_register,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt64,Ptr{UInt32}),
    camera.handle,offset,value)
  value[1]
end

function set_registers(camera::Camera,offset::Integer,value::Array{UInt32,1})
  num_regs=UInt32(size(value,1))
  @dcassert ccall((:dc1394_set_registers,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt64,Ptr{UInt32},UInt32),
    camera.handle,offset,value,num_regs)
end

function set_register(camera::Camera,offset::Integer,value::Integer)
  @dcassert ccall((:dc1394_set_register,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt64,UInt32),
    camera.handle,offset,value)
end

function get_control_registers(camera::Camera,offset::Integer,num_regs::Integer)
  value=Array{UInt32,1}(num_regs)
  @dcassert ccall((:dc1394_get_control_registers,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt64,Ptr{UInt32},UInt32),
    camera.handle,offset,value,num_regs)
  value
end

function get_control_register(camera::Camera,offset::Integer)
  value=[UInt32(0)]
  @dcassert ccall((:dc1394_get_control_register,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt64,Ptr{UInt32}),
    camera.handle,offset,value)
  value[1]
end

function set_control_registers(camera::Camera,offset::Integer,value::Array{UInt32,1})
  num_regs=UInt32(size(value,1))
  @dcassert ccall((:dc1394_set_control_registers,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt64,Ptr{UInt32},UInt32),
    camera.handle,offset,value,num_regs)
end

function set_control_register(camera::Camera,offset::Integer,value::Integer)
  @dcassert ccall((:dc1394_set_control_register,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt64,UInt32),
    camera.handle,offset,value)
end

function get_adv_control_registers(camera::Camera,offset::Integer,num_regs::Integer)
  value=Array{UInt32,1}(num_regs)
  @dcassert ccall((:dc1394_get_adv_control_registers,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt64,Ptr{UInt32},UInt32),
    camera.handle,offset,value,num_regs)
  value
end

function get_adv_control_register(camera::Camera,offset::Integer)
  value=[UInt32(0)]
  @dcassert ccall((:dc1394_get_adv_control_register,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt64,Ptr{UInt32}),
    camera.value,offset,value)
  value[1]
end

function set_adv_control_registers(camera::Camera,offset::Integer,value::Array{UInt32,1})
  num_regs=UInt32(size(value,1))
  @dcassert ccall((:dc1394_set_adv_control_registers,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt64,Ptr{UInt32},UInt32),
    camera.handle,offset,value,num_regs)
end

function set_adv_control_register(camera::Camera,offset::Integer,value::Integer)
  @dcassert ccall((:dc1394_set_adv_control_register,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt64,UInt32),
    camera.handle,offset,value)
end

function get_format7_register(camera::Camera,mode::Integer,offset::Integer)
  value=[UInt32(0)]
  @dcassert ccall((:dc1394_get_format7_register,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt32,UInt64,Ptr{UInt32}),
    camera.handle,mode,offset,value)
  value[1]
end

function set_format7_register(camera::Camera,mode::Integer,offset::Integer,value::Integer)
  @dcassert ccall((:dc1394_set_format7_register,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt32,UInt64,UInt32),
    camera.handle,mode,offset,value)
end

function get_absolute_register(camera::Camera,feature::Integer,offset::Integer)
  value=[UInt32(0)]
  @dcassert ccall((:dc1394_get_absolute_register,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt32,UInt64,Ptr{UInt32}),
    camera.handle,feature,offset,value)
  value[1]
end

function set_absolute_register(camera::Camera,feature::Integer,offset::Integer,value::Integer)
  @dcassert ccall((:dc1394_set_absolute_register,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt32,UInt64,UInt32),
    camera.handle,feature,offset,value)
end

function get_PIO_register(camera::Camera,offset::Integer)
  value=[UInt32(0)]
  @dcassert ccall((:dc1394_get_PIO_register,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt64,Ptr{UInt32}),
    camera.handle,offset,value)
  value[1]
end

function set_PIO_register(camera::Camera,offset::Integer,value::Integer)
  @dcassert ccall((:dc1394_set_PIO_register,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt64,UInt32),
    camera.handle,offset,value)
end

function get_SIO_register(camera::Camera,offset::Integer)
  value=[UInt32(0)]
  @dcassert ccall((:dc1394_get_SIO_register,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt64,Ptr{UInt32}),
    camera.handle,offset,value)
  value[1]
end

function set_SIO_register(camera::Camera,offset::Integer,value::Integer)
  @dcassert ccall((:dc1394_set_SIO_register,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt64,UInt32),
    camera.handle,offset,value)
end

function get_strobe_register(camera::Camera,offset::UInt64)
  value=[UInt32(0)]
  @dcassert ccall((:dc1394_get_strobe_register,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt64,Ptr{UInt32}),
    camera.handle,offset,value)
  value[1]
end

function set_strobe_register(camera::Camera,offset::UInt64,value::Int)
  @dcassert ccall((:dc1394_set_strobe_register,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt64,UInt32),
    camera.handle,offset,value)
end
