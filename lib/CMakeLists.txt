add_library(snifferLib STATIC
            src/sniffer.cpp
            src/file.cpp
            src/if_utils.cpp)
target_include_directories(snifferLib PUBLIC include)