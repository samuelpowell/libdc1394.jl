module DC1394
using Compat
import Base: convert, show, string
include("../deps/deps.jl")

typealias dc1394_t Void
function __init__()
    global const dc1394=unsafe_wrap(Array, ccall((:dc1394_new,libdc1394),Ptr{dc1394_t},()), 1)
    finalizer(dc1394,dc->begin
              println("finalize dc1394_t")
              ccall((:dc1394_free,libdc1394),Void,(Ptr{dc1394_t},),dc1394)
              end
              )
end
include("types.jl")
include("camera.jl")
include("trigger.jl")
include("feature.jl")
include("video.jl")
include("format7.jl")
include("capture.jl")
include("convertions.jl")
include("utils.jl")
end
