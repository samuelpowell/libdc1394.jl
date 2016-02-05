typealias dc1394_t Void
function __init__()
    global const dc1394=pointer_to_array(ccall((:dc1394_new,libdc1394),Ptr{dc1394_t},()),1)
    finalizer(dc1394,dc->ccall((:dc1394_free,libdc1394),Void,(Ptr{dc1394_t},),dc1394))
end

#export VideoMode,ColorCoding,ColorFilter,ByteOrder,Error,Log,IidcVersion,PowerClass,PhyDelay,TriggerMode,Feature,TriggerSource,TriggerPolarity,FeatureMode,Speed,Framerate,OperationMode,CapturePolicy,BayerMethod,StereoMethod,Switch,CameraId,FeatureInfo,VideoFrame,Format7Mode,CameraInfo,Dc1394,

export Camera
export Feature,VideoMode,Framerate,OperationMode
export get_camera_ids
export get_info,
set_broadcast,is_broadcast,
reset_bus,read_cycle_timer,get_node,
get_features,get_feature,
#get and set Feature generic way
get_value,set_value,is_present,is_readable,get_boundaries,is_switchable,get_power,set_power,get_modes,get_mode,set_mode,has_absolute_control,get_absolute_boundaries,get_absolute_value,set_absolute_value,get_absolute_control,set_absolute_control,
#get and set a special camera features
get_whitebalance,
set_whitebalance,
get_whitebalance_modes,
get_whitebalance_mode,
aset_whitebalance_mode,
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
set_capture_quality_mode,
# external trigger parameters
external_trigger_set_polarity,external_trigger_get_polarity,external_trigger_has_polarity,
external_trigger_set_power,external_trigger_get_power,
external_trigger_set_mode,external_trigger_get_mode,
external_trigger_set_source,external_trigger_get_source,
external_trigger_get_supported_sources,
# software trigger parameters
software_trigger_get_power,software_trigger_set_power,
pio_set,pio_get,reset,set_power,memory_busy,memory_save,memory_load,
get_supported_video_modes,get_video_mode,set_video_mode,
get_supported_framerates,get_framerate,set_framerate,
get_operation_mode,set_operation_mode,
get_iso_speed,set_iso_speed,
get_iso_channel,set_iso_channel,
get_data_depth,
set_transmission,get_transmission,
set_one_shot,get_one_shot,
set_multi_shot,get_multi_shot,
get_bandwidth_usage,
capture_setup,capture_stop,capture_get_fileno,capture_dequeue,capture_enqueue,is_corrupt,capture_set_callback,
#convert_to_YUV422,convert_to_MONO8,convert_to_RGB8,deinterlace_stereo,bayer_decoding_8bit,bayer_decoding_16bit,convert_frames,
debayer,get_info,get_image,
#deinterlace_stereo_frames,
# for format7 mode
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
format7_get_modeset,format7_get_mode_info,
iso_set_persist,iso_allocate_channel,iso_release_channel,iso_allocate_bandwidth,iso_release_bandwidth,iso_release_all,
get_image_size,
framerate_as_float,
get_data_depth,
get_bit_size,
get_color_coding,
is_color,
is_scalable,
is_still_image,
is_same,
feature_get_string,
error_get_string,
checksum_crc16


using Compat
#=
const ROM_BUS_INFO_BLOCK = 0x0400
const ROM_ROOT_DIRECTORY = 0x0414
const CSR_CONFIG_ROM_END = 0x0800
const REG_CAMERA_FEATURE_ABS_HI_BASE = 0x0700
const REG_CAMERA_FEATURE_ABS_LO_BASE = 0x0780
const REG_CAMERA_ABS_MIN = 0x0000
const REG_CAMERA_ABS_MAX = 0x0004
const REG_CAMERA_ABS_VALUE = 0x0008
const REG_CAMERA_INITIALIZE = 0x0000
const REG_CAMERA_V_FORMAT_INQ = 0x0100
const REG_CAMERA_V_MODE_INQ_BASE = 0x0180
const REG_CAMERA_V_RATE_INQ_BASE = 0x0200
const REG_CAMERA_V_REV_INQ_BASE = 0x02c0
const REG_CAMERA_V_CSR_INQ_BASE = 0x02e0
const REG_CAMERA_BASIC_FUNC_INQ = 0x0400
const REG_CAMERA_FEATURE_HI_INQ = 0x0404
const REG_CAMERA_FEATURE_LO_INQ = 0x0408
const REG_CAMERA_OPT_FUNC_INQ = 0x040c
const REG_CAMERA_ADV_FEATURE_INQ = 0x0480
const REG_CAMERA_PIO_CONTROL_CSR_INQ = 0x0484
const REG_CAMERA_SIO_CONTROL_CSR_INQ = 0x0488
const REG_CAMERA_STROBE_CONTROL_CSR_INQ = 0x048c
const REG_CAMERA_FEATURE_HI_BASE_INQ = 0x0500
const REG_CAMERA_FEATURE_LO_BASE_INQ = 0x0580
const REG_CAMERA_FRAME_RATE = 0x0600
const REG_CAMERA_VIDEO_MODE = 0x0604
const REG_CAMERA_VIDEO_FORMAT = 0x0608
const REG_CAMERA_ISO_DATA = 0x060c
const REG_CAMERA_POWER = 0x0610
const REG_CAMERA_ISO_EN = 0x0614
const REG_CAMERA_MEMORY_SAVE = 0x0618
const REG_CAMERA_ONE_SHOT = 0x061c
const REG_CAMERA_MEM_SAVE_CH = 0x0620
const REG_CAMERA_CUR_MEM_CH = 0x0624
const REG_CAMERA_SOFT_TRIGGER = 0x062c
const REG_CAMERA_DATA_DEPTH = 0x0630
const REG_CAMERA_FEATURE_ERR_HI_INQ = 0x0640
const REG_CAMERA_FEATURE_ERR_LO_INQ = 0x0644
const REG_CAMERA_FEATURE_HI_BASE = 0x0800
const REG_CAMERA_FEATURE_LO_BASE = 0x0880
const REG_CAMERA_BRIGHTNESS = 0x0800
const REG_CAMERA_EXPOSURE = 0x0804
const REG_CAMERA_SHARPNESS = 0x0808
const REG_CAMERA_WHITE_BALANCE = 0x080c
const REG_CAMERA_HUE = 0x0810
const REG_CAMERA_SATURATION = 0x0814
const REG_CAMERA_GAMMA = 0x0818
const REG_CAMERA_SHUTTER = 0x081c
const REG_CAMERA_GAIN = 0x0820
const REG_CAMERA_IRIS = 0x0824
const REG_CAMERA_FOCUS = 0x0828
const REG_CAMERA_TEMPERATURE = 0x082c
const REG_CAMERA_TRIGGER_MODE = 0x0830
const REG_CAMERA_TRIGGER_DELAY = 0x0834
const REG_CAMERA_WHITE_SHADING = 0x0838
const REG_CAMERA_FRAME_RATE_FEATURE = 0x083c
const REG_CAMERA_ZOOM = 0x0880
const REG_CAMERA_PAN = 0x0884
const REG_CAMERA_TILT = 0x0888
const REG_CAMERA_OPTICAL_FILTER = 0x088c
const REG_CAMERA_CAPTURE_SIZE = 0x08c0
const REG_CAMERA_CAPTURE_QUALITY = 0x08c4
const REG_CAMERA_FORMAT7_MAX_IMAGE_SIZE_INQ = 0x0000
const REG_CAMERA_FORMAT7_UNIT_SIZE_INQ = 0x0004
const REG_CAMERA_FORMAT7_IMAGE_POSITION = 0x0008
const REG_CAMERA_FORMAT7_IMAGE_SIZE = 0x000c
const REG_CAMERA_FORMAT7_COLOR_CODING_ID = 0x0010
const REG_CAMERA_FORMAT7_COLOR_CODING_INQ = 0x0014
const REG_CAMERA_FORMAT7_PIXEL_NUMBER_INQ = 0x0034
const REG_CAMERA_FORMAT7_TOTAL_BYTES_HI_INQ = 0x0038
const REG_CAMERA_FORMAT7_TOTAL_BYTES_LO_INQ = 0x003c
const REG_CAMERA_FORMAT7_PACKET_PARA_INQ = 0x0040
const REG_CAMERA_FORMAT7_BYTE_PER_PACKET = 0x0044
const REG_CAMERA_FORMAT7_PACKET_PER_FRAME_INQ = 0x0048
const REG_CAMERA_FORMAT7_UNIT_POSITION_INQ = 0x004c
const REG_CAMERA_FORMAT7_FRAME_INTERVAL_INQ = 0x0050
const REG_CAMERA_FORMAT7_DATA_DEPTH_INQ = 0x0054
const REG_CAMERA_FORMAT7_COLOR_FILTER_ID = 0x0058
const REG_CAMERA_FORMAT7_VALUE_SETTING = 0x007c
const REG_CAMERA_PIO_IN = 0x0000
const REG_CAMERA_PIO_OUT = 0x0004
=#

# begin enum dc1394video_mode_t
@enum(VideoMode,
      VIDEO_MODE_160x120_YUV444 = (UInt32)(64),
      VIDEO_MODE_320x240_YUV422 = (UInt32)(65),
      VIDEO_MODE_640x480_YUV411 = (UInt32)(66),
      VIDEO_MODE_640x480_YUV422 = (UInt32)(67),
      VIDEO_MODE_640x480_RGB8 = (UInt32)(68),
      VIDEO_MODE_640x480_MONO8 = (UInt32)(69),
      VIDEO_MODE_640x480_MONO16 = (UInt32)(70),
      VIDEO_MODE_800x600_YUV422 = (UInt32)(71),
      VIDEO_MODE_800x600_RGB8 = (UInt32)(72),
VIDEO_MODE_800x600_MONO8 = (UInt32)(73),
VIDEO_MODE_1024x768_YUV422 = (UInt32)(74),
VIDEO_MODE_1024x768_RGB8 = (UInt32)(75),
VIDEO_MODE_1024x768_MONO8 = (UInt32)(76),
VIDEO_MODE_800x600_MONO16 = (UInt32)(77),
VIDEO_MODE_1024x768_MONO16 = (UInt32)(78),
VIDEO_MODE_1280x960_YUV422 = (UInt32)(79),
VIDEO_MODE_1280x960_RGB8 = (UInt32)(80),
VIDEO_MODE_1280x960_MONO8 = (UInt32)(81),
VIDEO_MODE_1600x1200_YUV422 = (UInt32)(82),
VIDEO_MODE_1600x1200_RGB8 = (UInt32)(83),
VIDEO_MODE_1600x1200_MONO8 = (UInt32)(84),
VIDEO_MODE_1280x960_MONO16 = (UInt32)(85),
VIDEO_MODE_1600x1200_MONO16 = (UInt32)(86),
VIDEO_MODE_EXIF = (UInt32)(87),
VIDEO_MODE_FORMAT7_0 = (UInt32)(88),
VIDEO_MODE_FORMAT7_1 = (UInt32)(89),
VIDEO_MODE_FORMAT7_2 = (UInt32)(90),
VIDEO_MODE_FORMAT7_3 = (UInt32)(91),
VIDEO_MODE_FORMAT7_4 = (UInt32)(92),
VIDEO_MODE_FORMAT7_5 = (UInt32)(93),
VIDEO_MODE_FORMAT7_6 = (UInt32)(94),
VIDEO_MODE_FORMAT7_7 = (UInt32)(95))
# end enum dc1394video_mode_t

const VIDEO_MODE_MIN = VIDEO_MODE_160x120_YUV444
const VIDEO_MODE_MAX = VIDEO_MODE_FORMAT7_7
const VIDEO_MODE_NUM = (Int(VIDEO_MODE_MAX) - Int(VIDEO_MODE_MIN)) + 1
const VIDEO_MODE_FORMAT7_MIN = VIDEO_MODE_FORMAT7_0
const VIDEO_MODE_FORMAT7_MAX = VIDEO_MODE_FORMAT7_7
const VIDEO_MODE_FORMAT7_NUM = (Int(VIDEO_MODE_FORMAT7_MAX) - Int(VIDEO_MODE_FORMAT7_MIN)) + 1

# begin enum dc1394color_coding_t
@enum(ColorCoding,
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
# end enum ColorCoding

const COLOR_CODING_MIN = COLOR_CODING_MONO8
const COLOR_CODING_MAX = COLOR_CODING_RAW16
const COLOR_CODING_NUM = (Int(COLOR_CODING_MAX) - Int(COLOR_CODING_MIN)) + 1

# begin enum dc1394color_filter_t
@enum(ColorFilter,
      COLOR_FILTER_RGGB = (UInt32)(512),
      COLOR_FILTER_GBRG = (UInt32)(513),
      COLOR_FILTER_GRBG = (UInt32)(514),
      COLOR_FILTER_BGGR = (UInt32)(515))
# end enum ColorFilter

const COLOR_FILTER_MIN = COLOR_FILTER_RGGB
const COLOR_FILTER_MAX = COLOR_FILTER_BGGR
const COLOR_FILTER_NUM = (Int(COLOR_FILTER_MAX) - Int(COLOR_FILTER_MIN)) + 1

# begin enum dc1394byte_order_t
@enum(ByteOrder,
      BYTE_ORDER_UYVY = (UInt32)(800),
      BYTE_ORDER_YUYV = (UInt32)(801))
# end enum ByteOrder

const BYTE_ORDER_MIN = BYTE_ORDER_UYVY
const BYTE_ORDER_MAX = BYTE_ORDER_YUYV
const BYTE_ORDER_NUM = (Int(BYTE_ORDER_MAX) - Int(BYTE_ORDER_MIN)) + 1

# begin enum dc1394error_t
@enum(Error,
      SUCCESS = (Int32)(0),
      FAILURE = (Int32)(-1),
      NOT_A_CAMERA = (Int32)(-2),
      FUNCTION_NOT_SUPPORTED = (Int32)(-3),
      CAMERA_NOT_INITIALIZED = (Int32)(-4),
      MEMORY_ALLOCATION_FAILURE = (Int32)(-5),
      TAGGED_REGISTER_NOT_FOUND = (Int32)(-6),
      NO_ISO_CHANNEL = (Int32)(-7),
      NO_BANDWIDTH = (Int32)(-8),
IOCTL_FAILURE = (Int32)(-9),
CAPTURE_IS_NOT_SET = (Int32)(-10),
CAPTURE_IS_RUNNING = (Int32)(-11),
RAW1394_FAILURE = (Int32)(-12),
FORMAT7_ERROR_FLAG_1 = (Int32)(-13),
FORMAT7_ERROR_FLAG_2 = (Int32)(-14),
INVALID_ARGUMENT_VALUE = (Int32)(-15),
REQ_VALUE_OUTSIDE_RANGE = (Int32)(-16),
INVALID_FEATURE = (Int32)(-17),
INVALID_VIDEO_FORMAT = (Int32)(-18),
INVALID_VIDEO_MODE = (Int32)(-19),
INVALID_FRAMERATE = (Int32)(-20),
INVALID_TRIGGER_MODE = (Int32)(-21),
INVALID_TRIGGER_SOURCE = (Int32)(-22),
INVALID_ISO_SPEED = (Int32)(-23),
INVALID_IIDC_VERSION = (Int32)(-24),
INVALID_COLOR_CODING = (Int32)(-25),
INVALID_COLOR_FILTER = (Int32)(-26),
INVALID_CAPTURE_POLICY = (Int32)(-27),
INVALID_ERROR_CODE = (Int32)(-28),
INVALID_BAYER_METHOD = (Int32)(-29),
INVALID_VIDEO1394_DEVICE = (Int32)(-30),
INVALID_OPERATION_MODE = (Int32)(-31),
INVALID_TRIGGER_POLARITY = (Int32)(-32),
INVALID_FEATURE_MODE = (Int32)(-33),
INVALID_LOG_TYPE = (Int32)(-34),
INVALID_BYTE_ORDER = (Int32)(-35),
INVALID_STEREO_METHOD = (Int32)(-36),
BASLER_NO_MORE_SFF_CHUNKS = (Int32)(-37),
BASLER_CORRUPTED_SFF_CHUNK = (Int32)(-38),
BASLER_UNKNOWN_SFF_CHUNK = (Int32)(-39))
# end enum Error

const ERROR_MIN = BASLER_UNKNOWN_SFF_CHUNK
const ERROR_MAX = SUCCESS
const ERROR_NUM = (Int(ERROR_MAX) - Int(ERROR_MIN)) + 1

# begin enum dc1394log_t
@enum(Log,
      LOG_ERROR = (UInt32)(768),
      LOG_WARNING = (UInt32)(769),
      LOG_DEBUG = (UInt32)(770))
# end enum Log

const LOG_MIN = LOG_ERROR
const LOG_MAX = LOG_DEBUG
const LOG_NUM = (Int(LOG_MAX) - Int(LOG_MIN)) + 1

# begin enum dc1394iidc_version_t
@enum(IidcVersion,
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
# end enum IidcVersion

const IIDC_VERSION_MIN = IIDC_VERSION_1_04
const IIDC_VERSION_MAX = IIDC_VERSION_1_39
const IIDC_VERSION_NUM = (Int(IIDC_VERSION_MAX) - Int(IIDC_VERSION_MIN)) + 1

# begin enum dc1394power_class_t
@enum(PowerClass,
      POWER_CLASS_NONE = (UInt32)(608),
      POWER_CLASS_PROV_MIN_15W = (UInt32)(609),
      POWER_CLASS_PROV_MIN_30W = (UInt32)(610),
      POWER_CLASS_PROV_MIN_45W = (UInt32)(611),
      POWER_CLASS_USES_MAX_1W = (UInt32)(612),
      POWER_CLASS_USES_MAX_3W = (UInt32)(613),
      POWER_CLASS_USES_MAX_6W = (UInt32)(614),
      POWER_CLASS_USES_MAX_10W = (UInt32)(615))
# end enum PowerClass

const POWER_CLASS_MIN = POWER_CLASS_NONE
const POWER_CLASS_MAX = POWER_CLASS_USES_MAX_10W
const POWER_CLASS_NUM = (Int(POWER_CLASS_MAX) - Int(POWER_CLASS_MIN)) + 1

# begin enum dc1394phy_delay_t
@enum(PhyDelay,
      PHY_DELAY_MAX_144_NS = (UInt32)(640),
      PHY_DELAY_UNKNOWN_0 = (UInt32)(641),
      PHY_DELAY_UNKNOWN_1 = (UInt32)(642),
      PHY_DELAY_UNKNOWN_2 = (UInt32)(643))
# end enum PhyDelay

const PHY_DELAY_MIN = PHY_DELAY_MAX_144_NS
const PHY_DELAY_MAX = PHY_DELAY_UNKNOWN_0
const PHY_DELAY_NUM = (Int(PHY_DELAY_MAX) - Int(PHY_DELAY_MIN)) + 1

# begin enum dc1394trigger_mode_t
@enum(TriggerMode,
      TRIGGER_MODE_0 = (UInt32)(384),
      TRIGGER_MODE_1 = (UInt32)(385),
      TRIGGER_MODE_2 = (UInt32)(386),
      TRIGGER_MODE_3 = (UInt32)(387),
      TRIGGER_MODE_4 = (UInt32)(388),
      TRIGGER_MODE_5 = (UInt32)(389),
      TRIGGER_MODE_14 = (UInt32)(390),
      TRIGGER_MODE_15 = (UInt32)(391))
# end enum TriggerMode

const TRIGGER_MODE_MIN = TRIGGER_MODE_0
const TRIGGER_MODE_MAX = TRIGGER_MODE_15
const TRIGGER_MODE_NUM = (Int(TRIGGER_MODE_MAX) - Int(TRIGGER_MODE_MIN)) + 1

# begin enum dc1394feature_t
@enum(Feature,
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
# end enum Feature

const FEATURE_MIN = FEATURE_BRIGHTNESS
const FEATURE_MAX = FEATURE_CAPTURE_QUALITY
const FEATURE_NUM = (Int(FEATURE_MAX) - Int(FEATURE_MIN)) + 1

# begin enum dc1394trigger_source_t
@enum(TriggerSource,
      TRIGGER_SOURCE_0 = (UInt32)(576),
      TRIGGER_SOURCE_1 = (UInt32)(577),
      TRIGGER_SOURCE_2 = (UInt32)(578),
      TRIGGER_SOURCE_3 = (UInt32)(579),
      TRIGGER_SOURCE_SOFTWARE = (UInt32)(580))
# end enum TriggerSource

const TRIGGER_SOURCE_MIN = TRIGGER_SOURCE_0
const TRIGGER_SOURCE_MAX = TRIGGER_SOURCE_SOFTWARE
const TRIGGER_SOURCE_NUM = (Int(TRIGGER_SOURCE_MAX) - Int(TRIGGER_SOURCE_MIN)) + 1

# begin enum dc1394trigger_polarity_t
@enum(TriggerPolarity,
      TRIGGER_ACTIVE_LOW = (UInt32)(704),
      TRIGGER_ACTIVE_HIGH = (UInt32)(705))
# end enum TriggerPolarity

const TRIGGER_ACTIVE_MIN = TRIGGER_ACTIVE_LOW
const TRIGGER_ACTIVE_MAX = TRIGGER_ACTIVE_HIGH
const TRIGGER_ACTIVE_NUM = (Int(TRIGGER_ACTIVE_MAX) - Int(TRIGGER_ACTIVE_MIN)) + 1

# begin enum dc1394feature_mode_t
@enum(FeatureMode,
      FEATURE_MODE_MANUAL = (UInt32)(736),
      FEATURE_MODE_AUTO = (UInt32)(737),
      FEATURE_MODE_ONE_PUSH_AUTO = (UInt32)(738))
# end enum FeatureMode

FEATURE_MODE_MIN = FEATURE_MODE_MANUAL
FEATURE_MODE_MAX = FEATURE_MODE_ONE_PUSH_AUTO
FEATURE_MODE_NUM = (Int(FEATURE_MODE_MAX) - Int(FEATURE_MODE_MIN)) + 1

# begin enum dc1394speed_t
@enum(Speed,
      ISO_SPEED_100 = (UInt32)(0),
      ISO_SPEED_200 = (UInt32)(1),
      ISO_SPEED_400 = (UInt32)(2),
      ISO_SPEED_800 = (UInt32)(3),
      ISO_SPEED_1600 = (UInt32)(4),
      ISO_SPEED_3200 = (UInt32)(5))
# end enum Speed

const ISO_SPEED_MIN = ISO_SPEED_100
const ISO_SPEED_MAX = ISO_SPEED_3200
const ISO_SPEED_NUM = (Int(ISO_SPEED_MAX) - Int(ISO_SPEED_MIN)) + 1

# begin enum dc1394framerate_t
@enum(Framerate,
      FRAMERATE_1_875 = (UInt32)(32),
      FRAMERATE_3_75 = (UInt32)(33),
      FRAMERATE_7_5 = (UInt32)(34),
      FRAMERATE_15 = (UInt32)(35),
      FRAMERATE_30 = (UInt32)(36),
      FRAMERATE_60 = (UInt32)(37),
      FRAMERATE_120 = (UInt32)(38),
      FRAMERATE_240 = (UInt32)(39))
# end enum Framerate

const FRAMERATE_MIN = FRAMERATE_1_875
const FRAMERATE_MAX = FRAMERATE_240
const FRAMERATE_NUM = (Int(FRAMERATE_MAX) - Int(FRAMERATE_MIN)) + 1

# begin enum dc1394operation_mode_t
@enum(OperationMode,
      OPERATION_MODE_LEGACY = (UInt32)(480),
      OPERATION_MODE_1394B = (UInt32)(481))
# end enum OperationMode

const OPERATION_MODE_MIN = OPERATION_MODE_LEGACY
const OPERATION_MODE_MAX = OPERATION_MODE_1394B
const OPERATION_MODE_NUM = (Int(OPERATION_MODE_MAX) - Int(OPERATION_MODE_MIN)) + 1

# begin enum dc1394capture_policy_t
@enum(CapturePolicy,
      CAPTURE_POLICY_WAIT = (UInt32)(672),
      CAPTURE_POLICY_POLL = (UInt32)(673))
# end enum CapturePolicy

const CAPTURE_POLICY_MIN = CAPTURE_POLICY_WAIT
const CAPTURE_POLICY_MAX = CAPTURE_POLICY_POLL
const CAPTURE_POLICY_NUM = (Int(CAPTURE_POLICY_MAX) - Int(CAPTURE_POLICY_MIN)) + 1

@enum(CaptureFlags,
      CAPTURE_FLAGS_CHANNEL_ALLOC = UInt32(0x00000001),
      CAPTURE_FLAGS_BANDWIDTH_ALLOC = UInt32(0x00000002),
      CAPTURE_FLAGS_DEFAULT = UInt32(0x00000004),
      CAPTURE_FLAGS_AUTO_ISO = UInt32(0x00000008))

# begin enum dc1394bayer_method_t
@enum(BayerMethod,
      BAYER_METHOD_NEAREST = (UInt32)(0),
      BAYER_METHOD_SIMPLE = (UInt32)(1),
      BAYER_METHOD_BILINEAR = (UInt32)(2),
      BAYER_METHOD_HQLINEAR = (UInt32)(3),
      BAYER_METHOD_DOWNSAMPLE = (UInt32)(4),
      BAYER_METHOD_EDGESENSE = (UInt32)(5),
      BAYER_METHOD_VNG = (UInt32)(6),
      BAYER_METHOD_AHD = (UInt32)(7))
# end enum BayerMethod

const BAYER_METHOD_MIN = BAYER_METHOD_NEAREST
const BAYER_METHOD_MAX = BAYER_METHOD_AHD
const BAYER_METHOD_NUM = (Int(BAYER_METHOD_MAX) - Int(BAYER_METHOD_MIN)) + 1

# begin enum dc1394stereo_method_t
@enum(StereoMethod,
      STEREO_METHOD_INTERLACED = (UInt32)(0),
      STEREO_METHOD_FIELD = (UInt32)(1))
# end enum StereoMethod

const STEREO_METHOD_MIN = STEREO_METHOD_INTERLACED
const STEREO_METHOD_MAX = STEREO_METHOD_FIELD
const STEREO_METHOD_NUM = (Int(STEREO_METHOD_MAX) - Int(STEREO_METHOD_MIN)) + 1

const QUERY_FROM_CAMERA = -1
const USE_MAX_AVAIL = -2
const USE_RECOMMENDED = -3

const CONFIG_ROM_BASE = 0x0000fffff0000000
const FEATURE_ON = 0x80000000
const FEATURE_OFF = 0x00000000
const MAX_RETRIES = 20
const NUM_ISO_CHANNELS = 64

const MAX_CHARS = 256
const VIDEO_MODE_FORMAT0_MIN = VIDEO_MODE_160x120_YUV444
const VIDEO_MODE_FORMAT0_MAX = VIDEO_MODE_640x480_MONO16
const VIDEO_MODE_FORMAT0_NUM = (Int(VIDEO_MODE_FORMAT0_MAX) - Int(VIDEO_MODE_FORMAT0_MIN)) + 1
const VIDEO_MODE_FORMAT1_MIN = VIDEO_MODE_800x600_YUV422
const VIDEO_MODE_FORMAT1_MAX = VIDEO_MODE_1024x768_MONO16
const VIDEO_MODE_FORMAT1_NUM = (Int(VIDEO_MODE_FORMAT1_MAX) - Int(VIDEO_MODE_FORMAT1_MIN)) + 1
const VIDEO_MODE_FORMAT2_MIN = VIDEO_MODE_1280x960_YUV422
const VIDEO_MODE_FORMAT2_MAX = VIDEO_MODE_1600x1200_MONO16
const VIDEO_MODE_FORMAT2_NUM = (Int(VIDEO_MODE_FORMAT2_MAX) - Int(VIDEO_MODE_FORMAT2_MIN)) + 1
const VIDEO_MODE_FORMAT6_MIN = VIDEO_MODE_EXIF
const VIDEO_MODE_FORMAT6_MAX = VIDEO_MODE_EXIF
const VIDEO_MODE_FORMAT6_NUM = (Int(VIDEO_MODE_FORMAT6_MAX) - Int(VIDEO_MODE_FORMAT6_MIN)) + 1

#const FORMAT_MIN = FORMAT0
#const FORMAT_MAX = FORMAT7

immutable dc1394color_codings_t
    num::UInt32
    codings::NTuple{11,ColorCoding}
end

immutable dc1394video_modes_t
    num::UInt32
    modes::NTuple{32,VideoMode}
end

# begin enum Bool
@enum(Bool,
      FALSE = (UInt32)(0),
      TRUE = (UInt32)(1))
# end enum Bool

# begin enum Switch
@enum(Switch,
      OFF = (UInt32)(0),
      ON = (UInt32)(1))
# end enum Switch

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
    vendor::Ptr{UInt8}
    model::Ptr{UInt8}
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

immutable CameraId
    unit::UInt16
    guid::UInt64
end

immutable dc1394camera_list_t
    num::UInt32
    ids::Ptr{CameraId}
end

immutable dc1394feature_modes_t
    num::UInt32
    modes::NTuple{3,FeatureMode}
end

immutable dc1394trigger_modes_t
    num::UInt32
    modes::NTuple{8,TriggerMode}
end

immutable dc1394trigger_sources_t
    num::UInt32
    sources::NTuple{5,TriggerSource}
end

immutable FeatureInfo
    id::Feature
    available::Bool
    absolute_capable::Bool
    readout_capable::Bool
    on_off_capable::Bool
    polarity_capable::Bool
    is_on::Switch
    current_mode::FeatureMode
    modes::dc1394feature_modes_t
    trigger_modes::dc1394trigger_modes_t
    trigger_mode::TriggerMode
    trigger_polarity::TriggerPolarity
    trigger_sources::dc1394trigger_sources_t
    trigger_source::TriggerSource
    min::UInt32
    max::UInt32
    value::UInt32
    BU_value::UInt32
    RV_value::UInt32
    B_value::UInt32
    R_value::UInt32
    G_value::UInt32
    target_value::UInt32
    abs_control::Switch
    abs_value::Cfloat
    abs_max::Cfloat
    abs_min::Cfloat
end

immutable dc1394featureset_t
    feature::NTuple{22,FeatureInfo}
end

immutable dc1394framerates_t
    num::UInt32
    framerates::NTuple{8,Framerate}
end

immutable dc1394video_frame_t
    image::Ptr{Cuchar}
    size::NTuple{2,UInt32}
    position::Tuple{UInt32,UInt32}
    color_coding::ColorCoding
    color_filter::ColorFilter
    yuv_byte_order::UInt32
    data_depth::UInt32
    stride::UInt32
    video_mode::VideoMode
    total_bytes::UInt64
    image_bytes::UInt32
    padding_bytes::UInt32
    packet_size::UInt32
    packets_per_frame::UInt32
    timestamp::UInt64
    frames_behind::UInt32
    camera::Ptr{CameraInfo}
    id::UInt32
    allocated_image_bytes::UInt64
    little_endian::Bool
    data_in_padding::Bool
    dc1394video_frame_t()=new(0,
                              (0,0),
                              (0,0),
                              COLOR_CODING_MIN,
                              COLOR_FILTER_MIN,
                              0,
                              0,
                              0,
                              VIDEO_MODE_MIN,
                              0,
                              0,
                              0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    true,
    true)
end

immutable VideoFrame
    handle::Ptr{dc1394video_frame_t}
end
VideoFrame()=VideoFrame(C_NULL)

typealias dc1394capture_callback_t Ptr{Void}

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

immutable dc1394format7modeset_t
    mode::NTuple{8,Format7Mode}
end

# Automatically generated using Clang.jl wrap_c, version 0.0.0
function register_handler(_type::Log,log_handler::Ptr{Void},user::Ptr{Void})
    ccall((:dc1394_log_register_handler,libdc1394),Error,(Log,Ptr{Void},Ptr{Void}),_type,log_handler,user)
end

function set_default_handler(_type::Log)
    ccall((:dc1394_log_set_default_handler,libdc1394),Error,(Log,),_type)
end

function get_camera_ids()
    list=Array{Ptr{dc1394camera_list_t},1}(1)
    err=ccall((:dc1394_camera_enumerate,libdc1394),Error,(Ptr{dc1394_t},Ptr{Ptr{dc1394camera_list_t}}),dc1394,list)
    l=unsafe_load(list[1])
    ids=copy(pointer_to_array(l.ids,l.num));
    ccall((:dc1394_camera_free_list,libdc1394),Void,(Ptr{dc1394camera_list_t},),list[1])
    ids
end

type Camera
    handle::Ptr{CameraInfo}
end
function Camera(guid::UInt64)
    handle=ccall((:dc1394_camera_new,libdc1394),Ptr{CameraInfo},(Ptr{dc1394_t},UInt64),dc1394,guid)
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

function get_info(camera::Camera)
    unsafe_load(camera.handle)
end

function camera_free(camera::Camera)
    if camera.handle!=C_NULL
        ccall((:dc1394_camera_free,libdc1394),Void,(Ptr{CameraInfo},),camera.handle)
    end
    camera.handle=C_NULL
end

function set_broadcast(camera::Camera,pwr::Base.Bool)
    ccall((:dc1394_camera_set_broadcast,libdc1394),Error,(Ptr{CameraInfo},Bool),camera.handle,pwr?TRUE:FALSE)
end

function is_broadcast(camera::Camera)
    pwr=Array{Bool,1}(1)
    ccall((:dc1394_camera_get_broadcast,libdc1394),Error,(Ptr{CameraInfo},Ptr{Bool}),camera.handle,pwr)
    pwr[1]==TRUE
end

function reset_bus(camera::Camera)
    ccall((:dc1394_reset_bus,libdc1394),Error,(Ptr{CameraInfo},),camera.handle)
end

function read_cycle_timer(camera::Camera)
    cycle_timer=[UInt32(0)]
    local_time=[UInt64(0)]
    ccall((:dc1394_read_cycle_timer,libdc1394),Error,(Ptr{CameraInfo},Ptr{UInt32},Ptr{UInt64}),camera.handle,cycle_timer,local_time)
    (Int(cycle_timer[1]),local_time[1])
end

function get_node(camera::Camera)
    node=[UInt32(0)]
    generation=[UInt32(0)]
    ccall((:dc1394_camera_get_node,libdc1394),Error,(Ptr{CameraInfo},Ptr{UInt32},Ptr{UInt32}),camera.handle,node,generation)
    Int(node[1]),Int(generation[1])
end

function get_features(camera::Camera)
    features=Array{FeatureInfo,1}(22)
    ccall((:dc1394_feature_get_all,libdc1394),Error,(Ptr{CameraInfo},Ptr{FeatureInfo}),camera.handle,features)
    features
end

function get_feature(camera::Camera)
    feature=Array{FeatureInfo,1}(1)
    ccall((:dc1394_feature_get,libdc1394),Error,(Ptr{CameraInfo},Ptr{FeatureInfo}),camera.handle,feature)
    feature[1]
end

function get_whitebalance(camera::Camera)
    u_b_value=[UInt32(0)]
    v_r_value=[UInt32(0)]
    ccall((:dc1394_feature_whitebalance_get_value,libdc1394),Error,(Ptr{CameraInfo},Ptr{UInt32},Ptr{UInt32}),camera.handle,u_b_value,v_r_value)
    (Int(u_b_value[1]),Int(v_r_value[1]))
end

function set_whitebalance(camera::Camera,u_b_value::Int,v_r_value::Int)
    ccall((:dc1394_feature_whitebalance_set_value,libdc1394),Error,(Ptr{CameraInfo},UInt32,UInt32),camera.handle,u_b_value,v_r_value)
end

function get_temperature(camera::Camera)
    target_temperature=[UInt32(0)]
    temperature=[UInt32(0)]
    ccall((:dc1394_feature_temperature_get_value,libdc1394),Error,(Ptr{CameraInfo},Ptr{UInt32},Ptr{UInt32}),camera.handle,target_temperature,temperature)
    (Int(target_temperature[1]),Int(temperature[1]))
end

function set_temperature(camera::Camera,target_temperature::Int)
    ccall((:dc1394_feature_temperature_set_value,libdc1394),Error,(Ptr{CameraInfo},UInt32),camera.handle,target_temperature)
end

function get_whiteshading(camera::Camera)
    r_value=[UInt32(0)]
    g_value=[UInt32(0)]
    b_value=[UInt32(0)]
    ccall((:dc1394_feature_whiteshading_get_value,libdc1394),Error,(Ptr{CameraInfo},Ptr{UInt32},Ptr{UInt32},Ptr{UInt32}),camera.handle,r_value,g_value,b_value)
    (Int(r_value[1]),Int(g_value[1]),Int(b_value[1]))
end

function set_whiteshading(camera::Camera,r_value::Int,g_value::Int,b_value::Int)
    ccall((:dc1394_feature_whiteshading_set_value,libdc1394),Error,(Ptr{CameraInfo},UInt32,UInt32,UInt32),camera.handle,r_value,g_value,b_value)
end

function get_value(camera::Camera,feature::Feature)
    value=[UInt32(0)]
    err=ccall((:dc1394_feature_get_value,libdc1394),Error,(Ptr{CameraInfo},Feature,Ptr{UInt32}),camera.handle,feature,value)
    if err === SUCCESS
        return Int(value[1])
    else
        return err
    end
end

function set_value(camera::Camera,feature::Feature,value::Int)
    ccall((:dc1394_feature_set_value,libdc1394),Error,(Ptr{CameraInfo},Feature,UInt32),camera.handle,feature,value)
end

get_whitebalance(vf::VideoFrame)=get_shutter(Camera(get_info(vf).camera))
get_whitebalance_modes(camera::Camera)=get_modes(camera,FEATURE_WHITE_BALANCE)
get_whitebalance_mode(camera::Camera)=get_mode(camera,FEATURE_WHITEB_ALANCE)
set_whitebalance_mode(camera::Camera,mode::FeatureMode)=set_mode(camera,FEATURE_WHITE_BALANCE,mode)
get_temperature_modes(camera::Camera)=get_modes(camera,FEATURE_TEMPERATURE)
get_temperature_mode(camera::Camera)=get_mode(camera,FEATURE_TEMPERATURE)
set_temperature_mode(camera::Camera,mode::FeatureMode)=set_mode(camera,FEATURE_TEMPERATURE,mode)
get_whiteshading_modes(camera::Camera)=get_modes(camera,FEATURE_WHITE_SHADING)
get_whiteshading_mode(camera::Camera)=get_mode(camera,FEATURE_WHITE_SHADING)
set_whiteshading_mode(camera::Camera,mode::FeatureMode)=set_mode(camera,FEATURE_WHITE_SHADING,mode)

get_brightness(camera::Camera)=get_value(camera,FEATURE_BRIGHTNESS)
set_brightness(camera::Camera,value::Int)=set_value(camera,FEATURE_BRIGHTNESS,value)
get_brightness_modes(camera::Camera)=get_modes(camera,FEATURE_BRIGHTNESS)
get_brightness_mode(camera::Camera)=get_mode(camera,FEATURE_BRIGHTNESS)
set_brightness_mode(camera::Camera,mode::FeatureMode)=set_mode(camera,FEATURE_BRIGHTNESS,mode)
get_exposure(camera::Camera)=get_value(camera,FEATURE_EXPOSURE)
set_exposure(camera::Camera,value::Int)=set_value(camera,FEATURE_EXPOSURE,value)
get_exposure_modes(camera::Camera)=get_modes(camera,FEATURE_EXPOSURE)
get_exposure_mode(camera::Camera)=get_mode(camera,FEATURE_EXPOSURE)
set_exposure_mode(camera::Camera,mode::FeatureMode)=set_mode(camera,FEATURE_EXPOSURE,mode)
get_sharpness(camera::Camera)=get_value(camera,FEATURE_SHARPNESS)
set_sharpness(camera::Camera,value::Int)=set_value(camera,FEATURE_SHARPNESS,value)
get_sharpness_modes(camera::Camera)=get_modes(camera,FEATURE_SHARPNESS)
get_sharpness_mode(camera::Camera)=get_mode(camera,FEATURE_SHARPNESS)
set_sharpness_mode(camera::Camera,mode::FeatureMode)=set_mode(camera,FEATURE_SHARPNESS,mode)
get_hue(camera::Camera)=get_value(camera,FEATURE_HUE)
set_hue(camera::Camera,value::Int)=set_value(camera,FEATURE_HUE,value)
get_hue_modes(camera::Camera)=get_modes(camera,FEATURE_HUE)
get_hue_mode(camera::Camera)=get_mode(camera,FEATURE_HUE)
set_hue_mode(camera::Camera,mode::FeatureMode)=set_mode(camera,FEATURE_HUE,mode)
get_saturation(camera::Camera)=get_value(camera,FEATURE_SATURATION)
set_saturation(camera::Camera,value::Int)=set_value(camera,FEATURE_SATURATION,value)
get_saturation_modes(camera::Camera)=get_modes(camera,FEATURE_SATURATION)
get_saturation_mode(camera::Camera)=get_mode(camera,FEATURE_SATURATION)
set_saturation_mode(camera::Camera,mode::FeatureMode)=set_mode(camera,FEATURE_SATURATION,mode)
get_gamma(camera::Camera)=get_value(camera,FEATURE_GAMMA)
set_gamma(camera::Camera,value::Int)=set_value(camera,FEATURE_GAMMA,value)
get_gamma_modes(camera::Camera)=get_modes(camera,FEATURE_GAMMA)
get_gamma_mode(camera::Camera)=get_mode(camera,FEATURE_GAMMA)
set_gamma_mode(camera::Camera,mode::FeatureMode)=set_mode(camera,FEATURE_GAMMA,mode)
get_shutter(camera::Camera)=get_value(camera,FEATURE_SHUTTER)
get_shutter(vf::VideoFrame)=get_shutter(Camera(get_info(vf).camera))
set_shutter(camera::Camera,value::Int)=set_value(camera,FEATURE_SHUTTER,value)
get_shutter_modes(camera::Camera)=get_modes(camera,FEATURE_SHUTTER)
get_shutter_mode(camera::Camera)=get_mode(camera,FEATURE_SHUTTER)
set_shutter_mode(camera::Camera,mode::FeatureMode)=set_mode(camera,FEATURE_SHUTTER,mode)
get_gain(camera::Camera)=get_value(camera,FEATURE_GAIN)
set_gain(camera::Camera,value::Int)=set_value(camera,FEATURE_GAIN,value)
get_gain_modes(camera::Camera)=get_modes(camera,FEATURE_GAIN)
get_gain_mode(camera::Camera)=get_mode(camera,FEATURE_GAIN)
set_gain_mode(camera::Camera,mode::FeatureMode)=set_mode(camera,FEATURE_GAIN,mode)
get_iris(camera::Camera)=get_value(camera,FEATURE_IRIS)
set_iris(camera::Camera,value::Int)=set_value(camera,FEATURE_IRIS,value)
get_iris_modes(camera::Camera)=get_modes(camera,FEATURE_IRIS)
get_iris_mode(camera::Camera)=get_mode(camera,FEATURE_IRIS)
set_iris_mode(camera::Camera,mode::FeatureMode)=set_mode(camera,FEATURE_IRIS,mode)
get_focus(camera::Camera)=get_value(camera,FEATURE_FOCUS)
set_focus(camera::Camera,value::Int)=set_value(camera,FEATURE_FOCUS,value)
get_focus_modes(camera::Camera)=get_modes(camera,FEATURE_FOCUS)
get_focus_mode(camera::Camera)=get_mode(camera,FEATURE_FOCUS)
set_focus_mode(camera::Camera,mode::FeatureMode)=set_mode(camera,FEATURE_FOCUS,mode)
get_trigger(camera::Camera)=get_value(camera,FEATURE_TRIGGER)
set_trigger(camera::Camera,value::Int)=set_value(camera,FEATURE_TRIGGER,value)
get_trigger_modes(camera::Camera)=get_modes(camera,FEATURE_TRIGGER)
get_trigger_mode(camera::Camera)=get_mode(camera,FEATURE_TRIGGER)
set_trigger_mode(camera::Camera,mode::FeatureMode)=set_mode(camera,FEATURE_TRIGGER,mode)
get_trigger_delay(camera::Camera)=get_value(camera,FEATURE_TRIGGER_DELAY)
set_trigger_delay(camera::Camera,value::Int)=set_value(camera,FEATURE_TRIGGER_DELAY,value)
get_trigger_delay_modes(camera::Camera)=get_modes(camera,FEATURE_TRIGGER_DELAY)
get_trigger_delay_mode(camera::Camera)=get_mode(camera,FEATURE_TRIGGER_DELAY)
set_trigger_delay_mode(camera::Camera,mode::FeatureMode)=set_mode(camera,FEATURE_TRIGGER_DELAY,mode)
get_zoom(camera::Camera)=get_value(camera,FEATURE_ZOOM)
set_zoom(camera::Camera,value::Int)=set_value(camera,FEATURE_ZOOM,value)
get_zoom_modes(camera::Camera)=get_modes(camera,FEATURE_ZOOM)
get_zoom_mode(camera::Camera)=get_mode(camera,FEATURE_ZOOM)
set_zoom_mode(camera::Camera,mode::FeatureMode)=set_mode(camera,FEATURE_ZOOM,mode)
get_pan(camera::Camera)=get_value(camera,FEATURE_PAN)
set_pan(camera::Camera,value::Int)=set_value(camera,FEATURE_PAN,value)
get_pan_modes(camera::Camera)=get_modes(camera,FEATURE_PAN)
get_pan_mode(camera::Camera)=get_mode(camera,FEATURE_PAN)
set_pan_mode(camera::Camera,mode::FeatureMode)=set_mode(camera,FEATURE_PAN,mode)
get_tilt(camera::Camera)=get_value(camera,FEATURE_TILT)
set_tilt(camera::Camera,value::Int)=set_value(camera,FEATURE_TILT,value)
get_tilt_modes(camera::Camera)=get_modes(camera,FEATURE_TILT)
get_tilt_mode(camera::Camera)=get_mode(camera,FEATURE_TILT)
set_tilt_mode(camera::Camera,mode::FeatureMode)=set_mode(camera,FEATURE_TILT,mode)
get_optical_filter(camera::Camera)=get_value(camera,FEATURE_OPTICAL_FILTER)
set_optical_filter(camera::Camera,value::Int)=set_value(camera,FEATURE_OPTICAL_FILTER,value)
get_optical_filter_modes(camera::Camera)=get_modes(camera,FEATURE_OPTICAL_FILTER)
get_optical_filter_mode(camera::Camera)=get_mode(camera,FEATURE_OPTICAL_FILTER)
set_optical_filter_mode(camera::Camera,mode::FeatureMode)=set_mode(camera,FEATURE_OPTICAL_FILTER,mode)
get_capture_size(camera::Camera)=get_value(camera,FEATURE_CAPTURE_SIZE)
set_capture_size(camera::Camera,value::Int)=set_value(camera,FEATURE_CAPTURE_SIZE,value)
get_capture_size_modes(camera::Camera)=get_modes(camera,FEATURE_CAPTURE_SIZE)
get_capture_size_mode(camera::Camera)=get_mode(camera,FEATURE_CAPTURE_SIZE)
set_capture_size_mode(camera::Camera,mode::FeatureMode)=set_mode(camera,FEATURE_CAPTURE_SIZE,mode)
get_capture_quality(camera::Camera)=get_value(camera,FEATURE_CAPTURE_QUALITY)
set_capture_quality(camera::Camera,value::Int)=set_value(camera,FEATURE_CAPTURE_QUALITY,value)
get_capture_quality_modes(camera::Camera)=get_modes(camera,FEATURE_CAPTURE_QUALITY)
get_capture_quality_mode(camera::Camera)=get_mode(camera,FEATURE_CAPTURE_QUALITY)
set_capture_quality_mode(camera::Camera,mode::FeatureMode)=set_mode(camera,FEATURE_CAPTURE_QUALITY,mode)


function is_present(camera::Camera,feature::Feature)
    value=[Bool(FALSE)]
    Ccall((:dc1394_feature_is_present,libdc1394),Error,(Ptr{CameraInfo},Feature,Ptr{Bool}),camera.handle,feature,value)
    value[1]==TRUE
end

function is_readable(camera::Camera,feature::Feature)
    value=[Bool(FALSE)]
    ccall((:dc1394_feature_is_readable,libdc1394),Error,(Ptr{CameraInfo},Feature,Ptr{Bool}),camera.handle,feature,value)
    value[1]==TRUE
end

function get_boundaries(camera::Camera,feature::Feature)
    min=[UInt32(0)]
    max=[UInt32(0)]
    ccall((:dc1394_feature_get_boundaries,libdc1394),Error,(Ptr{CameraInfo},Feature,Ptr{UInt32},Ptr{UInt32}),camera.handle,feature,min,max)
    (Int(min[1]),Int(max[1]))
end

function is_switchable(camera::Camera,feature::Feature)
    value=[Bool(FALSE)]
    ccall((:dc1394_feature_is_switchable,libdc1394),Error,(Ptr{CameraInfo},Feature,Ptr{Bool}),camera.handel,feature,value)
    value[1]==TRUE
end

function get_power(camera::Camera,feature::Feature)
    pwr=[Switch(OFF)]
    ccall((:dc1394_feature_get_power,libdc1394),Error,(Ptr{CameraInfo},Feature,Ptr{Switch}),camera.handle,feature,pwr)
    pwr[1]
end

function set_power(camera::Camera,feature::Feature,pwr::Switch)
    ccall((:dc1394_feature_set_power,libdc1394),Error,(Ptr{CameraInfo},Feature,Switch),camera.handle,feature,pwr)
end

function get_modes(camera::Camera,feature::Feature)
    modes=Array{dc1394feature_modes_t,1}(1)
    ccall((:dc1394_feature_get_modes,libdc1394),Error,(Ptr{CameraInfo},Feature,Ptr{dc1394feature_modes_t}),camera.handle,feature,modes)
    modes[1].modes[1:modes[1].num]
end

function get_mode(camera::Camera,feature::Feature)
    mode=[FEATURE_MODE_MIN]
    ccall((:dc1394_feature_get_mode,libdc1394),Error,(Ptr{CameraInfo},Feature,Ptr{FeatureMode}),camera.handle,feature,mode)
    mode[1]
end

function set_mode(camera::Camera,feature::Feature,mode::FeatureMode)
    ccall((:dc1394_feature_set_mode,libdc1394),Error,(Ptr{CameraInfo},Feature,FeatureMode),camera.handle,feature,mode)
end

function has_absolute_control(camera::Camera,feature::Feature)
    value=[Bool(FALSE)]
    ccall((:dc1394_feature_has_absolute_control,libdc1394),Error,(Ptr{CameraInfo},Feature,Ptr{Bool}),camera.handle,feature,value)
    value[1]==TRUE
end

function get_absolute_boundaries(camera::Camera,feature::Feature,min::Ptr{Cfloat},max::Ptr{Cfloat})
    min=[Cfloat(0)]
    max=[Cfloat(0)]
    ccall((:dc1394_feature_get_absolute_boundaries,libdc1394),Error,(Ptr{CameraInfo},Feature,Ptr{Cfloat},Ptr{Cfloat}),camera.handle,feature,min,max)
    min[1],max[1]
end

function get_absolute_value(camera::Camera,feature::Feature)
    value=[Cfloat(0)]
    ccall((:dc1394_feature_get_absolute_value,libdc1394),Error,(Ptr{CameraInfo},Feature,Ptr{Cfloat}),camera.handle,feature,value)
    value[1]
end

function set_absolute_value(camera::Camera,feature::Feature,value::Cfloat)
    ccall((:dc1394_feature_set_absolute_value,libdc1394),Error,(Ptr{CameraInfo},Feature,Cfloat),camera.handle,feature,value)
end

function get_absolute_control(camera::Camera,feature::Feature)
    pwr=[Switch(ON)]
    ccall((:dc1394_feature_get_absolute_control,libdc1394),Error,(Ptr{CameraInfo},Feature,Ptr{Switch}),camera.handle,feature,pwr)
    pwr[1]
end

function set_absolute_control(camera::Camera,feature::Feature,pwr::Switch)
    ccall((:dc1394_feature_set_absolute_control,libdc1394),Error,(Ptr{CameraInfo},Feature,Switch),camera.handle,feature,pwr)
end

function external_trigger_set_polarity(camera::Camera,polarity::TriggerPolarity)
    ccall((:dc1394_external_trigger_set_polarity,libdc1394),Error,(Ptr{CameraInfo},TriggerPolarity),camera.handle,polarity)
end

function external_trigger_get_polarity(camera::Camera,polarity::Ptr{TriggerPolarity})
    polarity=Array{TriggerPolarity,1}(1)
    ccall((:dc1394_external_trigger_get_polarity,libdc1394),Error,(Ptr{CameraInfo},Ptr{TriggerPolarity}),camera.handle,polarity)
    polarity[1]
end

function external_trigger_has_polarity(camera::Camera)
    polarity_capable=[Bool(FALSE)]
    ccall((:dc1394_external_trigger_has_polarity,libdc1394),Error,(Ptr{CameraInfo},Ptr{Bool}),camera.handle,polarity_capable)
    polarity_capable[1]==TRUE
end

function external_trigger_set_power(camera::Camera,pwr::Switch)
    ccall((:dc1394_external_trigger_set_power,libdc1394),Error,(Ptr{CameraInfo},Switch),camera.handle,pwr)
end

function external_trigger_get_power(camera::Camera)
    pwr=[Switch(OFF)]
    ccall((:dc1394_external_trigger_get_power,libdc1394),Error,(Ptr{CameraInfo},Ptr{Switch}),camera.handle,pwr)
    pwr[1]
end

function external_trigger_set_mode(camera::Camera,mode::TriggerMode)
    ccall((:dc1394_external_trigger_set_mode,libdc1394),Error,(Ptr{CameraInfo},TriggerMode),camera.handle,mode)
end

function external_trigger_get_mode(camera::Camera)
    mode=Array{TriggerMode,1}(1)
    ccall((:dc1394_external_trigger_get_mode,libdc1394),Error,(Ptr{CameraInfo},Ptr{TriggerMode}),camera.handle,mode)
    mode[1]
end

function external_trigger_set_source(camera::Camera,source::TriggerSource)
    ccall((:dc1394_external_trigger_set_source,libdc1394),Error,(Ptr{CameraInfo},TriggerSource),camera.handle,source)
end

function external_trigger_get_source(camera::Camera)
    source=Array{TriggerSource,1}(1)
    ccall((:dc1394_external_trigger_get_source,libdc1394),Error,(Ptr{CameraInfo},Ptr{TriggerSource}),camera.handle,source)
    source[1]
end

function external_trigger_get_supported_sources(camera::Camera)
    sources=Array{dc1394trigger_sources_t,1}(1)
    ccall((:dc1394_external_trigger_get_supported_sources,libdc1394),Error,(Ptr{CameraInfo},Ptr{dc1394trigger_sources_t}),camera.handle,sources)
    sources[1].sources[1:sources[1].num]
end

function software_trigger_set_power(camera::Camera,pwr::Switch)
    ccall((:dc1394_software_trigger_set_power,libdc1394),Error,(Ptr{CameraInfo},Switch),camera.handle,pwr)
end

function software_trigger_get_power(camera::Camera)
    pwr=[Switch(OFF)]
    ccall((:dc1394_software_trigger_get_power,libdc1394),Error,(Ptr{CameraInfo},Ptr{Switch}),camera.handle,pwr)
    pwr[1]
end

function pio_set(camera::Camera,value::Int)
    ccall((:dc1394_pio_set,libdc1394),Error,(Ptr{CameraInfo},UInt32),camera.handle,value)
end

function pio_get(camera::Camera)
    value=[UInt32(0)]
    ccall((:dc1394_pio_get,libdc1394),Error,(Ptr{CameraInfo},Ptr{UInt32}),camera.handle,value)
    Int(value[1])
end

function reset(camera::Camera)
    ccall((:dc1394_camera_reset,libdc1394),Error,(Ptr{CameraInfo},),camera.handle)
end

function set_power(camera::Camera,pwr::Switch)
    ccall((:dc1394_camera_set_power,libdc1394),Error,(Ptr{CameraInfo},Switch),camera.handel,pwr)
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

function capture_setup(camera::Camera,num_dma_buffers::Int=1,flags::CaptureFlags=CAPTURE_FLAGS_DEFAULT)
    ccall((:dc1394_capture_setup,libdc1394),Error,(Ptr{CameraInfo},UInt32,CaptureFlags),camera.handle,num_dma_buffers,flags)
end

function capture_stop(camera::Camera)
    ccall((:dc1394_capture_stop,libdc1394),Error,(Ptr{CameraInfo},),camera.handle)
end

function capture_get_fileno(camera::Camera)
    ccall((:dc1394_capture_get_fileno,libdc1394),Cint,(Ptr{CameraInfo},),camera.handle)
end

function capture_dequeue(camera::Camera,policy::CapturePolicy=CAPTURE_POLICY_WAIT)
    frame=Array{Ptr{dc1394video_frame_t},1}(1)
    ccall((:dc1394_capture_dequeue,libdc1394),
          Error,(Ptr{CameraInfo},CapturePolicy,Ptr{Ptr{dc1394video_frame_t}}),
          camera.handle,policy,frame)
    VideoFrame(frame[1])
end

function capture_enqueue(frame::VideoFrame)
    if frame.handle!=C_NULL
        ccall((:dc1394_capture_enqueue,libdc1394),Error,(Ptr{CameraInfo},Ptr{dc1394video_frame_t}),get_info(frame).camera,frame.handle)
    end
end

function is_corrupt(camera::Camera,frame::VideoFrame)
    val=ccall((:dc1394_capture_is_frame_corrupt,libdc1394),Bool,(Ptr{CameraInfo},Ptr{dc1394video_frame_t}),camera.handle,frame.handle)
    val==TRUE
end

function callback{T}(camera::Camera, user_data::T)
end

function capture_set_callback(callback::Function,camera::Camera)
    global gcallback=callback
    function mycallback{T,N}(c::Ptr{T}, user_data::Ptr{N})
        #ud=unsafe_load(user_data)
        cc=Camera(c)
        gcallback(cc)
        return nothing
    end
    const ccallback = cfunction(mycallback,Void,(Ptr{CameraInfo},Ptr{Void}))
    ccall((:dc1394_capture_set_callback,libdc1394),Void,(Ptr{CameraInfo},Ptr{Void},Ptr{Void}),camera.handle,ccallback,C_NULL)
end

function convert_to_YUV422(src::Ptr{UInt8},dest::Ptr{UInt8},width::Int,height::Int,byte_order::Int,source_coding::ColorCoding,bits::Int)
    ccall((:dc1394_convert_to_YUV422,libdc1394),Error,(Ptr{UInt8},Ptr{UInt8},UInt32,UInt32,UInt32,ColorCoding,UInt32),src,dest,width,height,byte_order,source_coding,bits)
end

function convert_to_MONO8(src::Ptr{UInt8},dest::Ptr{UInt8},width::Int,height::Int,byte_order::Int,source_coding::ColorCoding,bits::Int)
    ccall((:dc1394_convert_to_MONO8,libdc1394),Error,(Ptr{UInt8},Ptr{UInt8},UInt32,UInt32,UInt32,ColorCoding,UInt32),src,dest,width,height,byte_order,source_coding,bits)
end

function convert_to_RGB8(src::Ptr{UInt8},dest::Ptr{UInt8},width::Int,height::Int,byte_order::Int,source_coding::ColorCoding,bits::Int)
    ccall((:dc1394_convert_to_RGB8,libdc1394),Error,(Ptr{UInt8},Ptr{UInt8},UInt32,UInt32,UInt32,ColorCoding,UInt32),src,dest,width,height,byte_order,source_coding,bits)
end

function deinterlace_stereo(src::Ptr{UInt8},dest::Ptr{UInt8},width::Int,height::Int)
    ccall((:dc1394_deinterlace_stereo,libdc1394),Error,(Ptr{UInt8},Ptr{UInt8},UInt32,UInt32),src,dest,width,height)
end

function bayer_decoding_8bit(bayer::Ptr{UInt8},rgb::Ptr{UInt8},width::Int,height::Int,tile::ColorFilter,method::BayerMethod)
    ccall((:dc1394_bayer_decoding_8bit,libdc1394),Error,(Ptr{UInt8},Ptr{UInt8},UInt32,UInt32,ColorFilter,BayerMethod),bayer,rgb,width,height,tile,method)
end

function bayer_decoding_16bit(bayer::Ptr{UInt16},rgb::Ptr{UInt16},width::Int,height::Int,tile::ColorFilter,method::BayerMethod,bits::Int)
    ccall((:dc1394_bayer_decoding_16bit,libdc1394),Error,(Ptr{UInt16},Ptr{UInt16},UInt32,UInt32,ColorFilter,BayerMethod,UInt32),bayer,rgb,width,height,tile,method,bits)
end

function convert_frames(_in::VideoFrame,out::VideoFrame)
    ccall((:dc1394_convert_frames,libdc1394),Error,(Ptr{dc1394video_frame_t},Ptr{dc1394video_frame_t}),_in.handle,out.handle)
end

function debayer(_in::VideoFrame,out::VideoFrame,method::BayerMethod)
    ptr::Ptr{dc1394video_frame_t}=out.handle
    if ptr==C_NULL
        ptr=Ptr{dc1394video_frame_t}(Libc.calloc(1,sizeof(dc1394video_frame_t)))
    end
    err=ccall((:dc1394_debayer_frames,libdc1394),Error,(Ptr{dc1394video_frame_t},Ptr{dc1394video_frame_t},BayerMethod),_in.handle,ptr,method)
    VideoFrame(ptr)
end
debayer(_in::VideoFrame,method::BayerMethod)=debayer(_in,VideoFrame(C_NULL),method)

function get_info(vf::VideoFrame)
    unsafe_load(vf.handle)
end
function get_image(vf::VideoFrame)
    frame=get_info(vf)
    imp=pointer_to_array(frame.image,frame.image_bytes)
    bpp=Int(div(frame.image_bytes,frame.size[1]*frame.size[2]))
    if bpp==1
        return reshape(imp,Int(frame.size[1]),Int(frame.size[2]))
    else
        return reshape(imp,bpp,Int(frame.size[1]),Int(frame.size[2]))
    end
end
convert(::Array{UInt8},vf::VideoFrame)=get_data(vf)

function deinterlace_stereo_frames(_in::Ptr{dc1394video_frame_t},out::Ptr{dc1394video_frame_t},method::StereoMethod)
    ccall((:dc1394_deinterlace_stereo_frames,libdc1394),Error,(Ptr{dc1394video_frame_t},Ptr{dc1394video_frame_t},StereoMethod),_in,out,method)
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

function iso_set_persist(camera::Camera)
    ccall((:dc1394_iso_set_persist,libdc1394),Error,(Ptr{CameraInfo},),camera.handle)
end

function iso_allocate_channel(camera::Camera,channels_allowed::UInt64)
    channel=[Cint(0)]
    ccall((:dc1394_iso_allocate_channel,libdc1394),Error,(Ptr{CameraInfo},UInt64,Ptr{Cint}),camera.handle,channels_allowed,channel)
    channel[1]
end

function iso_release_channel(camera::Camera,channel::Cint)
    ccall((:dc1394_iso_release_channel,libdc1394),Error,(Ptr{CameraInfo},Cint),camera.handle,channel)
end

function iso_allocate_bandwidth(camera::Camera,bandwidth_units::Cint)
    ccall((:dc1394_iso_allocate_bandwidth,libdc1394),Error,(Ptr{CameraInfo},Cint),camera.handle,bandwidth_units)
end

function iso_release_bandwidth(camera::Camera,bandwidth_units::Cint)
    ccall((:dc1394_iso_release_bandwidth,libdc1394),Error,(Ptr{CameraInfo},Cint),camera.handle,bandwidth_units)
end

function iso_release_all(camera::Camera)
    ccall((:dc1394_iso_release_all,libdc1394),Error,(Ptr{CameraInfo},),camera.handle)
end

function get_registers(camera::Camera,offset::UInt64,num_regs::Int)
    value=Array{UInt32,1}(num_regs)
    ccall((:dc1394_get_registers,libdc1394),Error,(Ptr{CameraInfo},UInt64,Ptr{UInt32},UInt32),camera.handle,offset,value,num_regs)
    value
end

function get_register(camera::Camera,offset::UInt64)
    value=[UInt32(0)]
    ccall((:dc1394_get_register,libdc1394),Error,(Ptr{CameraInfo},UInt64,Ptr{UInt32}),camera.handle,offset,value)
    value[1]
end

function set_registers(camera::Camera,offset::UInt64,value::Array{UInt32,1})
    num_regs=UInt32(size(value,1))
    ccall((:dc1394_set_registers,libdc1394),Error,(Ptr{CameraInfo},UInt64,Ptr{UInt32},UInt32),camera.handle,offset,value,num_regs)
end

function set_register(camera::Camera,offset::UInt64,value::Int)
    ccall((:dc1394_set_register,libdc1394),Error,(Ptr{CameraInfo},UInt64,UInt32),camera.handle,offset,value)
end

function get_control_registers(camera::Camera,offset::UInt64,num_regs::Int)
    value=Array{UInt32,1}(num_regs)
    ccall((:dc1394_get_control_registers,libdc1394),Error,(Ptr{CameraInfo},UInt64,Ptr{UInt32},UInt32),camera.handle,offset,value,num_regs)
    value
end

function get_control_register(camera::Camera,offset::UInt64)
    value=[UInt32(0)]
    ccall((:dc1394_get_control_register,libdc1394),Error,(Ptr{CameraInfo},UInt64,Ptr{UInt32}),camera.handle,offset,value)
    value[1]
end

function set_control_registers(camera::Camera,offset::UInt64,value::Array{UInt32,1})
    num_regs=UInt32(size(value,1))
    ccall((:dc1394_set_control_registers,libdc1394),Error,(Ptr{CameraInfo},UInt64,Ptr{UInt32},UInt32),camera.handle,offset,value,num_regs)
end

function set_control_register(camera::Camera,offset::UInt64,value::Int)
    ccall((:dc1394_set_control_register,libdc1394),Error,(Ptr{CameraInfo},UInt64,UInt32),camera.handle,offset,value)
end

function get_adv_control_registers(camera::Camera,offset::UInt64,num_regs::Int)
    value=Array{UInt32,1}(num_regs)
    ccall((:dc1394_get_adv_control_registers,libdc1394),Error,(Ptr{CameraInfo},UInt64,Ptr{UInt32},UInt32),camera.handle,offset,value,num_regs)
    value
end

function get_adv_control_register(camera::Camera,offset::UInt64)
    value=[UInt32(0)]
    ccall((:dc1394_get_adv_control_register,libdc1394),Error,(Ptr{CameraInfo},UInt64,Ptr{UInt32}),camera.value,offset,value)
    value[1]
end

function set_adv_control_registers(camera::Camera,offset::UInt64,value::Array{UInt32,1})
    num_regs=UInt32(size(value,1))
    ccall((:dc1394_set_adv_control_registers,libdc1394),Error,(Ptr{CameraInfo},UInt64,Ptr{UInt32},UInt32),camera.handle,offset,value,num_regs)
end

function set_adv_control_register(camera::Camera,offset::UInt64,value::Int)
    ccall((:dc1394_set_adv_control_register,libdc1394),Error,(Ptr{CameraInfo},UInt64,UInt32),camera.handle,offset,value)
end

function get_format7_register(camera::Camera,mode::Int,offset::UInt64)
    value=[UInt32(0)]
    ccall((:dc1394_get_format7_register,libdc1394),Error,(Ptr{CameraInfo},UInt32,UInt64,Ptr{UInt32}),camera.handle,mode,offset,value)
    value[1]
end

function set_format7_register(camera::Camera,mode::Int,offset::UInt64,value::Int)
    ccall((:dc1394_set_format7_register,libdc1394),Error,(Ptr{CameraInfo},UInt32,UInt64,UInt32),camera.handle,mode,offset,value)
end

function get_absolute_register(camera::Camera,feature::Int,offset::UInt64)
    value=[UInt32(0)]
    ccall((:dc1394_get_absolute_register,libdc1394),Error,(Ptr{CameraInfo},UInt32,UInt64,Ptr{UInt32}),camera.handle,feature,offset,value)
    value[1]
end

function set_absolute_register(camera::Camera,feature::Int,offset::UInt64,value::Int)
    ccall((:dc1394_set_absolute_register,libdc1394),Error,(Ptr{CameraInfo},UInt32,UInt64,UInt32),camera.handle,feature,offset,value)
end

function get_PIO_register(camera::Camera,offset::UInt64)
    value=[UInt32(0)]
    ccall((:dc1394_get_PIO_register,libdc1394),Error,(Ptr{CameraInfo},UInt64,Ptr{UInt32}),camera.handle,offset,value)
    value[1]
end

function set_PIO_register(camera::Camera,offset::UInt64,value::Int)
    ccall((:dc1394_set_PIO_register,libdc1394),Error,(Ptr{CameraInfo},UInt64,UInt32),camera.handle,offset,value)
end

function get_SIO_register(camera::Camera,offset::UInt64)
    value=[UInt32(0)]
    ccall((:dc1394_get_SIO_register,libdc1394),Error,(Ptr{CameraInfo},UInt64,Ptr{UInt32}),camera.handle,offset,value)
    value[1]
end

function set_SIO_register(camera::Camera,offset::UInt64,value::Int)
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

function get_image_size(camera::Camera,video_mode::Int)
    width=Array{UInt32,1}(1)
    height=Array{UInt32,1}(1)
    ccall((:dc1394_get_image_size_from_video_mode,libdc1394),Error,(Ptr{CameraInfo},UInt32,Ptr{UInt32},Ptr{UInt32}),
          camera.handle,video_mode,width,height)
    (width[1],height[1])
end

function framerate_as_float(framerate_enum::Framerate)
    framerate=[Cfloat(0)]
    ccall((:dc1394_framerate_as_float,libdc1394),Error,(Framerate,Ptr{Cfloat}),framerate_enum,framerate)
    framerate[1]
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

function is_same(id1::CameraId,id2::CameraId)
    val=ccall((:dc1394_is_same_camera,libdc1394),Bool,(CameraId,CameraId),id1,id2)
    val==TRUE
end

function get_string(feature::Feature)
    ptr=ccall((:dc1394_feature_get_string,libdc1394),Ptr{UInt8},(Feature,),feature)
    bytestring(ptr)
end

function get_string(error::Error)
    ptr=ccall((:dc1394_error_get_string,libdc1394),Ptr{UInt8},(Error,),error)
    bytestring(ptr)
end

function checksum_crc16(buffer::Ptr{UInt8},buffer_size::Int)
    ccall((:dc1394_checksum_crc16,libdc1394),UInt16,(Ptr{UInt8},UInt32),buffer,buffer_size)
end
Base.convert(::Type{AbstractArray},vf::DC1394.VideoFrame)=get_image(vf)
Base.convert(::Type{Array},vf::DC1394.VideoFrame)=get_image(vf)
Base.convert(::Type{Camera},vf::DC1394.VideoFrame)=Camera(get_info(vf).camera)
