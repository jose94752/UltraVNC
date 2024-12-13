# FindLibjpegTurbo.cmake
set(CONAN_LIBJPEG_TURBO_ROOT "C:/Users/jpluq/.conan2/p/libjpeb71ad852bc04/p")  # Replace with the correct path of the libjpeg-turbo conan install on your computer "C:/path/to/libjpeg-turbo"

# Find the libjpeg-turbo library
#find_library(LIBJPEG_TURBO_LIBRARIES NAMES jpeg-turbo PATHS "${CONAN_LIBJPEG_TURBO_ROOT}/lib") 				# Patch for update to existing names for libjpeg-turbo
find_library(LIBJPEG_TURBO_LIBRARIES NAMES jpeg-static turbojpeg-static PATHS "${LIBJPEG_TURBO_ROOT}/lib")		#	on conan

# Find header files
#find_path(LIBJPEG_TURBO_INCLUDE_DIRS NAMES jpeglib.h PATHS "${CONAN_LIBJPEG_TURBO_ROOT}/include")				# Patch for update to existing names for libjpeg-turbo
find_path(LIBJPEG_TURBO_INCLUDE_DIRS NAMES jpeglib.h PATHS "${LIBJPEG_TURBO_ROOT}/include")						#	on conan

# Debugging : Show paths for validate them
message(STATUS "Libjpeg-turbo libraries found: ${LIBJPEG_TURBO_LIBRARIES}")
message(STATUS "Libjpeg-turbo include dirs found: ${LIBJPEG_TURBO_INCLUDE_DIRS}")

# Check that everything is found
if (NOT LIBJPEG_TURBO_LIBRARIES OR NOT LIBJPEG_TURBO_INCLUDE_DIRS)
    message(FATAL_ERROR "Could not find libjpeg-turbo with adjusted paths")
endif()

# Export found variables
set(LIBJPEG_TURBO_FOUND TRUE)
mark_as_advanced(LIBJPEG_TURBO_LIBRARIES LIBJPEG_TURBO_INCLUDE_DIRS)

include_directories(${LIBJPEG_TURBO_INCLUDE_DIRS})
target_link_libraries(${PROJECT_NAME} ${LIBJPEG_TURBO_LIBRARIES})