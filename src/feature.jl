export
#get and set Feature generic way
get_value,set_value,is_present,is_readable,get_boundaries,is_switchable,get_power,set_power,get_modes,get_mode,set_mode,has_absolute_control,get_absolute_boundaries,get_absolute_value,set_absolute_value,get_absolute_control,set_absolute_control,
#get and set a special camera features
get_whitebalance,set_whitebalance,get_whitebalance_modes,get_whitebalance_mode,set_whitebalance_mode,
get_temperature,
set_temperature,
get_temperature_modes,
get_temperature_mode,
set_temperature_mode,
get_whiteshading,
set_whiteshading,
get_whiteshading_modes,
get_whiteshading_mode,
set_whiteshading_mode,
get_brightness,
set_brightness,
get_brightness_modes,
get_brightness_mode,
set_brightness_mode,
get_exposure,
set_exposure,
get_exposure_modes,
get_exposure_mode,
set_exposure_mode,
get_sharpness,
set_sharpness,
get_sharpness_modes,
get_sharpness_mode,
set_sharpness_mode,
get_hue,
set_hue,
get_hue_modes,
get_hue_mode,
set_hue_mode,
get_saturation,
set_saturation,
get_saturation_modes,
get_saturation_mode,
set_saturation_mode,
get_gamma,
set_gamma,
get_gamma_modes,
get_gamma_mode,
set_gamma_mode,
get_shutter,
set_shutter,
get_shutter_modes,
get_shutter_mode,
set_shutter_mode,
get_gain,
set_gain,
get_gain_modes,
get_gain_mode,
set_gain_mode,
get_iris,
set_iris,
get_iris_modes,
get_iris_mode,
set_iris_mode,
get_focus,
set_focus,
get_focus_modes,
get_focus_mode,
set_focus_mode,
get_trigger,
set_trigger,
get_trigger_modes,
get_trigger_mode,
set_trigger_mode,
get_trigger_delay,
set_trigger_delay,
get_trigger_delay_modes,
get_trigger_delay_mode,
set_trigger_delay_mode,
get_zoom,
set_zoom,
get_zoom_modes,
get_zoom_mode,
set_zoom_mode,
get_pan,
set_pan,
get_pan_modes,
get_pan_mode,
set_pan_mode,
get_tilt,
set_tilt,
get_tilt_modes,
get_tilt_mode,
set_tilt_mode,
get_optical_filter,
set_optical_filter,
get_optical_filter_modes,
get_optical_filter_mode,
set_optical_filter_mode,
get_capture_size,
set_capture_size,
get_capture_size_modes,
get_capture_size_mode,
set_capture_size_mode,
get_capture_quality,
set_capture_quality,
get_capture_quality_modes,
get_capture_quality_mode,
set_capture_quality_mode

# begin enum dc1394feature_mode_t
@enum(dc1394feature_mode_t,
      FEATURE_MODE_MANUAL = (UInt32)(736),
      FEATURE_MODE_AUTO = (UInt32)(737),
      FEATURE_MODE_ONE_PUSH_AUTO = (UInt32)(738))
# end enum dc1394feature_mode_t

FEATURE_MODE_MIN = FEATURE_MODE_MANUAL
FEATURE_MODE_MAX = FEATURE_MODE_ONE_PUSH_AUTO
FEATURE_MODE_NUM = (Int(FEATURE_MODE_MAX) - Int(FEATURE_MODE_MIN)) + 1

immutable dc1394feature_modes_t
    num::UInt32
    modes::NTuple{3,dc1394feature_mode_t}
    dc1394feature_modes_t()=new(0,ntuple(i->FEATURE_MODE_MIN,3))
end
show(io::IO,fm::dc1394feature_modes_t)=0<fm.num<3? show(io,fm.modes[1:fm.num]):()
convert(::Type{NTuple},modes::dc1394feature_modes_t)=modes.modes[1:modes.num]
"""
enum dc1394feature_t
"""
@enum(dc1394feature_t,
      FEATURE_BRIGHTNESS = (UInt32)(416),
      FEATURE_EXPOSURE = (UInt32)(417),
      FEATURE_SHARPNESS = (UInt32)(418),
      FEATURE_WHITE_BALANCE = (UInt32)(419),
      FEATURE_HUE = (UInt32)(420),
      FEATURE_SATURATION = (UInt32)(421),
      FEATURE_GAMMA = (UInt32)(422),
      FEATURE_SHUTTER = (UInt32)(423),
      FEATURE_GAIN = (UInt32)(424),
      FEATURE_IRIS = (UInt32)(425),
FEATURE_FOCUS = (UInt32)(426),
FEATURE_TEMPERATURE = (UInt32)(427),
FEATURE_TRIGGER = (UInt32)(428),
FEATURE_TRIGGER_DELAY = (UInt32)(429),
FEATURE_WHITE_SHADING = (UInt32)(430),
FEATURE_FRAME_RATE = (UInt32)(431),
FEATURE_ZOOM = (UInt32)(432),
FEATURE_PAN = (UInt32)(433),
FEATURE_TILT = (UInt32)(434),
FEATURE_OPTICAL_FILTER = (UInt32)(435),
FEATURE_CAPTURE_SIZE = (UInt32)(436),
FEATURE_CAPTURE_QUALITY = (UInt32)(437))

const FEATURE_MIN = FEATURE_BRIGHTNESS
const FEATURE_MAX = FEATURE_CAPTURE_QUALITY
const FEATURE_NUM = (Int(FEATURE_MAX) - Int(FEATURE_MIN)) + 1
function string(feature::dc1394feature_t)
    ptr=ccall((:dc1394_feature_get_string,libdc1394),
              Cstring,(dc1394feature_t,),feature)
    bytestring(ptr)
end
show(io::IO,feature::dc1394feature_t)=show(io,string(feature))
convert(::Type{AbstractString},feature::dc1394feature_t)=string(feature)

immutable dc1394feature_info_t
    id::dc1394feature_t
    available::dc1394bool_t
    absolute_capable::dc1394bool_t
    readout_capable::dc1394bool_t
    on_off_capable::dc1394bool_t
    polarity_capable::dc1394bool_t
    is_on::dc1394switch_t
    current_mode::dc1394feature_mode_t
    modes::dc1394feature_modes_t
    trigger_modes::dc1394trigger_modes_t
    trigger_mode::dc1394trigger_mode_t
    trigger_polarity::dc1394trigger_polarity_t
    trigger_sources::dc1394trigger_sources_t
    trigger_source::dc1394trigger_source_t
    min::UInt32
    max::UInt32
    value::UInt32
    BU_value::UInt32
    RV_value::UInt32
    B_value::UInt32
    R_value::UInt32
    G_value::UInt32
    target_value::UInt32
    abs_control::dc1394switch_t
    abs_value::Cfloat
    abs_max::Cfloat
    abs_min::Cfloat

    dc1394feature_info_t(id::dc1394feature_t)=new(id,
                             FALSE,#available::dc1394bool_t
                             FALSE,#absolute_capable::dc1394bool_t
                             FALSE,#readout_capable::dc1394bool_t
                             FALSE,#on_off_capable::dc1394bool_t
                             FALSE,#polarity_capable::dc1394bool_t
                             OFF,#is_on::dc1394switch_t
                             FEATURE_MODE_MANUAL,#current_mode::dc1394feature_mode_t
    dc1394feature_modes_t(),#modes::dc1394feature_modes_t
    dc1394trigger_modes_t(),#trigger_modes::dc1394trigger_modes_t
    TRIGGER_MODE_0,#trigger_mode::dc1394trigger_mode_t
    TRIGGER_ACTIVE_LOW,#trigger_polarity::dc1394trigger_polarity_t
    dc1394trigger_sources_t(),#trigger_sources::dc1394trigger_sources_t
    TRIGGER_SOURCE_0,#trigger_source::dc1394trigger_source_t
    0,#min::UInt32
    0,#max::UInt32
    0,#value::UInt32
    0,#BU_value::UInt32
    0,#RV_value::UInt32
    0,#B_value::UInt32
    0,#R_value::UInt32
    0,#G_value::UInt32
    0,#target_value::UInt32
    OFF,#abs_control::dc1394switch_t
    0,#abs_value::Cfloat
    0,#abs_max::Cfloat
    0#abs_min::Cfloat
    )
end
function show(io::IO, c::dc1394feature_info_t)
    println("dc1394feature_info_t:")
    for fname in fieldnames(c)
        print(io,"\t$(fname):\t");show(io,getfield(c,fname));println("");
    end
end

function get_features(camera::Camera)
    features=Array{dc1394feature_info_t,1}(22)
    ccall((:dc1394_feature_get_all,libdc1394),dc1394error_t,(Ptr{dc1394camera_info_t},Ptr{dc1394feature_info_t}),camera.handle,features)
    features
end

function get_feature(camera::Camera,id::dc1394feature_t)
    feature=[dc1394feature_info_t(id)]
    ccall((:dc1394_feature_get,libdc1394),dc1394error_t,(Ptr{dc1394camera_info_t},Ptr{dc1394feature_info_t}),camera.handle,feature)
    feature[1]
end

function get_value(camera::Camera,feature::dc1394feature_t)
    value=[UInt32(0)]
    err=ccall((:dc1394_feature_get_value,libdc1394),dc1394error_t,(Ptr{dc1394camera_info_t},dc1394feature_t,Ptr{UInt32}),camera.handle,feature,value)
    if err === SUCCESS
        return Int(value[1])
    else
        return err
    end
end

function set_value(camera::Camera,feature::dc1394feature_t,value::Int)
    ccall((:dc1394_feature_set_value,libdc1394),dc1394error_t,(Ptr{dc1394camera_info_t},dc1394feature_t,UInt32),camera.handle,feature,value)
end

function is_present(camera::Camera,feature::dc1394feature_t)
    value=[dc1394bool_t(FALSE)]
    Ccall((:dc1394_feature_is_present,libdc1394),dc1394error_t,(Ptr{dc1394camera_info_t},dc1394feature_t,Ptr{dc1394bool_t}),camera.handle,feature,value)
    value[1]==TRUE
end

function is_readable(camera::Camera,feature::dc1394feature_t)
    value=[dc1394bool_t(FALSE)]
    ccall((:dc1394_feature_is_readable,libdc1394),dc1394error_t,(Ptr{dc1394camera_info_t},dc1394feature_t,Ptr{dc1394bool_t}),camera.handle,feature,value)
    value[1]==TRUE
end

function get_boundaries(camera::Camera,feature::dc1394feature_t)
    min=[UInt32(0)]
    max=[UInt32(0)]
    ccall((:dc1394_feature_get_boundaries,libdc1394),dc1394error_t,(Ptr{dc1394camera_info_t},dc1394feature_t,Ptr{UInt32},Ptr{UInt32}),camera.handle,feature,min,max)
    (Int(min[1]),Int(max[1]))
end

function is_switchable(camera::Camera,feature::dc1394feature_t)
    value=[dc1394bool_t(FALSE)]
    ccall((:dc1394_feature_is_switchable,libdc1394),dc1394error_t,(Ptr{dc1394camera_info_t},dc1394feature_t,Ptr{dc1394bool_t}),camera.handel,feature,value)
    value[1]==TRUE
end

function get_power(camera::Camera,feature::dc1394feature_t)
    pwr=[dc1394switch_t(OFF)]
    ccall((:dc1394_feature_get_power,libdc1394),dc1394error_t,(Ptr{dc1394camera_info_t},dc1394feature_t,Ptr{dc1394switch_t}),camera.handle,feature,pwr)
    pwr[1]
end

function set_power(camera::Camera,feature::dc1394feature_t,pwr::dc1394switch_t)
    ccall((:dc1394_feature_set_power,libdc1394),dc1394error_t,(Ptr{dc1394camera_info_t},dc1394feature_t,dc1394switch_t),camera.handle,feature,pwr)
end

function get_modes(camera::Camera,feature::dc1394feature_t)
    modes=Array{dc1394feature_modes_t,1}(1)
    ccall((:dc1394_feature_get_modes,libdc1394),dc1394error_t,(Ptr{dc1394camera_info_t},dc1394feature_t,Ptr{dc1394feature_modes_t}),camera.handle,feature,modes)
    modes[1].modes[1:modes[1].num]
end

function get_mode(camera::Camera,feature::dc1394feature_t)
    mode=[FEATURE_MODE_MIN]
    ccall((:dc1394_feature_get_mode,libdc1394),dc1394error_t,(Ptr{dc1394camera_info_t},dc1394feature_t,Ptr{dc1394feature_mode_t}),camera.handle,feature,mode)
    mode[1]
end

function set_mode(camera::Camera,feature::dc1394feature_t,mode::dc1394feature_mode_t)
    ccall((:dc1394_feature_set_mode,libdc1394),dc1394error_t,(Ptr{dc1394camera_info_t},dc1394feature_t,dc1394feature_mode_t),camera.handle,feature,mode)
end

function has_absolute_control(camera::Camera,feature::dc1394feature_t)
    value=[dc1394bool_t(FALSE)]
    ccall((:dc1394_feature_has_absolute_control,libdc1394),dc1394error_t,(Ptr{dc1394camera_info_t},dc1394feature_t,Ptr{dc1394bool_t}),camera.handle,feature,value)
    value[1]==TRUE
end

function get_absolute_boundaries(camera::Camera,feature::dc1394feature_t)
    min=[Cfloat(0)]
    max=[Cfloat(0)]
    ccall((:dc1394_feature_get_absolute_boundaries,libdc1394),dc1394error_t,(Ptr{dc1394camera_info_t},dc1394feature_t,Ptr{Cfloat},Ptr{Cfloat}),camera.handle,feature,min,max)
    min[1],max[1]
end

function get_absolute_value(camera::Camera,feature::dc1394feature_t)
    value=[Cfloat(0)]
    ccall((:dc1394_feature_get_absolute_value,libdc1394),dc1394error_t,(Ptr{dc1394camera_info_t},dc1394feature_t,Ptr{Cfloat}),camera.handle,feature,value)
    value[1]
end

function set_absolute_value(camera::Camera,
                            feature::dc1394feature_t,
                            value::Real)
    ccall((:dc1394_feature_set_absolute_value,libdc1394),dc1394error_t,(Ptr{dc1394camera_info_t},dc1394feature_t,Cfloat),camera.handle,feature,Cfloat(value))
end

function get_absolute_control(camera::Camera,feature::dc1394feature_t)
    pwr=[dc1394switch_t(ON)]
    ccall((:dc1394_feature_get_absolute_control,libdc1394),dc1394error_t,(Ptr{dc1394camera_info_t},dc1394feature_t,Ptr{dc1394switch_t}),camera.handle,feature,pwr)
    pwr[1]
end

function set_absolute_control(camera::Camera,feature::dc1394feature_t,pwr::dc1394switch_t)
    ccall((:dc1394_feature_set_absolute_control,libdc1394),dc1394error_t,(Ptr{dc1394camera_info_t},dc1394feature_t,dc1394switch_t),camera.handle,feature,pwr)
end



function get_whitebalance(camera::Camera)
    u_b_value=[UInt32(0)]
    v_r_value=[UInt32(0)]
    ccall((:dc1394_feature_whitebalance_get_value,libdc1394),dc1394error_t,(Ptr{dc1394camera_info_t},Ptr{UInt32},Ptr{UInt32}),camera.handle,u_b_value,v_r_value)
    (Int(u_b_value[1]),Int(v_r_value[1]))
end

function set_whitebalance(camera::Camera,u_b_value::Integer,v_r_value::Integer)
    ccall((:dc1394_feature_whitebalance_set_value,libdc1394),dc1394error_t,(Ptr{dc1394camera_info_t},UInt32,UInt32),camera.handle,u_b_value,v_r_value)
end

function get_temperature(camera::Camera)
    target_temperature=[UInt32(0)]
    temperature=[UInt32(0)]
    ccall((:dc1394_feature_temperature_get_value,libdc1394),dc1394error_t,(Ptr{dc1394camera_info_t},Ptr{UInt32},Ptr{UInt32}),camera.handle,target_temperature,temperature)
    (Int(target_temperature[1]),Int(temperature[1]))
end

function set_temperature(camera::Camera,target_temperature::Int)
    ccall((:dc1394_feature_temperature_set_value,libdc1394),dc1394error_t,(Ptr{dc1394camera_info_t},UInt32),camera.handle,target_temperature)
end

function get_whiteshading(camera::Camera)
    r_value=[UInt32(0)]
    g_value=[UInt32(0)]
    b_value=[UInt32(0)]
    ccall((:dc1394_feature_whiteshading_get_value,libdc1394),dc1394error_t,(Ptr{dc1394camera_info_t},Ptr{UInt32},Ptr{UInt32},Ptr{UInt32}),camera.handle,r_value,g_value,b_value)
    (Int(r_value[1]),Int(g_value[1]),Int(b_value[1]))
end

function set_whiteshading(camera::Camera,r_value::Integer,g_value::Integer,b_value::Integer)
    ccall((:dc1394_feature_whiteshading_set_value,libdc1394),dc1394error_t,(Ptr{dc1394camera_info_t},UInt32,UInt32,UInt32),camera.handle,r_value,g_value,b_value)
end

get_whitebalance_modes(camera::Camera)=get_modes(camera,FEATURE_WHITE_BALANCE)
get_whitebalance_mode(camera::Camera)=get_mode(camera,FEATURE_WHITE_BALANCE)
set_whitebalance_mode(camera::Camera,mode::dc1394feature_mode_t)=set_mode(camera,FEATURE_WHITE_BALANCE,mode)

get_temperature_modes(camera::Camera)=get_modes(camera,FEATURE_TEMPERATURE)
get_temperature_mode(camera::Camera)=get_mode(camera,FEATURE_TEMPERATURE)
set_temperature_mode(camera::Camera,mode::dc1394feature_mode_t)=set_mode(camera,FEATURE_TEMPERATURE,mode)
switch_absolute_temparature(camera::Camera,switch::dc1394switch_t)=set_absolute_control(camera,FEATURE_TEMPARATURE,switch)
is_absolute_temparature(camera::Camera)=get_absolute_control(camera,FEATURE_TEMPARATURE)
has_absolute_temparature(camera::Camera)=has_absolute_control(camera,FEATURE_TEMPARATURE)
get_absolute_temparature(camera::Camera)=get_absolute_value(camera,FEATURE_TEMPARATURE)
set_absolute_temparature(camera::Camera,value::Real)=set_absolute_value(camera,FEATURE_TEMPARATURE,value)

get_whiteshading_modes(camera::Camera)=get_modes(camera,FEATURE_WHITE_SHADING)
get_whiteshading_mode(camera::Camera)=get_mode(camera,FEATURE_WHITE_SHADING)
set_whiteshading_mode(camera::Camera,mode::dc1394feature_mode_t)=set_mode(camera,FEATURE_WHITE_SHADING,mode)

get_brightness(camera::Camera)=get_value(camera,FEATURE_BRIGHTNESS)
set_brightness(camera::Camera,value::Integer)=set_value(camera,FEATURE_BRIGHTNESS,value)
get_brightness_modes(camera::Camera)=get_modes(camera,FEATURE_BRIGHTNESS)
get_brightness_mode(camera::Camera)=get_mode(camera,FEATURE_BRIGHTNESS)
set_brightness_mode(camera::Camera,mode::dc1394feature_mode_t)=set_mode(camera,FEATURE_BRIGHTNESS,mode)
switch_absolute_brightness(camera::Camera,switch::dc1394switch_t)=set_absolute_control(camera,FEATURE_BRIGHTNESS,switch)
is_absolute_brightness(camera::Camera)=get_absolute_control(camera,FEATURE_BRIGHTNESS)
has_absolute_brightness(camera::Camera)=has_absolute_control(camera,FEATURE_BRIGHTNESS)
get_absolute_brightness(camera::Camera)=get_absolute_value(camera,FEATURE_BRIGHTNESS)
set_absolute_brightness(camera::Camera,value::Real)=set_absolute_value(camera,FEATURE_BRIGHTNESS,value)

get_exposure(camera::Camera)=get_value(camera,FEATURE_EXPOSURE)
set_exposure(camera::Camera,value::Integer)=set_value(camera,FEATURE_EXPOSURE,value)
get_exposure_modes(camera::Camera)=get_modes(camera,FEATURE_EXPOSURE)
get_exposure_mode(camera::Camera)=get_mode(camera,FEATURE_EXPOSURE)
set_exposure_mode(camera::Camera,mode::dc1394feature_mode_t)=set_mode(camera,FEATURE_EXPOSURE,mode)
switch_absolute_exposure(camera::Camera,switch::dc1394switch_t)=set_absolute_control(camera,FEATURE_EXPOSURE,switch)
is_absolute_exposure(camera::Camera)=get_absolute_control(camera,FEATURE_EXPOSURE)
has_absolute_exposure(camera::Camera)=has_absolute_control(camera,FEATURE_EXPOSURE)
get_absolute_exposure(camera::Camera)=get_absolute_value(camera,FEATURE_EXPOSURE)
set_absolute_exposure(camera::Camera,value::Real)=set_absolute_value(camera,FEATURE_EXPOSURE,value)


get_sharpness(camera::Camera)=get_value(camera,FEATURE_SHARPNESS)
set_sharpness(camera::Camera,value::Integer)=set_value(camera,FEATURE_SHARPNESS,value)
get_sharpness_modes(camera::Camera)=get_modes(camera,FEATURE_SHARPNESS)
get_sharpness_mode(camera::Camera)=get_mode(camera,FEATURE_SHARPNESS)
set_sharpness_mode(camera::Camera,mode::dc1394feature_mode_t)=set_mode(camera,FEATURE_SHARPNESS,mode)
switch_absolute_sharpness(camera::Camera,switch::dc1394switch_t)=set_absolute_control(camera,FEATURE_SHARPNESS,switch)
is_absolute_sharpness(camera::Camera)=get_absolute_control(camera,FEATURE_SHARPNESS)
has_absolute_sharpness(camera::Camera)=has_absolute_control(camera,FEATURE_SHARPNESS)
get_absolute_sharpness(camera::Camera)=get_absolute_value(camera,FEATURE_SHARPNESS)
set_absolute_sharpness(camera::Camera,value::Real)=set_absolute_value(camera,FEATURE_SHARPNESS,value)

get_hue(camera::Camera)=get_value(camera,FEATURE_HUE)
set_hue(camera::Camera,value::Integer)=set_value(camera,FEATURE_HUE,value)
get_hue_modes(camera::Camera)=get_modes(camera,FEATURE_HUE)
get_hue_mode(camera::Camera)=get_mode(camera,FEATURE_HUE)
set_hue_mode(camera::Camera,mode::dc1394feature_mode_t)=set_mode(camera,FEATURE_HUE,mode)
switch_absolute_hue(camera::Camera,switch::dc1394switch_t)=set_absolute_control(camera,FEATURE_HUE,switch)
is_absolute_hue(camera::Camera)=get_absolute_control(camera,FEATURE_HUE)
has_absolute_hue(camera::Camera)=has_absolute_control(camera,FEATURE_HUE)
get_absolute_hue(camera::Camera)=get_absolute_value(camera,FEATURE_HUE)
set_absolute_hue(camera::Camera,value::Real)=set_absolute_value(camera,FEATURE_HUE,value)

get_saturation(camera::Camera)=get_value(camera,FEATURE_SATURATION)
set_saturation(camera::Camera,value::Integer)=set_value(camera,FEATURE_SATURATION,value)
get_saturation_modes(camera::Camera)=get_modes(camera,FEATURE_SATURATION)
get_saturation_mode(camera::Camera)=get_mode(camera,FEATURE_SATURATION)
set_saturation_mode(camera::Camera,mode::dc1394feature_mode_t)=set_mode(camera,FEATURE_SATURATION,mode)
switch_absolute_saturation(camera::Camera,switch::dc1394switch_t)=set_absolute_control(camera,FEATURE_SATURATION,switch)
is_absolute_saturation(camera::Camera)=get_absolute_control(camera,FEATURE_SATURATION)
has_absolute_saturation(camera::Camera)=has_absolute_control(camera,FEATURE_SATURATION)
get_absolute_saturation(camera::Camera)=get_absolute_value(camera,FEATURE_SATURATION)
set_absolute_saturation(camera::Camera,value::Real)=set_absolute_value(camera,FEATURE_SATURATION,value)

get_gamma(camera::Camera)=get_value(camera,FEATURE_GAMMA)
set_gamma(camera::Camera,value::Integer)=set_value(camera,FEATURE_GAMMA,value)
get_gamma_modes(camera::Camera)=get_modes(camera,FEATURE_GAMMA)
get_gamma_mode(camera::Camera)=get_mode(camera,FEATURE_GAMMA)
set_gamma_mode(camera::Camera,mode::dc1394feature_mode_t)=set_mode(camera,FEATURE_GAMMA,mode)
switch_absolute_gamma(camera::Camera,switch::dc1394switch_t)=set_absolute_control(camera,FEATURE_GAMMA,switch)
is_absolute_gamma(camera::Camera)=get_absolute_control(camera,FEATURE_GAMMA)
has_absolute_gamma(camera::Camera)=has_absolute_control(camera,FEATURE_GAMMA)
get_absolute_gamma(camera::Camera)=get_absolute_value(camera,FEATURE_GAMMA)
set_absolute_gamma(camera::Camera,value::Real)=set_absolute_value(camera,FEATURE_GAMMA,value)

get_shutter(camera::Camera)=get_value(camera,FEATURE_SHUTTER)
set_shutter(camera::Camera,value::Integer)=set_value(camera,FEATURE_SHUTTER,value)
get_shutter_modes(camera::Camera)=get_modes(camera,FEATURE_SHUTTER)
get_shutter_mode(camera::Camera)=get_mode(camera,FEATURE_SHUTTER)
set_shutter_mode(camera::Camera,mode::dc1394feature_mode_t)=set_mode(camera,FEATURE_SHUTTER,mode)
switch_absolute_shutter(camera::Camera,switch::dc1394switch_t)=set_absolute_control(camera,FEATURE_SHUTTER,switch)
is_absolute_shutter(camera::Camera)=get_absolute_control(camera,FEATURE_SHUTTER)
has_absolute_shutter(camera::Camera)=has_absolute_control(camera,FEATURE_SHUTTER)
get_absolute_shutter(camera::Camera)=get_absolute_value(camera,FEATURE_SHUTTER)
set_absolute_shutter(camera::Camera,value::Real)=set_absolute_value(camera,FEATURE_SHUTTER,value)

get_gain(camera::Camera)=get_value(camera,FEATURE_GAIN)
set_gain(camera::Camera,value::Integer)=set_value(camera,FEATURE_GAIN,value)
get_gain_modes(camera::Camera)=get_modes(camera,FEATURE_GAIN)
get_gain_mode(camera::Camera)=get_mode(camera,FEATURE_GAIN)
set_gain_mode(camera::Camera,mode::dc1394feature_mode_t)=set_mode(camera,FEATURE_GAIN,mode)
switch_absolute_gain(camera::Camera,switch::dc1394switch_t)=set_absolute_control(camera,FEATURE_GAIN,switch)
is_absolute_gain(camera::Camera)=get_absolute_control(camera,FEATURE_GAIN)
has_absolute_gain(camera::Camera)=has_absolute_control(camera,FEATURE_GAIN)
get_absolute_gain(camera::Camera)=get_absolute_value(camera,FEATURE_GAIN)
set_absolute_gain(camera::Camera,value::Real)=set_absolute_value(camera,FEATURE_GAIN,value)

get_iris(camera::Camera)=get_value(camera,FEATURE_IRIS)
set_iris(camera::Camera,value::Integer)=set_value(camera,FEATURE_IRIS,value)
get_iris_modes(camera::Camera)=get_modes(camera,FEATURE_IRIS)
get_iris_mode(camera::Camera)=get_mode(camera,FEATURE_IRIS)
set_iris_mode(camera::Camera,mode::dc1394feature_mode_t)=set_mode(camera,FEATURE_IRIS,mode)
switch_absolute_iris(camera::Camera,switch::dc1394switch_t)=set_absolute_control(camera,FEATURE_IRIS,switch)
is_absolute_iris(camera::Camera)=get_absolute_control(camera,FEATURE_IRIS)
has_absolute_iris(camera::Camera)=has_absolute_control(camera,FEATURE_IRIS)
get_absolute_iris(camera::Camera)=get_absolute_value(camera,FEATURE_IRIS)
set_absolute_iris(camera::Camera,value::Real)=set_absolute_value(camera,FEATURE_IRIS,value)

get_focus(camera::Camera)=get_value(camera,FEATURE_FOCUS)
set_focus(camera::Camera,value::Integer)=set_value(camera,FEATURE_FOCUS,value)
get_focus_modes(camera::Camera)=get_modes(camera,FEATURE_FOCUS)
get_focus_mode(camera::Camera)=get_mode(camera,FEATURE_FOCUS)
set_focus_mode(camera::Camera,mode::dc1394feature_mode_t)=set_mode(camera,FEATURE_FOCUS,mode)
switch_absolute_focus(camera::Camera,switch::dc1394switch_t)=set_absolute_control(camera,FEATURE_FOCUS,switch)
is_absolute_focus(camera::Camera)=get_absolute_control(camera,FEATURE_FOCUS)
has_absolute_focus(camera::Camera)=has_absolute_control(camera,FEATURE_FOCUS)
get_absolute_focus(camera::Camera)=get_absolute_value(camera,FEATURE_FOCUS)
set_absolute_focus(camera::Camera,value::Real)=set_absolute_value(camera,FEATURE_FOCUS,value)

get_trigger(camera::Camera)=get_value(camera,FEATURE_TRIGGER)
set_trigger(camera::Camera,value::Integer)=set_value(camera,FEATURE_TRIGGER,value)
get_trigger_modes(camera::Camera)=get_modes(camera,FEATURE_TRIGGER)
get_trigger_mode(camera::Camera)=get_mode(camera,FEATURE_TRIGGER)
set_trigger_mode(camera::Camera,mode::dc1394feature_mode_t)=set_mode(camera,FEATURE_TRIGGER,mode)
switch_absolute_trigger(camera::Camera,switch::dc1394switch_t)=set_absolute_control(camera,FEATURE_TRIGGER,switch)
is_absolute_trigger(camera::Camera)=get_absolute_control(camera,FEATURE_TRIGGER)
has_absolute_trigger(camera::Camera)=has_absolute_control(camera,FEATURE_TRIGGER)
get_absolute_trigger(camera::Camera)=get_absolute_value(camera,FEATURE_TRIGGER)
set_absolute_trigger(camera::Camera,value::Real)=set_absolute_value(camera,FEATURE_TRIGGER,value)

get_trigger_delay(camera::Camera)=get_value(camera,FEATURE_TRIGGER_DELAY)
set_trigger_delay(camera::Camera,value::Integer)=set_value(camera,FEATURE_TRIGGER_DELAY,value)
get_trigger_delay_modes(camera::Camera)=get_modes(camera,FEATURE_TRIGGER_DELAY)
get_trigger_delay_mode(camera::Camera)=get_mode(camera,FEATURE_TRIGGER_DELAY)
set_trigger_delay_mode(camera::Camera,mode::dc1394feature_mode_t)=set_mode(camera,FEATURE_TRIGGER_DELAY,mode)
switch_absolute_trigger_delay(camera::Camera,switch::dc1394switch_t)=set_absolute_control(camera,FEATURE_TRIGGER_DELAY,switch)
is_absolute_trigger_delay(camera::Camera)=get_absolute_control(camera,FEATURE_TRIGGER_DELAY)
has_absolute_trigger_delay(camera::Camera)=has_absolute_control(camera,FEATURE_TRIGGER_DELAY)
get_absolute_trigger_delay(camera::Camera)=get_absolute_value(camera,FEATURE_TRIGGER_DELAY)
set_absolute_trigger_delay(camera::Camera,value::Real)=set_absolute_value(camera,FEATURE_TRIGGER_DELAY,value)

get_zoom(camera::Camera)=get_value(camera,FEATURE_ZOOM)
set_zoom(camera::Camera,value::Integer)=set_value(camera,FEATURE_ZOOM,value)
get_zoom_modes(camera::Camera)=get_modes(camera,FEATURE_ZOOM)
get_zoom_mode(camera::Camera)=get_mode(camera,FEATURE_ZOOM)
set_zoom_mode(camera::Camera,mode::dc1394feature_mode_t)=set_mode(camera,FEATURE_ZOOM,mode)
switch_absolute_zoom(camera::Camera,switch::dc1394switch_t)=set_absolute_control(camera,FEATURE_ZOOM,switch)
is_absolute_zoom(camera::Camera)=get_absolute_control(camera,FEATURE_ZOOM)
has_absolute_zoom(camera::Camera)=has_absolute_control(camera,FEATURE_ZOOM)
get_absolute_zoom(camera::Camera)=get_absolute_value(camera,FEATURE_ZOOM)
set_absolute_zoom(camera::Camera,value::Real)=set_absolute_value(camera,FEATURE_ZOOM,value)

get_pan(camera::Camera)=get_value(camera,FEATURE_PAN)
set_pan(camera::Camera,value::Integer)=set_value(camera,FEATURE_PAN,value)
get_pan_modes(camera::Camera)=get_modes(camera,FEATURE_PAN)
get_pan_mode(camera::Camera)=get_mode(camera,FEATURE_PAN)
set_pan_mode(camera::Camera,mode::dc1394feature_mode_t)=set_mode(camera,FEATURE_PAN,mode)
switch_absolute_pan(camera::Camera,switch::dc1394switch_t)=set_absolute_control(camera,FEATURE_PAN,switch)
is_absolute_pan(camera::Camera)=get_absolute_control(camera,FEATURE_PAN)
has_absolute_pan(camera::Camera)=has_absolute_control(camera,FEATURE_PAN)
get_absolute_pan(camera::Camera)=get_absolute_value(camera,FEATURE_PAN)
set_absolute_pan(camera::Camera,value::Real)=set_absolute_value(camera,FEATURE_PAN,value)

get_tilt(camera::Camera)=get_value(camera,FEATURE_TILT)
set_tilt(camera::Camera,value::Integer)=set_value(camera,FEATURE_TILT,value)
get_tilt_modes(camera::Camera)=get_modes(camera,FEATURE_TILT)
get_tilt_mode(camera::Camera)=get_mode(camera,FEATURE_TILT)
set_tilt_mode(camera::Camera,mode::dc1394feature_mode_t)=set_mode(camera,FEATURE_TILT,mode)
switch_absolute_tilt(camera::Camera,switch::dc1394switch_t)=set_absolute_control(camera,FEATURE_TILT,switch)
is_absolute_tilt(camera::Camera)=get_absolute_control(camera,FEATURE_TILT)
has_absolute_tilt(camera::Camera)=has_absolute_control(camera,FEATURE_TILT)
get_absolute_tilt(camera::Camera)=get_absolute_value(camera,FEATURE_TILT)
set_absolute_tilt(camera::Camera,value::Real)=set_absolute_value(camera,FEATURE_TILT,value)

get_optical_filter(camera::Camera)=get_value(camera,FEATURE_OPTICAL_FILTER)
set_optical_filter(camera::Camera,value::Integer)=set_value(camera,FEATURE_OPTICAL_FILTER,value)
get_optical_filter_modes(camera::Camera)=get_modes(camera,FEATURE_OPTICAL_FILTER)
get_optical_filter_mode(camera::Camera)=get_mode(camera,FEATURE_OPTICAL_FILTER)
set_optical_filter_mode(camera::Camera,mode::dc1394feature_mode_t)=set_mode(camera,FEATURE_OPTICAL_FILTER,mode)
switch_absolute_optical_filter(camera::Camera,switch::dc1394switch_t)=set_absolute_control(camera,FEATURE_OPTICAL_FILTER,switch)
is_absolute_optical_filter(camera::Camera)=get_absolute_control(camera,FEATURE_OPTICAL_FILTER)
has_absolute_optical_filter(camera::Camera)=has_absolute_control(camera,FEATURE_OPTICAL_FILTER)
get_absolute_optical_filter(camera::Camera)=get_absolute_value(camera,FEATURE_OPTICAL_FILTER)
set_absolute_optical_filter(camera::Camera,value::Real)=set_absolute_value(camera,FEATURE_OPTICAL_FILTER,value)

get_capture_size(camera::Camera)=get_value(camera,FEATURE_CAPTURE_SIZE)
set_capture_size(camera::Camera,value::Integer)=set_value(camera,FEATURE_CAPTURE_SIZE,value)
get_capture_size_modes(camera::Camera)=get_modes(camera,FEATURE_CAPTURE_SIZE)
get_capture_size_mode(camera::Camera)=get_mode(camera,FEATURE_CAPTURE_SIZE)
set_capture_size_mode(camera::Camera,mode::dc1394feature_mode_t)=set_mode(camera,FEATURE_CAPTURE_SIZE,mode)
switch_absolute_capture_size(camera::Camera,switch::dc1394switch_t)=set_absolute_control(camera,FEATURE_CAPTURE_SIZE,switch)
is_absolute_capture_size(camera::Camera)=get_absolute_control(camera,FEATURE_CAPTURE_SIZE)
has_absolute_capture_size(camera::Camera)=has_absolute_control(camera,FEATURE_CAPTURE_SIZE)
get_absolute_capture_size(camera::Camera)=get_absolute_value(camera,FEATURE_CAPTURE_SIZE)
set_absolute_capture_size(camera::Camera,value::Real)=set_absolute_value(camera,FEATURE_CAPTURE_SIZE,value)

get_capture_quality(camera::Camera)=get_value(camera,FEATURE_CAPTURE_QUALITY)
set_capture_quality(camera::Camera,value::Integer)=set_value(camera,FEATURE_CAPTURE_QUALITY,value)
get_capture_quality_modes(camera::Camera)=get_modes(camera,FEATURE_CAPTURE_QUALITY)
get_capture_quality_mode(camera::Camera)=get_mode(camera,FEATURE_CAPTURE_QUALITY)
set_capture_quality_mode(camera::Camera,mode::dc1394feature_mode_t)=set_mode(camera,FEATURE_CAPTURE_QUALITY,mode)
switch_absolute_capture_quality(camera::Camera,switch::dc1394switch_t)=set_absolute_control(camera,FEATURE_CAPTURE_QUALITY,switch)
is_absolute_capture_quality(camera::Camera)=get_absolute_control(camera,FEATURE_CAPTURE_QUALITY)
has_absolute_capture_quality(camera::Camera)=has_absolute_control(camera,FEATURE_CAPTURE_QUALITY)
get_absolute_capture_quality(camera::Camera)=get_absolute_value(camera,FEATURE_CAPTURE_QUALITY)
set_absolute_capture_quality(camera::Camera,value::Real)=set_absolute_value(camera,FEATURE_CAPTURE_QUALITY,value)
