#-------------------------------------------------------------------------------
# Makefile for building the code samples. Read inline comments for
# documentation.
#
# Eli Bendersky (eliben@gmail.com)
# This code is in the public domain
#-------------------------------------------------------------------------------

# The following variables will likely need to be modified, depending on where
# and how you built LLVM & Clang.
# LLVM_SRC_PATH is the path to the root of the checked out source code. This
# directory should contain the configure script, the include/ and lib/
# directories of LLVM, Clang in tools/clang/, etc.
LLVM_SRC_PATH := /ubuntu/chyyuu/develop/llvm-git/src
# LLVM_SRC_PATH = $$HOME/llvm/llvm_svn_rw

# LLVM_BUILD_PATH is the directory in which you built LLVM - where you ran
# configure or cmake.
LLVM_BUILD_PATH = $$HOME/llvm/llvm3.3-binaries
# LLVM_BUILD_PATH = $$HOME/llvm/build/svn-make-debug

# LLVM_BIN_PATH is the directory where binaries are placed by the LLVM build
# process. It should contain the tools like opt, llc and clang. The default
# reflects a debug build with autotools (configure & make).
LLVM_BUILD_PATH := /ubuntu/chyyuu/develop/llvm-git/build
LLVM_INSTALL_PATH := /ubuntu/chyyuu/develop/llvm-git/install
LLVM_BIN_PATH := $(LLVM_INSTALL_PATH)/bin
# LLVM_BIN_PATH = $(LLVM_BUILD_PATH)/Debug+Asserts/bin


# LLVM has two places with include headers: in the source tree and in the
# build tree. The latter contains auto-generated headers that were created
# during the build process. The following setting should work in all cases
# on Linux - let me know if it doesn't.
LLVM_INCLUDES = -I$(LLVM_SRC_PATH)/include -I$(LLVM_BUILD_PATH)/include

# It's recommended that CXX matches the compiler you used to build LLVM itself.
CXX = g++
CXXFLAGS_LLVM = -fno-rtti -O0 $(LLVM_INCLUDES)

LLVM_CONFIG_COMMAND = \
		`$(LLVM_BIN_PATH)/llvm-config --cxxflags --libs` \
		`$(LLVM_BIN_PATH)/llvm-config --ldflags`

# Internal paths in this project: where to find sources, and where to put
# build artifacts.
SRCDIR = src
BUILDDIR = build

all: make_builddir \
	$(BUILDDIR)/bb_toposort_sccs \
	$(BUILDDIR)/simple_bb_pass \
	$(BUILDDIR)/access_debug_metadata

make_builddir:
	@test -d $(BUILDDIR) || mkdir $(BUILDDIR)

$(BUILDDIR)/simple_bb_pass: $(SRCDIR)/simple_bb_pass.cpp
	$(CXX) $(CXXFLAGS_LLVM) $^ $(LLVM_CONFIG_COMMAND) -o $@

$(BUILDDIR)/access_debug_metadata: $(SRCDIR)/access_debug_metadata.cpp
	$(CXX) $(CXXFLAGS_LLVM) $^ $(LLVM_CONFIG_COMMAND) -o $@

$(BUILDDIR)/bb_toposort_sccs: $(SRCDIR)/bb_toposort_sccs.cpp
	$(CXX) $(CXXFLAGS_LLVM) $^ $(LLVM_CONFIG_COMMAND) -o $@

clean:
	rm -rf $(BUILDDIR)/* *.dot test/*.pyc test/__pycache__

