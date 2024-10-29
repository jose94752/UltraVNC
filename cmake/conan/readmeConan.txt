###################### To Do Upgrade for Conan Linux Users

# Debian Trixie/unstable amd64 qemu VM 2024-07-28

apt install git curl zip unzip tar build-essential cmake ninja-build mingw-w64 nasm pkg-config ccache



mkdir $HOME/source
cd    $HOME/source
git clone https://github.com/microsoft/vcpkg.git
cd vcpkg

./bootstrap-vcpkg.sh -disableMetrics
export VCPKG_ROOT=$HOME/source/vcpkg
export PATH=$VCPKG_ROOT:$PATH

vcpkg --version



export PATH=/usr/lib/ccache:$PATH

vcpkg install zlib:x64-mingw-static
vcpkg install zstd:x64-mingw-static
vcpkg install libjpeg-turbo:x64-mingw-static
vcpkg install liblzma:x64-mingw-static
vcpkg install openssl:x64-mingw-static
vcpkg install libsodium:x64-mingw-static



cd    $HOME/source
git clone https://github.com/ultravnc/UltraVNC.git

mkdir obj && cd obj
cmake \
    -DCMAKE_TOOLCHAIN_FILE=$VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake \
    -DVCPKG_CHAINLOAD_TOOLCHAIN_FILE=$VCPKG_ROOT/scripts/toolchains/mingw.cmake \
    -DCMAKE_SYSTEM_NAME=MinGW \
    -DVCPKG_TARGET_TRIPLET=x64-mingw-static \
    -DVCPKG_TARGET_ARCHITECTURE=x64 \
    -DVCPKG_APPLOCAL_DEPS=OFF \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    ../UltraVNC/cmake
cmake --build . -j
cmake --build . --target install
#make clean

cp -a /usr/lib/gcc/x86_64-w64-mingw32/13-win32/libstdc++-6.dll .
cp -a /usr/lib/gcc/x86_64-w64-mingw32/13-win32/libgcc_s_seh-1.dll .





######################  Upgraded for Conan Windows Visual Studio Users

# Windows with cmake, generate Visual Studio project files

# Install git
# Install Visual Studio Community 2022 (with MFC components to avoid errors about missing afxres.h)
# Install Python


# Open git bash

mkdir c:/source
cd c:/source
pip install conan

# Check install of Conan
conan --version
pip show conan

# Create Conan Build Profile for x64-windows-static
conan profile new x64-windows-static --detect
conan profile update settings.arch=x86_64 x64-windows-static
conan profile update settings.os=Windows x64-windows-static
conan profile update settings.compiler.runtime=MT x64-windows-static  # For a static library
conan profile update options.*:shared=False x64-windows-static  # Ensures static libraries

# See the conanfile.txt files need it for install of these libraries
libjpeg-turbo
liblzma
libsodium
openssl
zlib
zstd

# Call the install of libraries from conanfile.txt files with the profile x64-windows-static
conan install . --profile x64-windows-static

# Run Conan to install the dependencies
conan install . --build=missing


cd /d c:\source
git clone https://github.com/ultravnc/UltraVNC.git

mkdir obj && cd obj
cmake ^
    -DCMAKE_TOOLCHAIN_FILE=%VCPKG_ROOT%\scripts\buildsystems\vcpkg.cmake ^
    -DVCPKG_TARGET_TRIPLET=x64-windows-static ^
    ..\UltraVNC\cmake
set CL=/MP
cmake --build . --parallel --config=RelWithDebInfo




######################  Upgraded for Conan Windows Visual Studio Users no changes here

# Windows with cmake, using ninja build system, and address santitizer enabled

# x64 Native Tools Command Prompt for VS 2022

# Same steps before the cmake invocation as above

cd /d c:\source
mkdir obj_ninja && cd obj_ninja
cmake ^
    -DCMAKE_TOOLCHAIN_FILE=%VCPKG_ROOT%\scripts\buildsystems\vcpkg.cmake ^
    -DVCPKG_TARGET_TRIPLET=x64-windows-static ^
    -G Ninja ^
    -Dasan=TRUE ^
    ..\UltraVNC\cmake
cmake --build . --parallel --config=RelWithDebInfo
cmake --build . --target install --config=RelWithDebInfo
copy "%VCToolsInstallDir%\bin\Hostx64\x64\clang_rt.asan_dynamic-x86_64.dll" ultravnc\
#ninja clean




######################  Upgraded for Conan Windows Visual Studio Users no changes here

# Windows with cmake, using LLVM compiler

# x64 Native Tools Command Prompt for VS 2022

# Same steps before the cmake invocation as above

cd /d c:\source
mkdir obj_ninja_llvm && cd obj_ninja_llvm
cmake ^
    -DCMAKE_TOOLCHAIN_FILE=%VCPKG_ROOT%\scripts\buildsystems\vcpkg.cmake ^
    -DVCPKG_TARGET_TRIPLET=x64-windows-static ^
    -T ClangCL ^
    ..\UltraVNC\cmake
cmake --build . --parallel --config=RelWithDebInfo
#ninja clean




######################  Upgraded for Conan Windows Visual Studio Users adding previous changes not from Conan

# Windows with regular Visual Studio project files

# Same steps before the cmake invocation as above

# Install PlatformToolset matching to the project files, currently v143 for Visual Studio 2022 and v142 for Visual Studio 2019

set _P=^
  /p:Platform=x64 ^
  /p:Configuration=Release ^
  /p:PlatformToolset=v143 ^
  /p:BuildInParallel=true -maxcpucount:16 /p:CL_MPCount=16 ^
  /t:Clean;Build
set CL=/MP

cd /d C:\source\UltraVNC
msbuild %_P% winvnc\winvnc.sln
msbuild %_P% vncviewer\vncviewer.sln
