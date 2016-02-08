export convert_frames,debayer,get_info,get_image

get_whitebalance(vf::VideoFrame)=get_shutter(Camera(get_info(vf).camera))
get_shutter(vf::VideoFrame)=get_shutter(Camera(get_info(vf).camera))

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

