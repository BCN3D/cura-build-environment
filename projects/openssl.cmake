if(BUILD_OS_OSX)
    set(_openssl_os darwin64-x86_64-cc enable-ec_nistp_64_gcc_128)
    set(_openssl_args no-ssl2 no-ssl3 no-zlib shared enable-cms)

    ExternalProject_Add(OpenSSL
        GIT_REPOSITORY git://git.openssl.org/openssl.git
        GIT_TAG OpenSSL_1_1_1j
        GIT_SHALLOW TRUE
        CONFIGURE_COMMAND perl Configure --prefix=${CMAKE_INSTALL_PREFIX} --openssldir=${CMAKE_INSTALL_PREFIX} ${_openssl_args} ${_openssl_os}
        BUILD_COMMAND make depend && make
        INSTALL_COMMAND make install
        BUILD_IN_SOURCE 1
    )
elseif(BUILD_OS_LINUX)
    set(_openssl_os linux-x86_64 enable-ec_nistp_64_gcc_128)
    set(_openssl_args no-ssl2 no-ssl3 no-zlib shared enable-cms)

    ExternalProject_Add(OpenSSL
        GIT_REPOSITORY git://git.openssl.org/openssl.git
        GIT_TAG OpenSSL_1_1_1j
        GIT_SHALLOW TRUE
        CONFIGURE_COMMAND perl Configure --prefix=${CMAKE_INSTALL_PREFIX} --openssldir=${CMAKE_INSTALL_PREFIX} ${_openssl_args} ${_openssl_os}
        BUILD_COMMAND make depend && make
        INSTALL_COMMAND make install
        BUILD_IN_SOURCE 1
    )
endif()

return()

if(BUILD_OS_WINDOWS)
    if(BUILD_OS_WIN32)
        set(_openssl_os "VC-WIN32")
        set(_openssl_build ms\\do_nasm.bat && nmake -f ms\\nt.mak)
    else()
        set(_openssl_os "VC-WIN64A")
        set(_openssl_build ms\\do_win64a.bat && nmake -f ms\\nt.mak)
    endif()

    ExternalProject_Add(OpenSSL
        GIT_REPOSITORY git://git.openssl.org/openssl.git
        GIT_TAG OpenSSL_1_1_1j
        GIT_SHALLOW TRUE
        CONFIGURE_COMMAND perl Configure ${_openssl_os} --prefix=${CMAKE_INSTALL_PREFIX}
        BUILD_COMMAND ${_openssl_build}
        INSTALL_COMMAND nmake -f ms\\nt.mak install
        BUILD_IN_SOURCE 1
    )
endif()
