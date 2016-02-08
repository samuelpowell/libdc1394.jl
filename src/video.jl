export get_supported_video_modes,get_video_mode,set_video_mode,
get_supported_framerates,get_framerate,set_framerate,
get_operation_mode,set_operation_mode,
get_iso_speed,set_iso_speed,
get_iso_channel,set_iso_channel,
get_data_depth,
set_transmission,get_transmission,
set_one_shot,get_one_shot,
set_multi_shot,get_multi_shot,
get_bandwidth_usage
function get_supported_video_modes(camera::Camera)
    modes=Array{dc1394video_modes_t,1}(1)
    ccall((:dc1394_video_get_supported_modes,libdc1394),
          Error,(Ptr{CameraInfo},Ptr{dc1394video_modes_t}),
          camera.handle,modes)
    modes[1].modes[1:modes[1].num]
end

function get_video_mode(camera::Camera)
    video_mode=Array{VideoMode,1}(1)
    ccall((:dc1394_video_get_mode,libdc1394),Error,(Ptr{CameraInfo},Ptr{VideoMode}),camera.handle,video_mode)
    video_mode[1]
end

function set_video_mode(camera::Camera,video_mode::VideoMode)
    ccall((:dc1394_video_set_mode,libdc1394),Error,(Ptr{CameraInfo},VideoMode),camera.handle,video_mode)
end

function get_supported_framerates(camera::Camera,video_mode::VideoMode)
    framerates=Array{dc1394framerates_t,1}(1)
    ccall((:dc1394_video_get_supported_framerates,libdc1394),Error,(Ptr{CameraInfo},VideoMode,Ptr{dc1394framerates_t}),camera.handle,video_mode,framerates)
    framerates[1].framerates[1:framerates[1].num]
end

function get_framerate(camera::Camera)
    framerate=Array{Framerate,1}(1)
    ccall((:dc1394_video_get_framerate,libdc1394),Error,(Ptr{CameraInfo},Ptr{Framerate}),camera.handle,framerate)
    framerate[1]
end

function set_framerate(camera::Camera,framerate::Framerate)
    ccall((:dc1394_video_set_framerate,libdc1394),Error,(Ptr{CameraInfo},Framerate),camera.handle,framerate)
end

function get_operation_mode(camera::Camera)
    mode=Array{OperationMode,1}(1)
    ccall((:dc1394_video_get_operation_mode,libdc1394),Error,(Ptr{CameraInfo},Ptr{OperationMode}),camera.handle,mode)
    mode[1]
end

function set_operation_mode(camera::Camera,mode::OperationMode)
    ccall((:dc1394_video_set_operation_mode,libdc1394),Error,(Ptr{CameraInfo},OperationMode),camera.handle,mode)
end

function get_iso_speed(camera::Camera)
    speed=Array{Speed,1}(1)
    ccall((:dc1394_video_get_iso_speed,libdc1394),Error,(Ptr{CameraInfo},Ptr{Speed}),camera.handle,speed)
    speed[1]
end

function set_iso_speed(camera::Camera,speed::Speed)
    ccall((:dc1394_video_set_iso_speed,libdc1394),Error,(Ptr{CameraInfo},Speed),camera.handle,speed)
end

function get_iso_channel(camera::Camera)
    channel=[UInt32(0)]
    ccall((:dc1394_video_get_iso_channel,libdc1394),Error,(Ptr{CameraInfo},Ptr{UInt32}),camera.handle,channel)
    Int(channel[1])
end

function set_iso_channel(camera::Camera,channel::Int)
    ccall((:dc1394_video_set_iso_channel,libdc1394),Error,(Ptr{CameraInfo},UInt32),camera.handle,channel)
end

function get_data_depth(camera::Camera)
    depth=[UInt32(0)]
    ccall((:dc1394_video_get_data_depth,libdc1394),Error,(Ptr{CameraInfo},Ptr{UInt32}),camera.handle,depth)
    Int(depth[1])
end

function set_transmission(camera::Camera,pwr::Switch)
    ccall((:dc1394_video_set_transmission,libdc1394),Error,(Ptr{CameraInfo},Switch),camera.handle,pwr)
end

function get_transmission(camera::Camera)
    pwr=[Switch(OFF)]
    ccall((:dc1394_video_get_transmission,libdc1394),Error,(Ptr{CameraInfo},Ptr{Switch}),camera.handle,pwr)
    pwr[1]
end

function set_one_shot(camera::Camera,pwr::Switch)
    ccall((:dc1394_video_set_one_shot,libdc1394),Error,(Ptr{CameraInfo},Switch),camera.handle,pwr)
end

function get_one_shot(camera::Camera)
    is_on=[Bool(FALSE)]
    ccall((:dc1394_video_get_one_shot,libdc1394),Error,(Ptr{CameraInfo},Ptr{Bool}),camera.handle,is_on)
    is_on[1]==TRUE
end

function set_multi_shot(camera::Camera,numFrames::Int,pwr::Switch)
    ccall((:dc1394_video_set_multi_shot,libdc1394),Error,(Ptr{CameraInfo},UInt32,Switch),camera.handle,numFrames,pwr)
end

function get_multi_shot(camera::Camera)
    is_on=[Bool(OFF)]
    numFrames=[UInt32(0)]
    ccall((:dc1394_video_get_multi_shot,libdc1394),Error,(Ptr{CameraInfo},Ptr{Bool},Ptr{UInt32}),camera.handle,is_on,numFrames)
    is_on[1],Int(numFrames(1))
end

function get_bandwidth_usage(camera::Camera)
    bandwidth=[UInt32(0)]
    ccall((:dc1394_video_get_bandwidth_usage,libdc1394),Error,(Ptr{CameraInfo},Ptr{UInt32}),camera.handle,bandwidth)
    Int(bandwidth[1])
end