convert(::Type{AbstractString},cs::Cstring)=bytestring(cs)
show(io::IO,cs::Cstring)=print(io,AbstractString(cs))




"""
enum dc1394color_filter_t
"""
@enum(ColorFilter,
      COLOR_FILTER_RGGB = (UInt32)(512),
      COLOR_FILTER_GBRG = (UInt32)(513),
      COLOR_FILTER_GRBG = (UInt32)(514),
      COLOR_FILTER_BGGR = (UInt32)(515))

const COLOR_FILTER_MIN = COLOR_FILTER_RGGB
const COLOR_FILTER_MAX = COLOR_FILTER_BGGR
const COLOR_FILTER_NUM = (Int(COLOR_FILTER_MAX) - Int(COLOR_FILTER_MIN)) + 1

"""
enum dc1394byte_order_t
"""
@enum(ByteOrder,
      BYTE_ORDER_UYVY = (UInt32)(800),
      BYTE_ORDER_YUYV = (UInt32)(801))

const BYTE_ORDER_MIN = BYTE_ORDER_UYVY
const BYTE_ORDER_MAX = BYTE_ORDER_YUYV
const BYTE_ORDER_NUM = (Int(BYTE_ORDER_MAX) - Int(BYTE_ORDER_MIN)) + 1

"""
enum dc1394error_t
"""
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


const ERROR_MIN = BASLER_UNKNOWN_SFF_CHUNK
const ERROR_MAX = SUCCESS
const ERROR_NUM = (Int(ERROR_MAX) - Int(ERROR_MIN)) + 1

"""
enum dc1394iidc_version_t
"""
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

const IIDC_VERSION_MIN = IIDC_VERSION_1_04
const IIDC_VERSION_MAX = IIDC_VERSION_1_39
const IIDC_VERSION_NUM = (Int(IIDC_VERSION_MAX) - Int(IIDC_VERSION_MIN)) + 1

"""
enum dc1394power_class_t
"""
@enum(PowerClass,
      POWER_CLASS_NONE = (UInt32)(608),
      POWER_CLASS_PROV_MIN_15W = (UInt32)(609),
      POWER_CLASS_PROV_MIN_30W = (UInt32)(610),
      POWER_CLASS_PROV_MIN_45W = (UInt32)(611),
      POWER_CLASS_USES_MAX_1W = (UInt32)(612),
      POWER_CLASS_USES_MAX_3W = (UInt32)(613),
      POWER_CLASS_USES_MAX_6W = (UInt32)(614),
      POWER_CLASS_USES_MAX_10W = (UInt32)(615))

const POWER_CLASS_MIN = POWER_CLASS_NONE
const POWER_CLASS_MAX = POWER_CLASS_USES_MAX_10W
const POWER_CLASS_NUM = (Int(POWER_CLASS_MAX) - Int(POWER_CLASS_MIN)) + 1

"""
enum dc1394phy_delay_t
"""
@enum(PhyDelay,
      PHY_DELAY_MAX_144_NS = (UInt32)(640),
      PHY_DELAY_UNKNOWN_0 = (UInt32)(641),
      PHY_DELAY_UNKNOWN_1 = (UInt32)(642),
      PHY_DELAY_UNKNOWN_2 = (UInt32)(643))

const PHY_DELAY_MIN = PHY_DELAY_MAX_144_NS
const PHY_DELAY_MAX = PHY_DELAY_UNKNOWN_0
const PHY_DELAY_NUM = (Int(PHY_DELAY_MAX) - Int(PHY_DELAY_MIN)) + 1


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

immutable dc1394framerates_t
    num::UInt32
    framerates::NTuple{8,Framerate}
    dc1394framerates_t()=new(0,ntuple(i->FRAMERATE_MIN,8))
end
show(io::IO,fm::dc1394framerates_t)=0<fm.num<8? show(io,fm.framerates[1:fm.num]):()
function convert(::Type{Float32},framerate_enum::Framerate)
    framerate=[Cfloat(0)]
    ccall((:dc1394_framerate_as_float,libdc1394),Error,(Framerate,Ptr{Cfloat}),framerate_enum,framerate)
    Float32(framerate[1])
end

# begin enum dc1394operation_mode_t
@enum(OperationMode,
      OPERATION_MODE_LEGACY = (UInt32)(480),
      OPERATION_MODE_1394B = (UInt32)(481))
# end enum OperationMode

const OPERATION_MODE_MIN = OPERATION_MODE_LEGACY
const OPERATION_MODE_MAX = OPERATION_MODE_1394B
const OPERATION_MODE_NUM = (Int(OPERATION_MODE_MAX) - Int(OPERATION_MODE_MIN)) + 1

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

