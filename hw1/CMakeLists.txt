cmake_minimum_required(VERSION 2.9)

project(hw1)
add_compile_options(-std=c++11)
include_directories("/usr/include/eigen3")
find_package(Sophus REQUIRED)
include_directories(${Sophus_INCLUDE_DIRS})
add_executable(R_Quaternion src/R_Quaternion.cpp)
target_link_libraries(R_Quaternion ${Sophus_LIBRARIES})
