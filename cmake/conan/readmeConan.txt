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





######################  Upgrade in progress for Conan Windows Visual Studio Users

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

# Go to the directory /cmake/conan (Windows adapt for Linux and others)
cd /c/source/UltraVNC/cmake/conan/

# First create the Conan default profile (if you just install Conan and you have not set these one)
# Creating the Conan default profile
conan profile detect
# More information here https://docs.conan.io/2/reference/config_files/profiles.html
# Save the informations of the command on text file you can retrieve easily if you need it.

# Create Conan Build Profile for x64-windows-static
conan profile detect --name x64-windows-static

# Conan v1 commands (we can't use them they are no logger support on Conan version 2!)
conan profile update settings.arch=x86_64 x64-windows-static
conan profile update settings.os=Windows x64-windows-static
conan profile update settings.compiler.runtime=MT x64-windows-static  # For a static library Old V1
conan profile update options.*:shared=False x64-windows-static  # Ensures static libraries
# See that https://github.com/conan-io/conan/issues/13205
# You must edit and modify the Conan profile x64-windows-static with you favorite text editor
# Note for the following values are not allowed on Conan V2
# Compiler MT you must use 'static' or 'dynamic' -> compiler.runtime=static
# For replace the "conan profile update options.*:shared=False" adding these 3 lines below to the x64-windows-static profile.
[options]
shared=False
[conf]

# See the conanfile.txt files need it for install of these libraries
libjpeg-turbo
liblzma
libsodium
openssl
zlib
zstd

# Call the install of libraries from conanfile.txt files with the profile x64-windows-static
conan install . -pr x64-windows-static

# Run Conan to install the dependencies
conan install . --build=missing


cd /d c:\source
git clone https://github.com/ultravnc/UltraVNC.git

mkdir obj && cd obj
# Previous with vcpkg (Which one use # x64 Native Tools Command Prompt for VS 2022)
#cmake ^
#    -DCMAKE_TOOLCHAIN_FILE=%VCPKG_ROOT%\scripts\buildsystems\vcpkg.cmake ^
#    -DVCPKG_TARGET_TRIPLET=x64-windows-static ^
#    ..\UltraVNC\cmake
# Actual with Conan Not functional
cmake .. "Visual Studio 17 2022" -DCMAKE_TOOLCHAIN_FILE="conan_toolchain.cmake" ..\UltraVNC\cmake
set CL=/MP
cmake --build . --parallel --config=RelWithDebInfo




######################  Upgrade in progress for Conan Windows Visual Studio Users

# Windows with cmake, using ninja build system, and address santitizer enabled

# x64 Native Tools Command Prompt for VS 2022

# Same steps before the cmake invocation as above

cd /d c:\source
mkdir obj_ninja && cd obj_ninja
# Previous with vcpkg (Which one use # x64 Native Tools Command Prompt for VS 2022)
#cmake ^
#    -DCMAKE_TOOLCHAIN_FILE=%VCPKG_ROOT%\scripts\buildsystems\vcpkg.cmake ^
#    -DVCPKG_TARGET_TRIPLET=x64-windows-static ^
#    -G Ninja ^
#    -Dasan=TRUE ^
#    ..\UltraVNC\cmake
# Actual with Conan
xx-To Do-xx
cmake --build . --parallel --config=RelWithDebInfo
cmake --build . --target install --config=RelWithDebInfo
copy "%VCToolsInstallDir%\bin\Hostx64\x64\clang_rt.asan_dynamic-x86_64.dll" ultravnc\
#ninja clean




######################  Upgrade in progress for Conan Windows Visual Studio Users

# Windows with cmake, using LLVM compiler

# x64 Native Tools Command Prompt for VS 2022

# Same steps before the cmake invocation as above

cd /d c:\source
mkdir obj_ninja_llvm && cd obj_ninja_llvm
# Previous with vcpkg (Which one use # x64 Native Tools Command Prompt for VS 2022)
#cmake ^
#    -DCMAKE_TOOLCHAIN_FILE=%VCPKG_ROOT%\scripts\buildsystems\vcpkg.cmake ^
#    -DVCPKG_TARGET_TRIPLET=x64-windows-static ^
#    -T ClangCL ^
#    ..\UltraVNC\cmake
# Actual with Conan
xx-To Do-xx
cmake --build . --parallel --config=RelWithDebInfo
#ninja clean




######################  Upgrade in progress for Conan Windows Visual Studio Users adding previous changes not from Conan

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
