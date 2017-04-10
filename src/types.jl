function convert{T<:Enum}(::Type{T},str::AbstractString)
    ins=instances(T)
    i=findfirst(i->"$i"==str,ins)
    if i>0
        ins[i]
    else
        nothing
    end
end
convert{T<:Enum}(::Type{AbstractString},enumvalue::T)="$enumvalue"
convert(::Type{AbstractString},cs::Cstring)=unsafe_string(cs)
show(io::IO,cs::Cstring)=print(io,AbstractString(cs))

"""
enum dc1394color_filter_t
"""
@enum(dc1394color_filter_t,
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
@enum(dc1394byte_order_t,
      BYTE_ORDER_UYVY = (UInt32)(800),
      BYTE_ORDER_YUYV = (UInt32)(801))

const BYTE_ORDER_MIN = BYTE_ORDER_UYVY
const BYTE_ORDER_MAX = BYTE_ORDER_YUYV
const BYTE_ORDER_NUM = (Int(BYTE_ORDER_MAX) - Int(BYTE_ORDER_MIN)) + 1

"""
enum dc1394error_t
"""
@enum(dc1394error_t,
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

# begin enum dc1394bool_t
@enum(dc1394bool_t,
      FALSE = (UInt32)(0),
      TRUE = (UInt32)(1))
# end enum dc1394bool_t

# begin enum dc1394switch_t
@enum(dc1394switch_t,
      OFF = (UInt32)(0),
      ON = (UInt32)(1))
# end enum dc1394switch_t
