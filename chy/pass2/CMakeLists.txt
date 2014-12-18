cmake_minimum_required(VERSION 2.8)

project(Pass)

set(CMAKE_INSTALL_PREFIX "${PROJECT_SOURCE_DIR}/..")

find_package(LLVM REQUIRED CONFIG)

add_definitions(${LLVM_DEFINITIONS})
include_directories(${LLVM_INCLUDE_DIRS})

add_subdirectory(BrainF)
