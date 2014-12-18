set(MODULE_NAME hello)
set(CMAKE_CXX_FLAGS "-std=c++11")
add_library(hello MODULE Hello.cpp)
install(TARGETS hello DESTINATION .)
