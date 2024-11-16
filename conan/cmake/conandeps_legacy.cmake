message(STATUS "Conan: Using CMakeDeps conandeps_legacy.cmake aggregator via include()")
message(STATUS "Conan: It is recommended to use explicit find_package() per dependency instead")

find_package(libjpeg-turbo)
find_package(libsodium)
find_package(LibLZMA)
find_package(ZLIB)
find_package(zstd)

set(CONANDEPS_LEGACY  libjpeg-turbo::libjpeg-turbo  libsodium::libsodium  LibLZMA::LibLZMA  ZLIB::ZLIB  zstd::libzstd_static )