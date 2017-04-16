# DC1394.jl: interface to the libDC1394 library
# Copyright (c) 2016 tkato
# Copyright (C) 2017 Samuel Powell

module DC1394

using Compat

import Base: convert, show, string

include("../deps/deps.jl")

typealias dc1394_t Void

function __init__()
  global const dc1394 = dc1394_new()
  finalizer(dc1394, dc1394_free(dc1394))
end

function dc1394_new()
  context = ccall((:dc1394_new,libdc1394),Ptr{dc1394_t},())
  unsafe_wrap(Array, context, 1)
end

function dc1394_free(context::Array{dc1394_t,1})
  ccall((:dc1394_free,libdc1394),Void,(Ptr{dc1394_t},),context)
end

macro dcassert(ex)
    return :( err = $ex; err == SUCCESS ? nothing : error(string(err)))
end

include("types.jl")
include("errors.jl")
include("camera.jl")
include("trigger.jl")
include("feature.jl")
include("video.jl")
include("format7.jl")
include("capture.jl")
include("conversions.jl")
include("iso.jl")
include("utils.jl")

end
