# DC1394.jl: interface to the libDC1394 library
# Copyright (c) 2016 tkato
# Copyright (C) 2017 Samuel Powell

module DC1394

using Compat

import Base: convert, show, string, unsafe_convert

include("../deps/deps.jl")

typealias dc1394_t Void

type Context
  ptr::Ptr{dc1394_t}
end

unsafe_convert(::Type{Ptr{Void}}, context::DC1394.Context) = context.ptr

function __init__()
  global const dc1394 = dc1394_new()
  finalizer(dc1394, dc1394_free)
end

function dc1394_new()
  context = Context(ccall((:dc1394_new,libdc1394),Ptr{dc1394_t},()))
  context == C_NULL && error("Context creation returned null pointer.")
  return context
end

function dc1394_free(context::Context)
  println("Freeing DC1394 global context")
  context == C_NULL && error("Attempt to free context null pointer.")
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
