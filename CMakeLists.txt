cmake_minimum_required(VERSION 2.8)
project(libhangman)
include(ExternalProject)

# Dependencies
# libsocket
set(libsocket_PREFIX ${CMAKE_BINARY_DIR}/libsocket)
set(libsocket_SOURCE_DIR ${CMAKE_SOURCE_DIR}/external/libsocket)

ExternalProject_Add(libsocket
    PREFIX ${libsocket_PREFIX}
    GIT_REPOSITORY https://github.com/damorton/libsocket.git
    INSTALL_COMMAND ""
    SOURCE_DIR ${libsocket_SOURCE_DIR}
)
# Include directory for libsocket API
include_directories(${libsocket_SOURCE_DIR}/include)

# Building libhangman

# Set lib source files
set(SOURCES src/hangman.c)

# Linker options
# Don't mistake osx for unix
if(UNIX AND NOT APPLE)
  set(PROJECT_LINK_LIBS libsocket.so)
else()
  set(PROJECT_LINK_LIBS libsocket.dylib)
endif()

# Build the library into the lib folder
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BUILD_DIR}/lib)

# Create shared library
add_library(hangman SHARED ${SOURCES})

# Add dependencies for lib
add_dependencies(hangman libsocket)

# Link dependency library libsocket
target_link_libraries(hangman ${libsocket_SOURCE_DIR}/lib/${PROJECT_LINK_LIBS})

# Install the library to /usr/local/lib
#install(TARGETS hangman DESTINATION lib)
