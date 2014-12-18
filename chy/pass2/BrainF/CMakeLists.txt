set(MODULE_NAME BrainF)
set(CMAKE_CXX_FLAGS "-std=c++11")
add_library(brainf MODULE BrainF.cpp BrainFDriver.cpp BrainF.h)
install(TARGETS brainf  DESTINATION .)
