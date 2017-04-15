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
