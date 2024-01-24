cmake_minimum_required(VERSION 3.5)
project(BoostPythonHello)

find_package(Python 3 REQUIRED COMPONENTS Development)
find_package(Boost COMPONENTS python REQUIRED)
set(CMAKE_SHARED_MODULE_PREFIX "")

add_library(hello_ext MODULE boost.cc)
target_link_libraries(hello_ext PRIVATE Boost::python Python::Module)