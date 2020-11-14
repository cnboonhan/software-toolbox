cmake_minimum_required(VERSION 3.2)

## Template CMakeLists.txt to be easily modifiable for various builds ##

project(template_cmake)

## Set up build environment ##
if(NOT CMAKE_CXX_STANDARD)
  set(CMAKE_CXX_STANDARD 14)
endif()

if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()

if(NOT CMAKE_BUILD_TYPE)
  # Use the Release build type by default if the user has not specified one
  set(CMAKE_BUILD_TYPE Release)
endif()

include(GNUInstallDirs)

#set(CMAKE_C_COMPILER /path/to/c/compiler)
#set(CMAKE_CXX_COMPILER /path/to/cpp/compiler)
#set(CMAKE_GENERATOR "Unix Makefiles")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O0") # man gcc
set(CMAKE_EXE_LINKER_FLAGS  "${CMAKE_EXE_LINKER_FLAGS}") # https://gcc.gnu.org/onlinedocs/gcc/Link-Options.html
#set(CMAKE_INSTALL_PREFIX "${CMAKE_CURRENT_SOURCE_DIR}/install")
#set(CMAKE_EXECUTABLE_SUFFIX ".html")

## Find external packages ##
include(GNUInstallDirs) # https://cmake.org/cmake/help/v3.0/module/GNUInstallDirs.html
include(FindPkgConfig) # https://cmake.org/cmake/help/latest/module/FindPkgConfig.html

#find_package(lib_ext REQUIRED)
#if(NOT lib_ext_FOUND)
  #message(FATAL_ERROR "lib_ext library not found")
#endif()

## Create executables and libraries ##
#file(GLOB_RECURSE srcs "src/*.cpp")
#add_library(lib_local SHARED ${srcs}) # https://cmake.org/cmake/help/latest/command/add_library.html
#add_executable(exec_local ${srcs}) # https://cmake.org/cmake/help/latest/command/add_executable.html

#target_link_libraries(target_name
  #PUBLIC
    #lib_ext::lib_ext # https://cmake.org/cmake/help/latest/policy/CMP0028.html
    #lib_local
  #PRIVATE
  #${lib_ext_LIBRARIES}
#)

#target_include_directories(target_include
  #PUBLIC
    #$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    #$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
    #${lib_ext_INCLUDE_DIRS}
#)

## Create Package Config for easy import from other projects ##
#include(CMakePackageConfigHelpers) # https://cmake.org/cmake/help/latest/module/CMakePackageConfigHelpers.html

#set(INSTALL_CONFIG_DIR "${CMAKE_INSTALL_LIBDIR}/template_cmake/cmake")
#set(PACKAGE_CONFIG_VERSION_FILE "${CMAKE_CURRENT_BINARY_DIR}/template_cmake-version.cmake")
#set(PACKAGE_CONFIG_FILE "${CMAKE_CURRENT_BINARY_DIR}/template_cmake-config.cmake")

#install(
  #FILES
    #${PACKAGE_CONFIG_VERSION_FILE}
    #${PACKAGE_CONFIG_FILE}
  #DESTINATION ${INSTALL_CONFIG_DIR}
#)

#configure_package_config_file(
  #"${CMAKE_CURRENT_LIST_DIR}/cmake/template_cmake-config.cmake.in"
  #${PACKAGE_CONFIG_FILE}
  #INSTALL_DESTINATION ${INSTALL_CONFIG_DIR}
#)

#write_basic_package_version_file(
  #${PACKAGE_CONFIG_VERSION_FILE}
  #COMPATIBILITY ExactVersion
#)

## Install output of build ##
#https://cmake.org/cmake/help/git-stage/guide/importing-exporting/index.html#exporting-targets
#install( # https://cmake.org/cmake/help/latest/command/install.html
  #TARGETS lib_local
  #EXPORT  lib_local-targets
  #RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
  #LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  #ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
#)

#install(
  #EXPORT lib_local-targets
  #FILE lib_local-targets.cmake
  #NAMESPACE lib_local_pkg::
  #DESTINATION ${INSTALL_CONFIG_DIR}
#)

#install(DIRECTORY misc/ DESTINATION share/${PROJECT_NAME}/misc)
#install(DIRECTORY include/ DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

#export(
  #EXPORT lib_local-targets
  #FILE ${CMAKE_CURRENT_BINARY_DIR}/lib_local-targets.cmake
  #NAMESPACE lib_local::
#)

#export(PACKAGE template_cmake)
