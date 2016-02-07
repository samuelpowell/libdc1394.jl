module DC1394
using Compat
import Base: convert, show
include("../deps/deps.jl")
include("libdc1394.jl")
end
