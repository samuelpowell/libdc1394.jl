export Camera,camera_enumerate,set_broadcast,is_broadcast,get_node,reset,set_power

immutable dc1394camera_id_t
    unit::UInt16
    guid::UInt64
end

immutable dc1394camera_list_t
    num::UInt32
    ids::Ptr{dc1394camera_id_t}
    dc1394camera_list_t()=new(0,C_NULL)
end

"""
Returns the list of cameras available on the computer
"""
function camera_enumerate()
    list=Array{Ptr{dc1394camera_list_t},1}(1)
    err=ccall((:dc1394_camera_enumerate,libdc1394),dc1394error_t,(Ptr{dc1394_t},Ptr{Ptr{dc1394camera_list_t}}),dc1394,list)
    l=unsafe_load(list[1])
    ids=copy(unsafe_wrap(Array,l.ids,l.num));
    ccall((:dc1394_camera_free_list,libdc1394),Void,(Ptr{dc1394camera_list_t},),list[1])
    ids
end


"""
enum dc1394iidc_version_t
"""
@enum(dc1394iidc_version_t,
      IIDC_VERSION_1_04 = (UInt32)(544),
      IIDC_VERSION_1_20 = (UInt32)(545),
      IIDC_VERSION_PTGREY = (UInt32)(546),
      IIDC_VERSION_1_30 = (UInt32)(547),
      IIDC_VERSION_1_31 = (UInt32)(548),
      IIDC_VERSION_1_32 = (UInt32)(549),
      IIDC_VERSION_1_33 = (UInt32)(550),
      IIDC_VERSION_1_34 = (UInt32)(551),
IIDC_VERSION_1_35 = (UInt32)(552),
IIDC_VERSION_1_36 = (UInt32)(553),
IIDC_VERSION_1_37 = (UInt32)(554),
IIDC_VERSION_1_38 = (UInt32)(555),
IIDC_VERSION_1_39 = (UInt32)(556))

const IIDC_VERSION_MIN = IIDC_VERSION_1_04
const IIDC_VERSION_MAX = IIDC_VERSION_1_39
const IIDC_VERSION_NUM = (Int(IIDC_VERSION_MAX) - Int(IIDC_VERSION_MIN)) + 1

"""
camera handle type
"""
immutable dc1394camera_info_t
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
    iidc_version::dc1394iidc_version_t
    vendor::Cstring
    model::Cstring
    vendor_id::UInt32
    model_id::UInt32
    bmode_capable::dc1394bool_t
    one_shot_capable::dc1394bool_t
    multi_shot_capable::dc1394bool_t
    can_switch_on_off::dc1394bool_t
    has_vmode_error_status::dc1394bool_t
    has_feature_error_status::dc1394bool_t
    max_mem_channel::Cint
    flags::UInt32
end
function show(io::IO, c::dc1394camera_info_t)
    println(io,"dc1394camera_info_t:")
    for fname in fieldnames(c)
        println(io,"\t$(fname):\t$(getfield(c,fname))");
    end
end
type Camera
    handle::Ptr{dc1394camera_info_t}
end
convert(::Type{dc1394camera_info_t}, camera::Camera)=unsafe_load(camera.handle)
show(io::IO,c::Camera)=show(io,dc1394camera_info_t(c))
function Camera(guid::Integer)
    handle=ccall((:dc1394_camera_new,libdc1394),Ptr{dc1394camera_info_t},(Ptr{dc1394_t},UInt64),dc1394,UInt64(guid))
    camera=Camera(handle)
    finalizer(camera,camera_free)
    camera
end

function Camera(id::dc1394camera_id_t)
    handle=ccall((:dc1394_camera_new_unit,libdc1394),Ptr{dc1394camera_info_t},(Ptr{dc1394_t},UInt64,Cint),dc1394,id.guid,Cint(id.unit))
    camera=Camera(handle)
    finalizer(camera,camera_free);
    camera
end

function camera_free(camera::Camera)
    println("finalize camera");
    if camera.handle!=C_NULL
        ccall((:dc1394_camera_free,libdc1394),Void,(Ptr{dc1394camera_info_t},),camera.handle)
    end
    camera.handle=C_NULL
end

function is_same(id1::dc1394camera_id_t,id2::dc1394camera_id_t)
    val=ccall((:dc1394_is_same_camera,libdc1394),dc1394bool_t,(dc1394camera_id_t,dc1394camera_id_t),id1,id2)
    val==TRUE
end



function set_broadcast(camera::Camera,pwr::Bool)
    ccall((:dc1394_camera_set_broadcast,libdc1394),dc1394error_t,(Ptr{dc1394camera_info_t},dc1394bool_t),camera.handle,pwr?TRUE:FALSE)
end

function is_broadcast(camera::Camera)
    pwr=Array{dc1394bool_t,1}(1)
    ccall((:dc1394_camera_get_broadcast,libdc1394),dc1394error_t,(Ptr{dc1394camera_info_t},Ptr{dc1394bool_t}),camera.handle,pwr)
    pwr[1]==TRUE
end

function get_node(camera::Camera)
    node=[UInt32(0)]
    generation=[UInt32(0)]
    ccall((:dc1394_camera_get_node,libdc1394),dc1394error_t,(Ptr{dc1394camera_info_t},Ptr{UInt32},Ptr{UInt32}),camera.handle,node,generation)
    Int(node[1]),Int(generation[1])
end


function reset(camera::Camera)
    ccall((:dc1394_camera_reset,libdc1394),dc1394error_t,(Ptr{dc1394camera_info_t},),camera.handle)
end

function set_power(camera::Camera,pwr::dc1394switch_t)
    ccall((:dc1394_camera_set_power,libdc1394),dc1394error_t,(Ptr{dc1394camera_info_t},dc1394switch_t),camera.handel,pwr)
end
