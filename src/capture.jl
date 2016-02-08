export capture_setup,capture_stop,capture_get_fileno,capture_dequeue,capture_enqueue,is_corrupt,capture_set_callback


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
convert(::Type{AbstractArray},vf::DC1394.VideoFrame)=get_image(vf)
convert(::Type{Array},vf::DC1394.VideoFrame)=get_image(vf)
convert(::Type{Camera},vf::DC1394.VideoFrame)=Camera(get_info(vf).camera)
show(io::IO,vf::VideoFrame)=show(io,get_info(vf))

@enum(CaptureFlags,
      CAPTURE_FLAGS_CHANNEL_ALLOC = UInt32(0x00000001),
      CAPTURE_FLAGS_BANDWIDTH_ALLOC = UInt32(0x00000002),
      CAPTURE_FLAGS_DEFAULT = UInt32(0x00000004),
      CAPTURE_FLAGS_AUTO_ISO = UInt32(0x00000008))

# begin enum dc1394capture_policy_t
@enum(CapturePolicy,
      CAPTURE_POLICY_WAIT = (UInt32)(672),
      CAPTURE_POLICY_POLL = (UInt32)(673))
# end enum CapturePolicy

const CAPTURE_POLICY_MIN = CAPTURE_POLICY_WAIT
const CAPTURE_POLICY_MAX = CAPTURE_POLICY_POLL
const CAPTURE_POLICY_NUM = (Int(CAPTURE_POLICY_MAX) - Int(CAPTURE_POLICY_MIN)) + 1

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
