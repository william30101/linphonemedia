############################################################################
# CMakeLists.txt
# Copyright (C) 2014  Belledonne Communications, Grenoble France
#
############################################################################
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
#
############################################################################

cmake_minimum_required(VERSION 3.0)
project(BELLESIP C CXX)


set(PACKAGE "belle-sip")
set(PACKAGE_NAME "${PACKAGE}")
set(PACKAGE_VERSION "1.4.1")
set(PACKAGE_STRING "${PACKAGE_NAME} ${PACKAGE_VERSION}")
set(PACKAGE_BUGREPORT "jehan.monnier@linphone.org")
set(PACKAGE_TARNAME "belle-sip")
set(PACKAGE_URL "")
set(VERSION "${PACKAGE_VERSION}")


option(ENABLE_SERVER_SOCKETS "Enable server sockets" ON)
option(ENABLE_STATIC "Build static library (default is shared library)." OFF)
option(ENABLE_TLS "Enable TLS support" ON)
option(ENABLE_TUNNEL "Enable tunnel support" OFF)
option(ENABLE_TESTS "Enable compilation of tests" ON)


include(CheckLibraryExists)
include(CheckSymbolExists)
include(CheckCSourceCompiles)
include(CMakePushCheckState)

set(MSVC_INCLUDE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/include/MSVC")
if(MSVC)
	list(APPEND CMAKE_REQUIRED_INCLUDES ${MSVC_INCLUDE_DIR})
endif()
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

check_library_exists("dl" "dlopen" "" HAVE_LIBDL)
check_library_exists("rt" "clock_gettime" "" HAVE_LIBRT)

cmake_push_check_state(RESET)
check_symbol_exists("res_ndestroy" "resolv.h" HAVE_RES_NDESTROY)
set(CMAKE_REQUIRED_LIBRARIES resolv)
check_c_source_compiles("#include <resolv.h>
int main(int argc, char *argv[]) {
res_getservers(NULL,NULL,0);
return 0;
}"
	HAVE_RES_GETSERVERS)
if(HAVE_RES_NDESTROY AND HAVE_RES_GETSERVERS)
	set(HAVE_RESINIT 1)
endif()
cmake_pop_check_state()

find_package(Threads)

find_package(Antlr3 REQUIRED)
cmake_push_check_state(RESET)
set(CMAKE_REQUIRED_INCLUDES ${ANTLR3C_INCLUDE_DIRS})
set(CMAKE_REQUIRED_LIBRARIES ${ANTLR3C_LIBRARIES})
check_symbol_exists("antlr3StringStreamNew" "antlr3.h" HAVE_ANTLR_STRING_STREAM_NEW)
cmake_pop_check_state()

if(ENABLE_TLS)
	find_package(PolarSSL REQUIRED)
	if(POLARSSL_FOUND)
		set(HAVE_POLARSSL 1)
	endif()
endif()
if(ENABLE_TUNNEL)
	find_package(Tunnel)
	if(TUNNEL_FOUND)
		set(HAVE_TUNNEL 1)
	else()
		message(WARNING "Could not find the tunnel library!")
		set(ENABLE_TUNNEL OFF CACHE BOOL "Enable tunnel support" FORCE)
	endif()
endif()
if(ENABLE_TESTS)
	find_package(CUnit)
	if(CUNIT_FOUND)
		check_library_exists(${CUNIT_LIBRARIES} "CU_add_suite" "" HAVE_CU_ADD_SUITE)
		check_library_exists(${CUNIT_LIBRARIES} "CU_get_suite" "" HAVE_CU_GET_SUITE)
		check_library_exists(${CUNIT_LIBRARIES} "CU_curses_run_tests" "" HAVE_CU_CURSES)
	else()
		message(WARNING "Could not find cunit framework, tests will not be compiled.")
		set(ENABLE_TESTS OFF CACHE BOOL "Enable compilation of tests" FORCE)
	endif()
endif()


configure_file(${CMAKE_CURRENT_SOURCE_DIR}/config.h.cmake ${CMAKE_CURRENT_BINARY_DIR}/config.h)


set(prefix ${CMAKE_INSTALL_PREFIX})
set(exec_prefix ${prefix}/bin)
set(libdir ${prefix}/lib)
set(includedir ${prefix}/include)
get_filename_component(antlr3c_library_path "${ANTLR3C_LIBRARIES}" PATH)
set(LIBS_PRIVATE "-L${antlr3c_library_path} -lantlr3c")
if(CUNIT_FOUND)
	set(REQUIRES_PRIVATE "${REQUIRES_PRIVATE} cunit")
endif()
if(HAVE_POLARSSL)
	get_filename_component(polarssl_library_path "${POLARSSL_LIBRARIES}" PATH)
	set(LIBS_PRIVATE "${LIBS_PRIVATE} -L${polarssl_library_path} -lpolarssl")
endif()
if(HAVE_LIBDL)
	set(LIBS_PRIVATE "${LIBS_PRIVATE} -ldl")
endif()
if(HAVE_LIBRT)
	set(LIBS_PRIVATE "${LIBS_PRIVATE} -lrt")
endif()
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/belle-sip.pc.in ${CMAKE_CURRENT_BINARY_DIR}/belle-sip.pc)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/belle-sip.pc DESTINATION lib/pkgconfig)


include_directories(
	include
	src
	${CMAKE_CURRENT_BINARY_DIR}
	${CMAKE_CURRENT_BINARY_DIR}/src
	${POLARSSL_INCLUDE_DIRS}
)
if(TUNNEL_FOUND)
	include_directories(${TUNNEL_INCLUDE_DIRS})
endif()
if(CUNIT_FOUND)
	include_directories(${CUNIT_INCLUDE_DIRS})
endif()
if(MSVC)
	include_directories(${MSVC_INCLUDE_DIR})
endif()

add_definitions(-DHAVE_CONFIG_H)
if(NOT MSVC)
	add_definitions(-Wall -Wno-error=unknown-pragmas)
	if("${CMAKE_C_COMPILER_ID}" STREQUAL "Clang")
		add_definitions(-Werror -Wno-error=unknown-warning-option -Qunused-arguments -Wno-tautological-compare)
	elseif("${CMAKE_C_COMPILER_ID}" STREQUAL "GNU")
		add_definitions(-Werror -Wno-error=pragmas)
	endif()
endif()
set(LINK_FLAGS )
if(APPLE)
	list(APPEND LINK_FLAGS "-framework Foundation")
	if(IOS)
		list(APPEND LINK_FLAGS "-framework CoreFoundation" "-framework CFNetwork" "-framework UIKit")
	endif()
endif()
if(WIN32)
	add_definitions(
		-DBELLESIP_EXPORTS
		-DBELLESIP_INTERNAL_EXPORTS
	)
endif()
if("${CMAKE_SYSTEM_NAME}" STREQUAL "WindowsPhone")
	add_definitions(
		-DHAVE_COMPILER_TLS
		-DUSE_FIXED_NAMESERVERS
	)
endif()


add_subdirectory(include)
add_subdirectory(src)


if(ENABLE_TESTS)
	enable_testing()
	add_subdirectory(tester)
endif()


include(CMakePackageConfigHelpers)
write_basic_package_version_file(
	"${CMAKE_CURRENT_BINARY_DIR}/BelleSIPConfigVersion.cmake"
	VERSION ${PACKAGE_VERSION}
	COMPATIBILITY AnyNewerVersion
)
export(EXPORT BelleSIPTargets
	FILE "${CMAKE_CURRENT_BINARY_DIR}/BelleSIPTargets.cmake"
	NAMESPACE BelledonneCommunications::
)
configure_file(cmake/BelleSIPConfig.cmake.in
	"${CMAKE_CURRENT_BINARY_DIR}/BelleSIPConfig.cmake"
	@ONLY
)

set(ConfigPackageLocation lib/cmake/BelleSIP)
install(EXPORT BelleSIPTargets
	FILE BelleSIPTargets.cmake
	NAMESPACE BelledonneCommunications::
	DESTINATION ${ConfigPackageLocation}
)
install(FILES
	"${CMAKE_CURRENT_BINARY_DIR}/BelleSIPConfig.cmake"
	"${CMAKE_CURRENT_BINARY_DIR}/BelleSIPConfigVersion.cmake"
	DESTINATION ${ConfigPackageLocation}
)
