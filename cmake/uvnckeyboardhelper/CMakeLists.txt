
project(uvnckeyboardhelper LANGUAGES CXX RC)

set(${PROJECT_NAME}_SOURCES
    uvnckeyboardhelper.cpp
)
add_executable(${PROJECT_NAME} WIN32)
foreach(file ${${PROJECT_NAME}_SOURCES})
    target_sources(${PROJECT_NAME} PRIVATE "${CMAKE_SOURCE_DIR}/../uvnckeyboardhelper/uvnckeyboardhelper/${file}")
endforeach(file)
target_sources(${PROJECT_NAME} PRIVATE "${CMAKE_SOURCE_DIR}/../uvnckeyboardhelper/uvnckeyboardhelper/uvnckeyboardhelper.rc")
set_source_files_properties(${CMAKE_SOURCE_DIR}/../uvnckeyboardhelper/uvnckeyboardhelper/uvnckeyboardhelper.rc LANGUAGE RC)
install(TARGETS ${PROJECT_NAME} RUNTIME DESTINATION ${CMAKE_BINARY_DIR}/ultravnc)
if (MSVC)
    install(FILES $<TARGET_PDB_FILE:${PROJECT_NAME}> DESTINATION ${CMAKE_BINARY_DIR}/ultravnc OPTIONAL)
endif()
