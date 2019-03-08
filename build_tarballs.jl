# Note that this script can accept some limited command-line arguments, run
# `julia build_tarballs.jl --help` to see a usage message.
using BinaryBuilder

name = "GmshBuilder"
version = v"4.2.1"

# Collection of sources required to build GmshBuilder
sources = [
    "http://gmsh.info/src/gmsh-4.2.1-source.tgz" =>
    "1f11481e68900dc256f88aaed18d03e93b416ba01e9e8c3dc3f6d59a211f0561",

]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir/gmsh-4.2.1-source/
cmake -DCMAKE_INSTALL_PREFIX=$prefix -DCMAKE_TOOLCHAIN_FILE=/opt/$target/$target.toolchain -DENABLE_BUILD_SHARED=ON 
make
make install

"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = [
    Linux(:x86_64, libc=:glibc)
]

# The products that we will ensure are always built
products(prefix) = [
    LibraryProduct(prefix, "libgmsh", :libgmsh)
]

# Dependencies that must be installed before this package can be built
dependencies = [
    
]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, name, version, sources, script, platforms, products, dependencies)

