cmake_minimum_required(VERSION 3.20)
project(CodeAtlas LANGUAGES CXX)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# tell the mysql connector where openssl is installed
add_library(my_openssl INTERFACE)
target_link_directories(my_openssl INTERFACE
    /opt/homebrew/opt/openssl@3/lib
)
target_link_libraries(my_openssl INTERFACE
    ssl
    crypto
)
add_library(mysql::openssl ALIAS my_openssl)

# locate mysql connector/c++
set(mysql-concpp_DIR
    "/opt/homebrew/opt/mysql-connector-c++"
)
find_package(mysql-concpp REQUIRED)

# build CodeAtlas
add_executable(CodeAtlas core/main.cpp)
target_link_libraries(CodeAtlas PRIVATE
    mysql::concpp
    my_openssl
)
