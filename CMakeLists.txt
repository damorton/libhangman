cmake_minimum_required(VERSION 2.8)
project(libhangman)
include(ExternalProject)

ExternalProject_Add(libsocket
    PREFIX ${CMAKE_BINARY_DIR}/build/libsocket
    GIT_REPOSITORY https://github.com/damorton/libsocket.git
    INSTALL_COMMAND ""
    BINARY_DIR ${CMAKE_BINARY_DIR}/external/libsocket
    SOURCE_DIR ${CMAKE_BINARY_DIR}/external/libsocket
)

set(SOURCES src/hangman.c)

if(UNIX AND NOT APPLE)
  set(PROJECT_LINK_LIBS libsocket.so)
else()
  set(PROJECT_LINK_LIBS libsocket.dylib)
endif()

link_directories(external/libsocket/)

add_library(hangman SHARED ${SOURCES})

add_dependencies(hangman libsocket)

target_link_libraries(hangman ${PROJECT_LINK_LIBS})
