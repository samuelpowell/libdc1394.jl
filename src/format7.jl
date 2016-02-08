export # for format7 mode
format7_get_max_image_size,
format7_get_image_size,format7_set_image_size,
format7_get_image_position,format7_set_image_position,
format7_set_roi,format7_get_roi,
format7_get_unit_size,
format7_get_unit_position,
format7_get_color_coding,format7_get_color_codings,format7_set_color_coding,
format7_get_color_filter,
format7_get_packet_parameters,
format7_get_packet_size,format7_set_packet_size,
format7_get_recommended_packet_size,
format7_get_packets_per_frame,
format7_get_data_depth,
format7_get_frame_interval,
format7_get_pixel_number,
format7_get_total_bytes,
format7_get_modeset,format7_get_mode_info



immutable Format7Mode
    present::Bool
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
    color_coding::ColorCoding
    pixnum::UInt32
    packet_size::UInt32
    unit_packet_size::UInt32
    max_packet_size::UInt32
    total_bytes::UInt64
    color_filter::ColorFilter
end
function show(io::IO, fm::Format7Mode)
    println("Format7Mode:")
    for fname in fieldnames(fm)
        print(io,"\t$(fname):\t");show(io,getfield(fm,fname));println("");
    end
end

immutable dc1394format7modeset_t
    mode::NTuple{8,Format7Mode}
end


function format7_get_max_image_size(camera::Camera,video_mode::VideoMode)
    width=[UInt32(0)]
    height=[UInt32(0)]
    ccall((:dc1394_format7_get_max_image_size,libdc1394),Error,(Ptr{CameraInfo},VideoMode,Ptr{UInt32},Ptr{UInt32}),camera.handle,video_mode,width,height)
    (Int(width[1]),Int(height[1]))
end

function format7_get_unit_size(camera::Camera,video_mode::VideoMode)
    h_unit=[UInt32(0)]
    v_unit=[UInt32(0)]
    ccall((:dc1394_format7_get_unit_size,libdc1394),Error,(Ptr{CameraInfo},VideoMode,Ptr{UInt32},Ptr{UInt32}),camera.handle,video_mode,h_unit,v_unit)
    (Int(h_unit[1]),Int(v_unit[1]))
end

function format7_get_image_size(camera::Camera,video_mode::VideoMode)
    width=[UInt32(0)]
    height=[UInt32(0)]
    ccall((:dc1394_format7_get_image_size,libdc1394),
          Error,(Ptr{CameraInfo},VideoMode,Ptr{UInt32},Ptr{UInt32}),
          camera.handle,video_mode,width,height)
    (Int(width[1]),Int(height[1]))
end

function format7_set_image_size(camera::Camera,video_mode::VideoMode,width::Int,height::Int)
    ccall((:dc1394_format7_set_image_size,libdc1394),Error,(Ptr{CameraInfo},VideoMode,UInt32,UInt32),camera.handle,video_mode,width,height)
end

function format7_get_image_position(camera::Camera,video_mode::VideoMode)
    top=[UInt32(0)]
    left=[UInt32(0)]
    ccall((:dc1394_format7_get_image_position,libdc1394),Error,(Ptr{CameraInfo},VideoMode,Ptr{UInt32},Ptr{UInt32}),camera.handle,video_mode,left,top)
    (Int(left[1]),Int(top[1]))
end

function format7_set_image_position(camera::Camera,video_mode::VideoMode,left::Int,top::Int)
    ccall((:dc1394_format7_set_image_position,libdc1394),Error,(Ptr{CameraInfo},VideoMode,UInt32,UInt32),camera.handle,video_mode,left,top)
end

function format7_get_unit_position(camera::Camera,video_mode::VideoMode)
    h_unit=[UInt32(0)]
    v_unit=[UInt32(0)]
    ccall((:dc1394_format7_get_unit_position,libdc1394),Error,(Ptr{CameraInfo},VideoMode,Ptr{UInt32},Ptr{UInt32}),camera.handle,video_mode,h_unit_pos,v_unit_pos)
    (Int(h_unit[1]),Int(v_unit[1]))
end

function format7_get_color_coding(camera::Camera,video_mode::VideoMode)
    color_coding=Array{ColorCoding,1}(1)
    ccall((:dc1394_format7_get_color_coding,libdc1394),Error,(Ptr{CameraInfo},VideoMode,Ptr{ColorCoding}),camera.handle,video_mode,color_coding)
    color_coding[1]
end

function format7_get_color_codings(camera::Camera,video_mode::VideoMode)
    codings=Array{dc1394color_codings_t,1}(1)
    ccall((:dc1394_format7_get_color_codings,libdc1394),Error,(Ptr{CameraInfo},VideoMode,Ptr{dc1394color_codings_t}),camera.handle,video_mode,codings)
    codings[1].codings[1:codings[1].num]
end

function format7_set_color_coding(camera::Camera,video_mode::VideoMode,color_coding::ColorCoding)
    ccall((:dc1394_format7_set_color_coding,libdc1394),Error,(Ptr{CameraInfo},VideoMode,ColorCoding),camera.handle,video_mode,color_coding)
end

function format7_get_color_filter(camera::Camera,video_mode::VideoMode)
    color_filter=Array{ColorFilter,1}(1)
    ccall((:dc1394_format7_get_color_filter,libdc1394),Error,(Ptr{CameraInfo},VideoMode,Ptr{ColorFilter}),camera.handle,video_mode,color_filter)
    color_filter[1]
end

function format7_get_packet_parameters(camera::Camera,video_mode::VideoMode)
    unit_bytes=[UInt32(0)]
    max_bytes=[UInt32(0)]
    ccall((:dc1394_format7_get_packet_parameters,libdc1394),Error,(Ptr{CameraInfo},VideoMode,Ptr{UInt32},Ptr{UInt32}),camera.handle,video_mode,unit_bytes,max_bytes)
    (Int(unit_bytes[1]),Int(max_bytes[1]))
end

function format7_get_packet_size(camera::Camera,video_mode::VideoMode)
    packet_size=[UInt32(0)]
    ccall((:dc1394_format7_get_packet_size,libdc1394),Error,(Ptr{CameraInfo},VideoMode,Ptr{UInt32}),camera.handle,video_mode,packet_size)
    Int(packet_size[1])
end

function format7_set_packet_size(camera::Camera,video_mode::VideoMode,packet_size::Int)
    ccall((:dc1394_format7_set_packet_size,libdc1394),Error,(Ptr{CameraInfo},VideoMode,UInt32),camera.handle,video_mode,packet_size)
end

function format7_get_recommended_packet_size(camera::Camera,video_mode::VideoMode)
    packet_size=[UInt32(0)]
    ccall((:dc1394_format7_get_recommended_packet_size,libdc1394),Error,(Ptr{CameraInfo},VideoMode,Ptr{UInt32}),camera.handle,video_mode,packet_size)
    Int(packet_size[1])
end

function format7_get_packets_per_frame(camera::Camera,video_mode::VideoMode)
    ppf=[UInt32(0)]
    ccall((:dc1394_format7_get_packets_per_frame,libdc1394),Error,(Ptr{CameraInfo},VideoMode,Ptr{UInt32}),camera.handle,video_mode,ppf)
    Int(ppf[1])
end

function format7_get_data_depth(camera::Camera,video_mode::VideoMode)
    data_depth=[UInt32(0)]
    ccall((:dc1394_format7_get_data_depth,libdc1394),Error,(Ptr{CameraInfo},VideoMode,Ptr{UInt32}),camera.handle,video_mode,data_depth)
    Int(data_depth[1])
end

function format7_get_frame_interval(camera::Camera,video_mode::VideoMode)
    interval=[Cfloat(0.0)]
    ccall((:dc1394_format7_get_frame_interval,libdc1394),Error,(Ptr{CameraInfo},VideoMode,Ptr{Cfloat}),camera.handle,video_mode,interval)
    interval[1]
end

function format7_get_pixel_number(camera::Camera,video_mode::VideoMode)
    pixnum=[UInt32(0)]
    ccall((:dc1394_format7_get_pixel_number,libdc1394),Error,(Ptr{CameraInfo},VideoMode,Ptr{UInt32}),camera.handle,video_mode,pixnum)
    Int(pixnum[1])
end

function format7_get_total_bytes(camera::Camera,video_mode::VideoMode)
    total_bytes=[UInt64(0)]
    ccall((:dc1394_format7_get_total_bytes,libdc1394),Error,(Ptr{CameraInfo},VideoMode,Ptr{UInt64}),camera.handle,video_mode,total_bytes)
    total_bytes[1]
end

function format7_get_modeset(camera::Camera,info::Ptr{dc1394format7modeset_t})
    info=Array{dc1394format7modeset_t,1}(1)
    ccall((:dc1394_format7_get_modeset,libdc1394),Error,(Ptr{CameraInfo},Ptr{dc1394format7modeset_t}),camera.handle,info)
    info[1].mode
end

function format7_get_mode_info(camera::Camera,video_mode::VideoMode)
    f7_mode=Array{Format7Mode,1}(1)
    ccall((:dc1394_format7_get_mode_info,libdc1394),Error,(Ptr{CameraInfo},VideoMode,Ptr{Format7Mode}),camera.handle,video_mode,f7_mode)
    f7_mode[1]
end

function format7_set_roi(camera::Camera,video_mode::VideoMode,color_coding::ColorCoding,packet_size::Int32,left::Int32,top::Int32,width::Int32,height::Int32)
    ccall((:dc1394_format7_set_roi,libdc1394),Error,(Ptr{CameraInfo},VideoMode,ColorCoding,Int32,Int32,Int32,Int32,Int32),camera.handle,video_mode,color_coding,packet_size,left,top,width,height)
end

function format7_get_roi(camera::Camera,video_mode::VideoMode)
    color_coding=Array{ColorCoding,1}(1)
    packet_size=[UInt32(0)]
    left=[UInt32(0)]
    top=[UInt32(0)]
    width=[UInt32(0)]
    height=[UInt32(0)]
    ccall((:dc1394_format7_get_roi,libdc1394),Error,(Ptr{CameraInfo},VideoMode,Ptr{ColorCoding},Ptr{UInt32},Ptr{UInt32},Ptr{UInt32},Ptr{UInt32},Ptr{UInt32}),camera.handle,video_mode,color_coding,packet_size,left,top,width,height)
    (color_coding[1],Int(packet_size[1]),Int(left[1]),Int(top[1]),Int(width[1]),Int(height[1]))
end

