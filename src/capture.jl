# libDC1394.jl: interface to the libDC1394 library
# Copyright (c) 2016 tkato
# Copyright (C) 2017 Samuel Powell

export
  get_info,
  get_image,
  capture_setup,
  capture_stop,
  capture_get_fileno,
  capture_dequeue,
  capture_enqueue,
  capture_is_frame_corrupt,
  capture_set_callback

immutable dc1394video_frame_t
  image::Ptr{Cuchar}
  size::NTuple{2,UInt32}
  position::Tuple{UInt32,UInt32}
  color_coding::dc1394color_coding_t
  color_filter::dc1394color_filter_t
  yuv_byte_order::dc1394byte_order_t
  data_depth::UInt32
  stride::UInt32
  video_mode::dc1394video_mode_t
  total_bytes::UInt64
  image_bytes::UInt32
  padding_bytes::UInt32
  packet_size::UInt32
  packets_per_frame::UInt32
  timestamp::UInt64
  frames_behind::UInt32
  camera::Ptr{dc1394camera_info_t}
  id::UInt32
  allocated_image_bytes::UInt64
  little_endian::dc1394bool_t
  data_in_padding::dc1394bool_t

  function dc1394video_frame_t()
    new(0,
        (0,0),
        (0,0),
        COLOR_CODING_MIN,
        COLOR_FILTER_MIN,
        BYTE_ORDER_MIN,
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

end

immutable VideoFrame
  handle::Ptr{dc1394video_frame_t}
end

function get_info(vf::VideoFrame)
  if vf.handle != C_NULL
    return unsafe_load(vf.handle)
  else
    return dc1394video_frame_t()
  end
end

function get_image(vf::VideoFrame)
  frame=get_info(vf)
  imp=unsafe_wrap(Array,frame.image,frame.image_bytes)
  bpp=Int(div(frame.image_bytes,frame.size[1]*frame.size[2]))
  if bpp==1
    return reshape(imp,Int(frame.size[1]),Int(frame.size[2]))
  else
    return reshape(imp,bpp,Int(frame.size[1]),Int(frame.size[2]))
  end
end

convert(::Type{AbstractArray},vf::DC1394.VideoFrame)=get_image(vf)
convert(::Type{Array},vf::DC1394.VideoFrame)=get_image(vf)
convert(::Type{Camera},vf::DC1394.VideoFrame)=Camera(get_info(vf).camera)
show(io::IO,vf::VideoFrame)=show(io,get_info(vf))

@enum(dc1394capture_flags_t,
      CAPTURE_FLAGS_CHANNEL_ALLOC = UInt32(0x00000001),
      CAPTURE_FLAGS_BANDWIDTH_ALLOC = UInt32(0x00000002),
      CAPTURE_FLAGS_DEFAULT = UInt32(0x00000004),
      CAPTURE_FLAGS_AUTO_ISO = UInt32(0x00000008))

# begin enum dc1394capture_policy_t
@enum(dc1394capture_policy_t,
      CAPTURE_POLICY_WAIT = (UInt32)(672),
      CAPTURE_POLICY_POLL = (UInt32)(673))
# end enum dc1394capture_policy_t

const CAPTURE_POLICY_MIN = CAPTURE_POLICY_WAIT
const CAPTURE_POLICY_MAX = CAPTURE_POLICY_POLL
const CAPTURE_POLICY_NUM = (Int(CAPTURE_POLICY_MAX) - Int(CAPTURE_POLICY_MIN)) + 1

function capture_setup(camera::Camera,num_dma_buffers::Int=1,flags::dc1394capture_flags_t=CAPTURE_FLAGS_DEFAULT)
  ccall((:dc1394_capture_setup,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},UInt32,dc1394capture_flags_t),
    camera.handle,num_dma_buffers,flags)
end

function capture_stop(camera::Camera)
  ccall((:dc1394_capture_stop,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},),
    camera.handle)
end

function capture_get_fileno(camera::Camera)
  ccall((:dc1394_capture_get_fileno,libdc1394),
    Cint,
    (Ptr{dc1394camera_info_t},),
    camera.handle)
end

function capture_dequeue(camera::Camera,policy::dc1394capture_policy_t=CAPTURE_POLICY_WAIT)
  frame=Array{Ptr{dc1394video_frame_t},1}(1)
  ccall((:dc1394_capture_dequeue,libdc1394),
    dc1394error_t,
    (Ptr{dc1394camera_info_t},dc1394capture_policy_t,Ptr{Ptr{dc1394video_frame_t}}),
    camera.handle,policy,frame)
  VideoFrame(frame[1])
end

function capture_enqueue(frame::VideoFrame)
  if frame.handle!=C_NULL
    ccall((:dc1394_capture_enqueue,libdc1394),
      dc1394error_t,
      (Ptr{dc1394camera_info_t},Ptr{dc1394video_frame_t}),
      get_info(frame).camera,frame.handle)
  end
end

function capture_is_frame_corrupt(camera::Camera,frame::VideoFrame)
  val=ccall((:dc1394_capture_is_frame_corrupt,libdc1394),
    dc1394bool_t,
    (Ptr{dc1394camera_info_t},Ptr{dc1394video_frame_t}),
    camera.handle,frame.handle)
  val==TRUE
end

function capture_set_callback(camera::Camera,callback::Ptr{Void},data::Ptr{Void})
  ccall((:dc1394_capture_set_callback,libdc1394),
    Void,
    (Ptr{dc1394camera_info_t},Ptr{Void},Ptr{Void}),
    camera.handle,callback,data)
end

function capture_set_callback(callback::Function,camera::Camera)
    global gcallback=callback;
    function mycallback{T,N}(camera::T, data::N)
        global gcallback;
        cc=Camera(camera);
            gcallback(cc)
        nothing
    end
    ccallback=cfunction(mycallback,Void,(Ptr{dc1394camera_info_t},Ptr{Void}))
    ccall((:dc1394_capture_set_callback,libdc1394),
      Void,
      (Ptr{dc1394camera_info_t},Ptr{Void},Ptr{Void}),
      camera.handle,ccallback,C_NULL)
end
