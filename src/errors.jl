# DC1394.jl: interface to the libDC1394 library
# Copyright (c) 2016 tkato
# Copyright (C) 2017 Samuel Powell

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

"""
enum dc1394log_t
"""
@enum(dc1394log_t,
      LOG_ERROR = (UInt32)(768),
      LOG_WARNING = (UInt32)(769),
      LOG_DEBUG = (UInt32)(770))

const LOG_MIN = LOG_ERROR
const LOG_MAX = LOG_DEBUG
const LOG_NUM = (Int(LOG_MAX) - Int(LOG_MIN)) + 1

function register_handler(_type::dc1394log_t,log_handler::Ptr{Void},user::Ptr{Void})
  @dcassert ccall((:dc1394_log_register_handler,libdc1394),
    dc1394error_t,
    (dc1394log_t,Ptr{Void},Ptr{Void}),
    _type,log_handler,user)
end

function set_default_handler(_type::dc1394log_t)
  @dcassert ccall((:dc1394_log_set_default_handler,libdc1394),
    dc1394error_t,
    (dc1394log_t,),
    _type)
end
