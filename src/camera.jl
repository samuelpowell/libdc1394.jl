export Camera,camera_enumerate,set_broadcast,is_broadcast,get_node,reset,set_power

immutable CameraId
    unit::UInt16
    guid::UInt64
end

immutable dc1394camera_list_t
    num::UInt32
    ids::Ptr{CameraId}
    dc1394camera_list_t()=new(0,C_NULL)
end

"""
Returns the list of cameras available on the computer
"""
function camera_enumerate()
    list=Array{Ptr{dc1394camera_list_t},1}(1)
    err=ccall((:dc1394_camera_enumerate,libdc1394),Error,(Ptr{dc1394_t},Ptr{Ptr{dc1394camera_list_t}}),dc1394,list)
    l=unsafe_load(list[1])
    ids=copy(pointer_to_array(l.ids,l.num));
    ccall((:dc1394_camera_free_list,libdc1394),Void,(Ptr{dc1394camera_list_t},),list[1])
    ids
end


"""
camera handle type
"""
immutable CameraInfo
    guid::UInt64
    unit::Cint
    unit_spec_ID::UInt32
    unit_sw_version::UInt32
    unit_sub_sw_version::UInt32
    command_registers_base::UInt32
    unit_directory::UInt32
    unit_dependent_directory::UInt32
    advanced_features_csr::UInt64
    PIO_control_csr::UInt64
    SIO_control_csr::UInt64
    strobe_control_csr::UInt64
    format7_csr::NTuple{8,UInt64}
    iidc_version::IidcVersion
    vendor::Cstring
    model::Cstring
    vendor_id::UInt32
    model_id::UInt32
    bmode_capable::Bool
    one_shot_capable::Bool
    multi_shot_capable::Bool
    can_switch_on_off::Bool
    has_vmode_error_status::Bool
    has_feature_error_status::Bool
    max_mem_channel::Cint
    flags::UInt32
end
function show(io::IO, c::CameraInfo)
    println(io,"CameraInfo:")
    for fname in fieldnames(c)
        println(io,"\t$(fname):\t$(getfield(c,fname))");
    end
end
type Camera
    handle::Ptr{CameraInfo}
end
convert(::Type{CameraInfo}, camera::Camera)=unsafe_load(camera.handle)
show(io::IO,c::Camera)=show(io,CameraInfo(c))
function Camera(guid::Integer)
    handle=ccall((:dc1394_camera_new,libdc1394),Ptr{CameraInfo},(Ptr{dc1394_t},UInt64),dc1394,UInt64(guid))
    camera=Camera(handle)
    finalizer(camera,camera_free)
    camera
end

function Camera(id::CameraId)
    handle=ccall((:dc1394_camera_new_unit,libdc1394),Ptr{CameraInfo},(Ptr{dc1394_t},UInt64,Cint),dc1394,id.guid,Cint(id.unit))
    camera=Camera(handle)
    finalizer(camera,camera_free);
    camera
end

function camera_free(camera::Camera)
    println("finalize camera");
    if camera.handle!=C_NULL
        ccall((:dc1394_camera_free,libdc1394),Void,(Ptr{CameraInfo},),camera.handle)
    end
    camera.handle=C_NULL
end

function is_same(id1::CameraId,id2::CameraId)
    val=ccall((:dc1394_is_same_camera,libdc1394),Bool,(CameraId,CameraId),id1,id2)
    val==TRUE
end



function set_broadcast(camera::Camera,pwr::Base.Bool)
    ccall((:dc1394_camera_set_broadcast,libdc1394),Error,(Ptr{CameraInfo},Bool),camera.handle,pwr?TRUE:FALSE)
end

function is_broadcast(camera::Camera)
    pwr=Array{Bool,1}(1)
    ccall((:dc1394_camera_get_broadcast,libdc1394),Error,(Ptr{CameraInfo},Ptr{Bool}),camera.handle,pwr)
    pwr[1]==TRUE
end

function get_node(camera::Camera)
    node=[UInt32(0)]
    generation=[UInt32(0)]
    ccall((:dc1394_camera_get_node,libdc1394),Error,(Ptr{CameraInfo},Ptr{UInt32},Ptr{UInt32}),camera.handle,node,generation)
    Int(node[1]),Int(generation[1])
end


function reset(camera::Camera)
    ccall((:dc1394_camera_reset,libdc1394),Error,(Ptr{CameraInfo},),camera.handle)
end

function set_power(camera::Camera,pwr::Switch)
    ccall((:dc1394_camera_set_power,libdc1394),Error,(Ptr{CameraInfo},Switch),camera.handel,pwr)
end
