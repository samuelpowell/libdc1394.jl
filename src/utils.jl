export
pio_set,pio_get,reset,set_power,memory_busy,memory_save,memory_load,
iso_set_persist,iso_allocate_channel,iso_release_channel,iso_allocate_bandwidth,iso_release_bandwidth,iso_release_all,
get_image_size,
get_data_depth,
get_bit_size,
get_color_coding,
is_color,
is_scalable,
is_still_image,
string,
checksum_crc16


function reset_bus(camera::Camera)
    ccall((:dc1394_reset_bus,libdc1394),Error,(Ptr{CameraInfo},),camera.handle)
end

function read_cycle_timer(camera::Camera)
    cycle_timer=[UInt32(0)]
    local_time=[UInt64(0)]
    ccall((:dc1394_read_cycle_timer,libdc1394),Error,(Ptr{CameraInfo},Ptr{UInt32},Ptr{UInt64}),camera.handle,cycle_timer,local_time)
    (Int(cycle_timer[1]),local_time[1])
end


function pio_set(camera::Camera,value::Int)
    ccall((:dc1394_pio_set,libdc1394),Error,(Ptr{CameraInfo},UInt32),camera.handle,value)
end

function pio_get(camera::Camera)
    value=[UInt32(0)]
    ccall((:dc1394_pio_get,libdc1394),Error,(Ptr{CameraInfo},Ptr{UInt32}),camera.handle,value)
    Int(value[1])
end

function memory_busy(camera::Camera)
    value=[Bool(FALSE)]
    ccall((:dc1394_memory_busy,libdc1394),Error,(Ptr{CameraInfo},Ptr{Bool}),camera.handle,value)
    value[1]==TRUE
end

function memory_save(camera::Camera,channel::Int)
    ccall((:dc1394_memory_save,libdc1394),Error,(Ptr{CameraInfo},UInt32),camera.handle,channel)
end

function memory_load(camera::Camera,channel::Int)
    ccall((:dc1394_memory_load,libdc1394),Error,(Ptr{CameraInfo},UInt32),camera.handle,channel)
end

function iso_set_persist(camera::Camera)
    ccall((:dc1394_iso_set_persist,libdc1394),Error,(Ptr{CameraInfo},),camera.handle)
end

function iso_allocate_channel(camera::Camera,channels_allowed::Integer)
    channel=[Cint(0)]
    ccall((:dc1394_iso_allocate_channel,libdc1394),Error,(Ptr{CameraInfo},UInt64,Ptr{Cint}),camera.handle,channels_allowed,channel)
    channel[1]
end

function iso_release_channel(camera::Camera,channel::Integer)
    ccall((:dc1394_iso_release_channel,libdc1394),Error,(Ptr{CameraInfo},Cint),camera.handle,channel)
end

function iso_allocate_bandwidth(camera::Camera,bandwidth_units::Integer)
    ccall((:dc1394_iso_allocate_bandwidth,libdc1394),Error,(Ptr{CameraInfo},Cint),camera.handle,bandwidth_units)
end

function iso_release_bandwidth(camera::Camera,bandwidth_units::Integer)
    ccall((:dc1394_iso_release_bandwidth,libdc1394),Error,(Ptr{CameraInfo},Cint),camera.handle,bandwidth_units)
end

function iso_release_all(camera::Camera)
    ccall((:dc1394_iso_release_all,libdc1394),Error,(Ptr{CameraInfo},),camera.handle)
end

function get_registers(camera::Camera,offset::Integer,num_regs::Integer)
    value=Array{UInt32,1}(num_regs)
    ccall((:dc1394_get_registers,libdc1394),Error,(Ptr{CameraInfo},UInt64,Ptr{UInt32},UInt32),camera.handle,offset,value,num_regs)
    value
end

function get_register(camera::Camera,offset::Integer)
    value=[UInt32(0)]
    ccall((:dc1394_get_register,libdc1394),Error,(Ptr{CameraInfo},UInt64,Ptr{UInt32}),camera.handle,offset,value)
    value[1]
end

function set_registers(camera::Camera,offset::Integer,value::Array{UInt32,1})
    num_regs=UInt32(size(value,1))
    ccall((:dc1394_set_registers,libdc1394),Error,(Ptr{CameraInfo},UInt64,Ptr{UInt32},UInt32),camera.handle,offset,value,num_regs)
end

function set_register(camera::Camera,offset::Integer,value::Integer)
    ccall((:dc1394_set_register,libdc1394),Error,(Ptr{CameraInfo},UInt64,UInt32),camera.handle,offset,value)
end

function get_control_registers(camera::Camera,offset::Integer,num_regs::Integer)
    value=Array{UInt32,1}(num_regs)
    ccall((:dc1394_get_control_registers,libdc1394),Error,(Ptr{CameraInfo},UInt64,Ptr{UInt32},UInt32),camera.handle,offset,value,num_regs)
    value
end

function get_control_register(camera::Camera,offset::Integer)
    value=[UInt32(0)]
    ccall((:dc1394_get_control_register,libdc1394),Error,(Ptr{CameraInfo},UInt64,Ptr{UInt32}),camera.handle,offset,value)
    value[1]
end

function set_control_registers(camera::Camera,offset::Integer,value::Array{UInt32,1})
    num_regs=UInt32(size(value,1))
    ccall((:dc1394_set_control_registers,libdc1394),Error,(Ptr{CameraInfo},UInt64,Ptr{UInt32},UInt32),camera.handle,offset,value,num_regs)
end

function set_control_register(camera::Camera,offset::Integer,value::Integer)
    ccall((:dc1394_set_control_register,libdc1394),Error,(Ptr{CameraInfo},UInt64,UInt32),camera.handle,offset,value)
end

function get_adv_control_registers(camera::Camera,offset::Integer,num_regs::Integer)
    value=Array{UInt32,1}(num_regs)
    ccall((:dc1394_get_adv_control_registers,libdc1394),Error,(Ptr{CameraInfo},UInt64,Ptr{UInt32},UInt32),camera.handle,offset,value,num_regs)
    value
end

function get_adv_control_register(camera::Camera,offset::Integer)
    value=[UInt32(0)]
    ccall((:dc1394_get_adv_control_register,libdc1394),Error,(Ptr{CameraInfo},UInt64,Ptr{UInt32}),camera.value,offset,value)
    value[1]
end

function set_adv_control_registers(camera::Camera,offset::Integer,value::Array{UInt32,1})
    num_regs=UInt32(size(value,1))
    ccall((:dc1394_set_adv_control_registers,libdc1394),Error,(Ptr{CameraInfo},UInt64,Ptr{UInt32},UInt32),camera.handle,offset,value,num_regs)
end

function set_adv_control_register(camera::Camera,offset::Integer,value::Integer)
    ccall((:dc1394_set_adv_control_register,libdc1394),Error,(Ptr{CameraInfo},UInt64,UInt32),camera.handle,offset,value)
end

function get_format7_register(camera::Camera,mode::Integer,offset::Integer)
    value=[UInt32(0)]
    ccall((:dc1394_get_format7_register,libdc1394),Error,(Ptr{CameraInfo},UInt32,UInt64,Ptr{UInt32}),camera.handle,mode,offset,value)
    value[1]
end

function set_format7_register(camera::Camera,mode::Integer,offset::Integer,value::Integer)
    ccall((:dc1394_set_format7_register,libdc1394),Error,(Ptr{CameraInfo},UInt32,UInt64,UInt32),camera.handle,mode,offset,value)
end

function get_absolute_register(camera::Camera,feature::Integer,offset::Integer)
    value=[UInt32(0)]
    ccall((:dc1394_get_absolute_register,libdc1394),Error,(Ptr{CameraInfo},UInt32,UInt64,Ptr{UInt32}),camera.handle,feature,offset,value)
    value[1]
end

function set_absolute_register(camera::Camera,feature::Integer,offset::Integer,value::Integer)
    ccall((:dc1394_set_absolute_register,libdc1394),Error,(Ptr{CameraInfo},UInt32,UInt64,UInt32),camera.handle,feature,offset,value)
end

function get_PIO_register(camera::Camera,offset::Integer)
    value=[UInt32(0)]
    ccall((:dc1394_get_PIO_register,libdc1394),Error,(Ptr{CameraInfo},UInt64,Ptr{UInt32}),camera.handle,offset,value)
    value[1]
end

function set_PIO_register(camera::Camera,offset::Integer,value::Integer)
    ccall((:dc1394_set_PIO_register,libdc1394),Error,(Ptr{CameraInfo},UInt64,UInt32),camera.handle,offset,value)
end

function get_SIO_register(camera::Camera,offset::Integer)
    value=[UInt32(0)]
    ccall((:dc1394_get_SIO_register,libdc1394),Error,(Ptr{CameraInfo},UInt64,Ptr{UInt32}),camera.handle,offset,value)
    value[1]
end

function set_SIO_register(camera::Camera,offset::Integer,value::Integer)
    ccall((:dc1394_set_SIO_register,libdc1394),Error,(Ptr{CameraInfo},UInt64,UInt32),camera.handle,offset,value)
end

function get_strobe_register(camera::Camera,offset::UInt64)
    value=[UInt32(0)]
    ccall((:dc1394_get_strobe_register,libdc1394),Error,(Ptr{CameraInfo},UInt64,Ptr{UInt32}),camera.handle,offset,value)
    value[1]
end

function set_strobe_register(camera::Camera,offset::UInt64,value::Int)
    ccall((:dc1394_set_strobe_register,libdc1394),Error,(Ptr{CameraInfo},UInt64,UInt32),camera.handle,offset,value)
end

function get_image_size(camera::Camera,video_mode::VideoMode)
    width=Array{UInt32,1}(1)
    height=Array{UInt32,1}(1)
    ccall((:dc1394_get_image_size_from_video_mode,libdc1394),Error,(Ptr{CameraInfo},VideoMode,Ptr{UInt32},Ptr{UInt32}),
          camera.handle,video_mode,width,height)
    (width[1],height[1])
end

function get_data_depth(color_coding::ColorCoding)
    bits=[UInt32(0)]
    ccall((:dc1394_get_color_coding_data_depth,libdc1394),Error,(ColorCoding,Ptr{UInt32}),color_coding,bits)
    Int(bits[1])
end

function get_bit_size(color_coding::ColorCoding)
    bits=[UInt32(0)]
    ccall((:dc1394_get_color_coding_bit_size,libdc1394),Error,(ColorCoding,Ptr{UInt32}),color_coding,bits)
    Int(bits[1])
end

function get_color_coding(camera::Camera,video_mode::VideoMode)
    color_coding=Array{ColorCoding,1}(1)
    ccall((:dc1394_get_color_coding_from_video_mode,libdc1394),Error,(Ptr{CameraInfo},VideoMode,Ptr{ColorCoding}),camera.handle,video_mode,color_coding)
    color_coding[1]
end

function is_color(color_mode::ColorCoding)
    is_color=[Bool(FALSE)]
    ccall((:dc1394_is_color,libdc1394),Error,(ColorCoding,Ptr{Bool}),color_mode,is_color)
    is_color[1]==TRUE
end

function is_scalable(video_mode::VideoMode)
    val=ccall((:dc1394_is_video_mode_scalable,libdc1394),Bool,(VideoMode,),video_mode)
    val==TRUE
end

function is_still_image(video_mode::VideoMode)
    val=ccall((:dc1394_is_video_mode_still_image,libdc1394),Bool,(VideoMode,),video_mode)
    val==TRUE
end

function string(error::Error)
    ptr=ccall((:dc1394_error_get_string,libdc1394),Cstring,(Error,),error)
    bytestring(ptr)
end

function checksum_crc16(buffer::Ptr{UInt8},buffer_size::Int)
    ccall((:dc1394_checksum_crc16,libdc1394),UInt16,(Ptr{UInt8},UInt32),buffer,buffer_size)
end



"""
enum dc1394log_t
"""
@enum(Log,
      LOG_ERROR = (UInt32)(768),
      LOG_WARNING = (UInt32)(769),
      LOG_DEBUG = (UInt32)(770))

const LOG_MIN = LOG_ERROR
const LOG_MAX = LOG_DEBUG
const LOG_NUM = (Int(LOG_MAX) - Int(LOG_MIN)) + 1
function register_handler(_type::Log,log_handler::Ptr{Void},user::Ptr{Void})
    ccall((:dc1394_log_register_handler,libdc1394),Error,(Log,Ptr{Void},Ptr{Void}),_type,log_handler,user)
end

function set_default_handler(_type::Log)
    ccall((:dc1394_log_set_default_handler,libdc1394),Error,(Log,),_type)
end
