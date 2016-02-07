using BinDeps
using Compat


@BinDeps.setup

deps = [
	libdc1394 = library_dependency("libdc1394"),
	sdl = library_dependency("libsdl")
	]

const version = "2.2.4"

provides(Sources,
	URI("http://sourceforge.net/projects/libdc1394/files/libdc1394-2/$(version)/libdc1394-$(version).tar.gz"),
	libdc1394,
	unpacked_dir="libdc1394-$(version)")

prefix = joinpath(BinDeps.depsdir(libdc1394), "usr")
srcdir = joinpath(BinDeps.depsdir(libdc1394), "src", "libdc1394-$(version)")

provides(AptGet,
        @compat Dict("libdc1394-22" => libdc1394))
provides(Yum,
        @compat Dict("libdc1394" => libdc1394))

provides(BuildProcess,Autotools(libtarget = "dc1394/.libs/libdc1394.la",include_dirs=[srcdir,joinpath(srcdir,"dc1394")],env = @compat Dict("CC" => "clang") ),libdc1394)

@BinDeps.install Dict(:libdc1394 => :libdc1394)
