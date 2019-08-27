include_directories(
    ${CMAKE_CURRENT_SOURCE_DIR}/extracted/vm/include/unix
    ${CMAKE_CURRENT_SOURCE_DIR}/extracted/vm/include/common
)

set(EXTRACTED_SOURCES
#Common sources
    ${CMAKE_CURRENT_SOURCE_DIR}/extracted/vm/src/common/sqHeapMap.c
    ${CMAKE_CURRENT_SOURCE_DIR}/extracted/vm/src/common/sqVirtualMachine.c
    ${CMAKE_CURRENT_SOURCE_DIR}/extracted/vm/src/common/sqNamedPrims.c
    ${CMAKE_CURRENT_SOURCE_DIR}/extracted/vm/src/common/sqExternalSemaphores.c
    ${CMAKE_CURRENT_SOURCE_DIR}/extracted/vm/src/common/sqTicker.c

#Platform sources
    ${CMAKE_CURRENT_SOURCE_DIR}/extracted/vm/src/unix/aio.c
    ${CMAKE_CURRENT_SOURCE_DIR}/extracted/vm/src/unix/sqUnixHeartbeat.c
    ${CMAKE_CURRENT_SOURCE_DIR}/src/debugUnix.c

#Virtual Memory functions
    ${CMAKE_CURRENT_SOURCE_DIR}/src/memoryUnix.c
    ${CMAKE_CURRENT_SOURCE_DIR}/src/aioUnix.c
)

set(VM_FRONTEND_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/src/main.c
    ${CMAKE_CURRENT_SOURCE_DIR}/src/parameters.c    
    ${CMAKE_CURRENT_SOURCE_DIR}/src/unixOpenFileDialog.c)


macro(add_third_party_dependencies_per_platform)
    add_third_party_dependency("pthreadedPlugin-0.0.1" "build/vm")
    add_third_party_dependency("libffi-3.3-rc0" "build/vm")
    add_third_party_dependency("libgit2-0.25.1" "build/vm")
    add_third_party_dependency("libssh2-1.7.0" "build/vm")
    add_third_party_dependency("openssl-1.0.2q" "build/vm")
    add_third_party_dependency("SDL2-2.0.7" "build/vm")
endmacro()


macro(configure_installables INSTALL_COMPONENT)
    set(CMAKE_INSTALL_PREFIX "${CMAKE_CURRENT_SOURCE_DIR}/build/dist")

	# Use RPATH so that "libPharoVMCore.so" can be found in current directory
	set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,-rpath='$ORIGIN'")

    install(
      DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/packaging/linux/"
      DESTINATION "./"
      USE_SOURCE_PERMISSIONS
      COMPONENT ${INSTALL_COMPONENT})
    install(
      DIRECTORY "${CMAKE_BINARY_DIR}/build/vm/"
      DESTINATION "lib"
      USE_SOURCE_PERMISSIONS
      COMPONENT ${INSTALL_COMPONENT})
endmacro()

macro(add_required_libs_per_platform)
   target_link_libraries(${VM_EXECUTABLE_NAME} dl)
   target_link_libraries(${VM_EXECUTABLE_NAME} m)
   target_link_libraries(${VM_EXECUTABLE_NAME} pthread)
endmacro()