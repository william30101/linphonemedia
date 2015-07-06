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

cmake_minimum_required(VERSION 2.8)
project(SRTP C)


option(ENABLE_STATIC "Build static library (default is shared library)." OFF)
option(ENABLE_KERNEL_LINUX "Build library to run in Linux kernel context." OFF)
option(ENABLE_GENERIC_AESICM "Compile in changes for ISMAcryp." OFF)
option(ENABLE_SYSLOG "Use syslog for error reporting." OFF)
option(ENABLE_STDOUT "Use stdout for error reporting." ON)
option(ENABLE_CONSOLE "Use /dev/console for error reporting." OFF)
option(ENABLE_GDOI "Enable GDOI key management." OFF)
option(ENABLE_TEST_PROGRAMS "Enable compilation of test programs." OFF)


if("${CMAKE_SYSTEM_PROCESSOR}" MATCHES "i*86|x86_64|AMD64")
	set(CPU_CISC 1)
	set(HAVE_X86 1)
else("${CMAKE_SYSTEM_PROCESSOR}" MATCHES "i*86|x86_64|AMD64")
	include(TestBigEndian)
	test_big_endian(WORDS_BIGENDIAN)
	if(${WORDS_BIGENDIAN})
		set(CPU_RISC 1)
	else(${WORDS_BIGENDIAN})
		set(CPU_CISC 1)
	endif(${WORDS_BIGENDIAN})
endif("${CMAKE_SYSTEM_PROCESSOR}" MATCHES "i*86|x86_64|AMD64")

if("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
	set(ENABLE_DEBUGGING 1)
endif("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")

if(${ENABLE_KERNEL_LINUX})
	set(RNG_SOURCE rand_linux_kernel.c)
	set(SRTP_KERNEL 1)
	set(SRTP_KERNEL_LINUX 1)
else(${ENABLE_KERNEL_LINUX})
	set(RNG_SOURCE rand_source.c)
endif(${ENABLE_KERNEL_LINUX})

if(UNIX)
	if(NOT CMAKE_CROSS_COMPILING)
		if(EXISTS "/dev/urandom")
			set(DEV_URANDOM "/dev/urandom")
		else(EXISTS "/dev/urandom")
			if(EXISTS "/dev/random")
				set(DEV_URANDOM "/dev/random")
			endif(EXISTS "/dev/random")
		endif(EXISTS "/dev/urandom")
	endif(NOT CMAKE_CROSS_COMPILING)
endif(UNIX)

set(GENERIC_AESICM ${ENABLE_GENERIC_AESICM})
set(USE_SYSLOG ${ENABLE_SYSLOG})
set(ERR_REPORTING_STDOUT ${ENABLE_STDOUT})
set(USE_ERR_REPORTING_FILE ${ENABLE_CONSOLE})
if(${ENABLE_CONSOLE})
	set(ERR_REPORTING_FILE "/dev/console")
endif(${ENABLE_CONSOLE})
set(SRTP_GDOI ${ENABLE_GDOI})
if(${ENABLE_GDOI})
	set(GDOI_SOURCE gdoi/srtp+gdoi.c)
endif(${ENABLE_GDOI})


include(CheckIncludeFile)
include(CheckLibraryExists)
include(CheckFunctionExists)
include(CheckTypeSize)

check_include_file(stdlib.h HAVE_STDLIB_H)
check_include_file(unistd.h HAVE_UNISTD_H)
check_include_file(byteswap.h HAVE_BYTESWAP_H)
check_include_file(stdint.h HAVE_STDINT_H)
check_include_file(sys/uio.h HAVE_SYS_UIO_H)
check_include_file(inttypes.h HAVE_INTTYPES_H)
check_include_file(sys/types.h HAVE_SYS_TYPES_H)
check_include_file(machine/types.h HAVE_MACHINE_TYPES_H)
check_include_file(sys/int_types.h HAVE_SYS_INT_TYPES_H)
check_include_file(sys/socket.h HAVE_SYS_SOCKET_H)
check_include_file(netinet/in.h HAVE_NETINET_IN_H)
check_include_file(arpa/inet.h HAVE_ARPA_INET_H)
check_include_file(windows.h HAVE_WINDOWS_H)
if(${HAVE_WINDOWS_H})
	check_include_file(winsock2.h HAVE_WINSOCK2_H)
	if(${HAVE_WINSOCK2_H})
		list(APPEND LIBS ws2_32)
	endif(${HAVE_WINSOCK2_H})
endif(${HAVE_WINDOWS_H})
check_include_file(syslog.h HAVE_SYSLOG_H)
check_include_file(memory.h HAVE_MEMORY_H)
check_include_file(strings.h HAVE_STRINGS_H)
check_include_file(string.h HAVE_STRING_H)
check_include_file(sys/stat.h HAVE_SYS_STAT_H)

check_function_exists("socket" HAVE_SOCKET)
check_function_exists("inet_aton" HAVE_INET_ATON)
check_function_exists("usleep" HAVE_USLEEP)
check_function_exists("sigaction" HAVE_SIGACTION)

if(NOT ${HAVE_SOCKET})
	check_library_exists("socket" "socket" "" HAVE_LIBSOCKET)
	set(CMAKE_EXE_LINKER_FLAGS_SAVED ${CMAKE_EXE_LINKER_FLAGS})
	set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -lwsock32 -lws2_32")
	check_c_source_compiles("#include <winsock2.h>
int main(int argc, char *argv[]) {
socket(0, 0, 0);
return 0;
}"
	HAVE_LIBWSOCK32)
	set(CMAKE_EXE_LINKER_FLAGS ${CMAKE_EXE_LINKER_FLAGS_SAVED})
endif(NOT ${HAVE_SOCKET})

set(TYPES_CHECKED int8_t uint8_t int16_t uint16_t int32_t uint32_t uint64_t)
set(CMAKE_EXTRA_INCLUDE_FILES stdint.h)
foreach(TYPE ${TYPES_CHECKED})
	string(TOUPPER ${TYPE} TYPE_SIZE_VAR)
	check_type_size(${TYPE} ${TYPE_SIZE_VAR})
endforeach()
check_type_size("unsigned long" UNSIGNED_LONG)
check_type_size("unsigned long long" UNSIGNED_LONG_LONG)
set(CMAKE_EXTRA_INCLUDE_FILES)
set(SIZEOF_UNSIGNED_LONG ${UNSIGNED_LONG})
set(SIZEOF_UNSIGNED_LONG_LONG ${UNSIGNED_LONG_LONG})

foreach(KEYWORD "inline" "__inline__" "__inline")
	if(NOT DEFINED C_INLINE)
		try_compile(C_HAS_${KEYWORD} "${CMAKE_CURRENT_BINARY_DIR}"
			"${CMAKE_CURRENT_SOURCE_DIR}/test_inline.c"
			COMPILE_DEFINITIONS "-Dinline=${KEYWORD}")
		if(C_HAS_${KEYWORD})
			set(C_INLINE TRUE)
			if(NOT "${KEYWORD}" STREQUAL "inline")
				set(inline ${KEYWORD})
			endif(NOT "${KEYWORD}" STREQUAL "inline")
		endif(C_HAS_${KEYWORD})
	endif(NOT DEFINED C_INLINE)
endforeach(KEYWORD)


configure_file(${CMAKE_CURRENT_SOURCE_DIR}/config.h.cmake ${CMAKE_CURRENT_BINARY_DIR}/config.h)


include_directories(
	include
	crypto/include
	${CMAKE_CURRENT_BINARY_DIR}
)

add_subdirectory(include)
add_subdirectory(crypto/include)


if(MSVC)
	add_definitions("/W3")
else(MSVC)
	add_definitions("-Wall -fexpensive-optimizations -funroll-loops -fPIC")
endif(MSVC)

source_group(ciphers FILES
	crypto/cipher/cipher.c
	crypto/cipher/null_cipher.c
	crypto/cipher/aes.c
	crypto/cipher/aes_icm.c
	crypto/cipher/aes_cbc.c
)

source_group(hashes FILES
	crypto/hash/null_auth.c
	crypto/hash/sha1.c
	crypto/hash/hmac.c
	crypto/hash/auth.c
	# crypto/hash/tmmhv2.c
)

source_group(math FILES
	crypto/math/datatypes.c
	crypto/math/stat.c
)

source_group(kernel FILES
	crypto/kernel/crypto_kernel.c
	crypto/kernel/alloc.c
	crypto/kernel/key.c
	crypto/rng/${RNG_SOURCE}
	crypto/rng/prng.c
	crypto/rng/ctr_prng.c
	crypto/kernel/err.c
	#crypto/ust/ust.c
)

source_group(replay FILES
	crypto/replay/rdb.c
	crypto/replay/rdbx.c
	crypto/replay/ut_sim.c
)

source_group(srtpobj FILES
	srtp/srtp.c
	srtp/ekt.c
)

set(SRTP_SOURCE_FILES
	crypto/cipher/cipher.c
	crypto/cipher/null_cipher.c
	crypto/cipher/aes.c
	crypto/cipher/aes_icm.c
	crypto/cipher/aes_cbc.c
	crypto/hash/null_auth.c
	crypto/hash/sha1.c
	crypto/hash/hmac.c
	crypto/hash/auth.c
	# crypto/hash/tmmhv2.c
	crypto/math/datatypes.c
	crypto/math/stat.c
	crypto/kernel/crypto_kernel.c
	crypto/kernel/alloc.c
	crypto/kernel/key.c
	crypto/rng/${RNG_SOURCE}
	crypto/rng/prng.c
	crypto/rng/ctr_prng.c
	crypto/kernel/err.c
	#crypto/ust/ust.c
	crypto/replay/rdb.c
	crypto/replay/rdbx.c
	crypto/replay/ut_sim.c
	srtp/srtp.c
	srtp/ekt.c
	${GDOI_SOURCE}
	${CMAKE_CURRENT_BINARY_DIR}/config.h
)
if(WIN32)
	list(APPEND SRTP_SOURCE_FILES srtp.def)
endif(WIN32)
set_source_files_properties(${CMAKE_CURRENT_BINARY_DIR}/config.h PROPERTIES GENERATED ON)

if(${ENABLE_STATIC})
	add_library(srtp STATIC ${SRTP_SOURCE_FILES})
	target_link_libraries(srtp ${LIBS})
else(${ENABLE_STATIC})
	add_library(srtp SHARED ${SRTP_SOURCE_FILES})
	set_target_properties(srtp PROPERTIES VERSION 3.4 SOVERSION 1)
	target_link_libraries(srtp ${LIBS})
	if(MSVC)
		if(CMAKE_BUILD_TYPE STREQUAL "Debug")
			install(FILES ${CMAKE_CURRENT_BINARY_DIR}/Debug/srtp.pdb
				DESTINATION bin
				PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE
			)
		endif(CMAKE_BUILD_TYPE STREQUAL "Debug")
	endif(MSVC)
endif(${ENABLE_STATIC})
install(TARGETS srtp
	RUNTIME DESTINATION bin
	LIBRARY DESTINATION lib
	ARCHIVE DESTINATION lib
	PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE
)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/config.h
	DESTINATION include/srtp
	PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ
)


if(${ENABLE_TEST_PROGRAMS})
	add_executable(srtp_driver
		test/srtp_driver.c
		test/getopt_s.c
	)
	target_link_libraries(srtp_driver srtp)

	add_executable(replay_driver test/replay_driver.c)
	target_link_libraries(replay_driver srtp)

	add_executable(roc_driver test/roc_driver.c)
	target_link_libraries(roc_driver srtp)

	add_executable(rdbx_driver
		test/rdbx_driver.c
		test/getopt_s.c
	)
	target_link_libraries(rdbx_driver srtp)

	add_executable(rtpw
		test/rtpw.c
		test/rtp.c
		test/getopt_s.c
	)
	target_link_libraries(rtpw srtp)

	add_executable(dtls_srtp_driver
		test/dtls_srtp_driver.c
		test/getopt_s.c
	)
	target_link_libraries(dtls_srtp_driver srtp)

	add_executable(aes_calc crypto/test/aes_calc.c)
	target_link_libraries(aes_calc srtp)

	add_executable(cipher_driver crypto/test/cipher_driver.c)
	target_link_libraries(cipher_driver srtp)

	add_executable(datatypes_driver crypto/test/datatypes_driver.c)
	target_link_libraries(datatypes_driver srtp)

	add_executable(kernel_driver crypto/test/kernel_driver.c)
	target_link_libraries(kernel_driver srtp)

	add_executable(rand_gen crypto/test/rand_gen.c)
	target_link_libraries(rand_gen srtp)

	add_executable(sha1_driver crypto/test/sha1_driver.c)
	target_link_libraries(sha1_driver srtp)

	add_executable(stat_driver crypto/test/stat_driver.c)
	target_link_libraries(stat_driver srtp)
endif(${ENABLE_TEST_PROGRAMS})
