add_executable(ncapture main.cpp)
target_link_libraries(ncapture PRIVATE snifferLib)

add_executable(ncaptureswift main.swift)
target_compile_options(ncaptureswift PRIVATE
  "$<$<COMPILE_LANGUAGE:Swift>:-cxx-interoperability-mode=default>")
target_link_libraries(ncaptureswift PRIVATE snifferLib)