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
cmake -DCMAKE_INSTALL_PREFIX=$prefix -DCMAKE_TOOLCHAIN_FILE=/opt/$target/$target.toolchain -DENABLE_ACIS=0 -DENABLE_BUILD_SHARED=1 -DENABLE_CGNS=0 -DENABLE_CAIRO=0 -DENABLE_FLTK=0 -DENABLE_GETDP=0 -DENABLE_GMM=0 -DENABLE_GMP=0 -DENABLE_KBIPACK=0 -DENABLE_MATHEX=0 -DENABLE_MED=0 -DENABLE_MPEG_ENCODE=0 -DENABLE_NATIVE_FILE_CHOOSER=0 -DENABLE_ONELAB=0 -DENABLE_ONELAB_METAMODEL=0 -DENABLE_PLUGINS=0 -DENABLE_POST=0 -DENABLE_SOLVER=0
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

