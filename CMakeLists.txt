cmake_minimum_required(VERSION 3.20)
project(test VERSION 1.0)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_subdirectory(lib/boson)

add_executable(${PROJECT_NAME}
    src/main.cpp
)

target_link_libraries(${PROJECT_NAME} PRIVATE boson)
