find_library(ZSTD_LIBRARIES zstd PATHS "${CONAN_ZSTD_ROOT}/lib")
find_path(ZSTD_INCLUDE_DIRS "zstd.h" PATHS "${CONAN_ZSTD_ROOT}/include")