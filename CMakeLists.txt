cmake_minimum_required(VERSION 2.8)
project(libhangman)
include(ExternalProject)

# Mac OSX config for build
set(CMAKE_MACOSX_RPATH 1)
set(CMAKE_BUILD_TYPE Release)

set(libsocket_PREFIX ${CMAKE_CURRENT_BINARY_DIR}/libsocket)
set(libsocket_SOURCE_DIR ${CMAKE_SOURCE_DIR}/external/libsocket)

ExternalProject_Add(libsocket
    PREFIX ${libsocket_PREFIX}
    GIT_REPOSITORY https://github.com/damorton/libsocket.git

    SOURCE_DIR ${libsocket_SOURCE_DIR}
)

# Include directory for libsocket API
include_directories(${libsocket_SOURCE_DIR}/include)

# Set lib source files
set(SOURCES src/hangman.c)

# Linker options
set(PROJECT_LINK_LIBS libsocket.dylib)
link_directories(${libsocket_SOURCE_DIR}/lib)

#Build the library into the lib folder
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/lib)

# Create shared library
add_library(hangman SHARED ${SOURCES})

# Add dependencies for lib
add_dependencies(hangman libsocket)

# Link dependency library libsocket
target_link_libraries(hangman ${PROJECT_LINK_LIBS})

# Install the library to /usr/local/lib
install(TARGETS hangman DESTINATION lib)
