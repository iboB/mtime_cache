cmake_minimum_required(VERSION 2.8.7)

project(mtime_cache_demo)

if(NOT MSVC)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} --std=c++0x")
endif()

add_executable(mtime_cache_demo
    src/src1.cpp
    src/src2.cpp
    src/src3.cpp
	src/header.hpp
)
