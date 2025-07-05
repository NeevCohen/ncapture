set(LIBRARY_NAME snifferLib)
add_library(${LIBRARY_NAME} STATIC
            src/sniffer.cpp
            src/file.cpp
            src/if_utils.cpp)
target_include_directories(${LIBRARY_NAME} PUBLIC include)

add_custom_command(
    OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/$<CONFIG>/xcframeworks/SnifferLib.xcframework
    COMMAND xcodebuild -create-xcframework -library ${CMAKE_CURRENT_BINARY_DIR}/$<CONFIG>/lib${LIBRARY_NAME}.a -headers ${CMAKE_CURRENT_SOURCE_DIR}/include -output ${CMAKE_CURRENT_BINARY_DIR}/$<CONFIG>/xcframeworks/SnifferLib.xcframework
    DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/$<CONFIG>/lib${LIBRARY_NAME}.a
)
add_custom_target(lib_framework_bundle ALL DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/$<CONFIG>/xcframeworks/SnifferLib.xcframework)
add_dependencies(lib_framework_bundle ${LIBRARY_NAME} )