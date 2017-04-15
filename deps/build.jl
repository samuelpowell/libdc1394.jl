using BinDeps
using Compat

@BinDeps.setup

libdc1394 = library_dependency("libdc1394")
libSDL = library_dependency("libSDL", aliases = ["libSDL", "SDL"])

const version = "2.2.4"

@static if is_apple()
	if Pkg.installed("Homebrew") === nothing
		error("Hombrew package not installed, please run Pkg.add(\"Homebrew\")")
	end
	using Homebrew
	provides(Homebrew.HB, "sdl", libSDL, os = :Darwin)
end

@static if is_linux()
    provides(AptGet, "libsdl1.2-dev", libSDL, os = :Linux)
		provides(AptGet, "libdc1394-22", libdc1394, os = :Linux)
	  provides(Yum, "SDL-devel", libSDL, os = :Linux)
		provides(Yum, "libdc1394", libdc1394, os = :Linux)
end

@static if is_windows()
	using WinRPM
	provides(WinRPM.RPM, "libSDL", libSDL, os = :Windows)
end

provides(Sources,
	URI("http://sourceforge.net/projects/libdc1394/files/libdc1394-2/$(version)/libdc1394-$(version).tar.gz"),
	libdc1394,
	unpacked_dir="libdc1394-$(version)")

prefix = joinpath(BinDeps.depsdir(libdc1394), "usr")
srcdir = joinpath(BinDeps.depsdir(libdc1394), "src", "libdc1394-$(version)")

provides(BuildProcess,Autotools(libtarget = "dc1394/.libs/libdc1394.la",include_dirs=[srcdir,joinpath(srcdir,"dc1394")],env = @compat Dict("CC" => "clang") ),libdc1394)


@BinDeps.install Dict(:libdc1394 => :libdc1394, :libSDL => :libSDL)
