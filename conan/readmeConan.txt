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

# Common Steps cmake invocation

# Install git

# Install Visual Studio Community 2022 (with MFC components to avoid errors about missing afxres.h)
#	If you have Visual Studio Build Tools 2019 with VSC 2022 (install on it MFC components too for same reason)
#		and install Windows SDK Version 8.1 (for Errors errors MSB8036)


# Install Python
# Open git bash

mkdir c:/source
cd c:/source
pip install conan

# Check install of Conan
conan --version
pip show conan

# Go to the directory /conan/cmake
cd /c/source/UltraVNC/conan/cmake

# First create the Conan default profile (if you just install Conan and you have not set these one)
# Creating the Conan default profile
conan profile detect
# More information here https://docs.conan.io/2/reference/config_files/profiles.html
# Save the informations of the command on text file you can retrieve easily if you need it.

# Create Conan Build Profile for x64-windows-static
conan profile detect --name x64-windows-static


# Open Windows powershell
or
# Open Developer PowerShell for VS 2022
#export PATH=/usr/lib/ccache:$PATH			<- Searching the same for Windows In Progress
#$env:PATH = "C:\path\to\ccache;" + $env:PATH
# For Vcpkg
$env:PATH = "C:\source\vcpkg\installed\x64-windows-static\lib\ccache;" + $env:PATH
# Libraries for Conan V1 (Old)
#C:\Users\<YourUserName>\.conan\data\<library_name>\<version>\<provider>
# Libraries for Conan V2
#C:\Users\<YourUserName>\.conan2\p\<library_name>\<version>\<provider>
$env:PATH = "C:\Users\<YourUserName>\.conan2\p\ccache;" + $env:PATH
# Don't forget to replace <YourUserName> with your username or the username of windows use on the path if you have change after the install of Windows i.e.: you have for logging MyNewUsername and in Windows Explorer C:\Users\MyOldUsername is using so here use MyOldUsername


# Open git bash
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
*:shared=False
[conf]

# See the conanfile.py (former conanfile.txt) files need it for install of these libraries
libjpeg-turbo
liblzma
libsodium
openssl
zlib
zstd

# Command for find packages of library example
conan search "zlib"

# Install libraries commands
conan install . -pr x64-windows-static --build zlib/1.3.1

# Call the install of libraries from conanfile.py files with the profile x64-windows-static
conan install . -pr x64-windows-static

# Run Conan to install the dependencies
conan install . -pr x64-windows-static --build=missing


cd /d c:\source
git clone https://github.com/ultravnc/UltraVNC.git

# End Common Steps cmake invocation


mkdir obj && cd obj
# Previous with vcpkg (Which one use # x64 Native Tools Command Prompt for VS 2022)
#cmake ^
#    -DCMAKE_TOOLCHAIN_FILE=%VCPKG_ROOT%\scripts\buildsystems\vcpkg.cmake ^
#    -DVCPKG_TARGET_TRIPLET=x64-windows-static ^
#    ..\UltraVNC\cmake
#set CL=/MP
# Actual with Conan Not functional in the folder obj you must use these on the folder of Conan (cd /c/source/UltraVNC/conan/cmake/)
cmake .. -G "Visual Studio 17 2022" -DCMAKE_TOOLCHAIN_FILE="conan_toolchain.cmake" 

cmake --build . --parallel --config=RelWithDebInfo





######################  Upgrade in progress for Conan Windows Visual Studio Users

# Windows with cmake, using ninja build system, and address sanitizer enabled

# Open git bash

# Same steps before the cmake invocation as above (# Common Steps cmake invocation)

# Steps specific using ninja build system, and address sanitizer enabled
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

# Open git bash

# Same steps before the cmake invocation as above (# Common Steps cmake invocation)

# Steps specific using LLVM compiler
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

# Same steps before the cmake invocation as above (# Common Steps cmake invocation)

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





######################  To Do Upgrade for Conan Qt Users

# Windows with cmake, generate Qt project files (Qt Community Tests Specific)

# Install git
# Install Visual Studio Community 2022 (with MFC components to avoid errors about missing afxres.h)
# Install Qt Creator Edition Community

# Cross-platform Qt 6 CMake Project Setup (Windows)
# System Variables and Path of Qt in Environnements Variables

New Variable (if doesn't exist)
Variable name		: QTDIR
Variable value		: C:\Qt\6.7.2\msvc2019_64 (for msvc2019_64 or the path you put the compiler you want to use on your computer)

Edit Path, add bin and lib
# New (if doesn't exist)
%QTDIR%\bin
%QTDIR%\lib

# New (Patch Error ZLIB not find see (Section: # Windows with cmake, generate Visual Studio project files))
Variable name	: VCPKG_DEFAULT_TRIPLET
Variable value	: x64-windows-static

# Uninstall the vcpkg optional package from your Visual Studio instance (see VCPKG_README.txt if you want knowing why).
# Edit Windows system environment variable
# New (if doesn't exist)
Variable name	: VCPKG_ROOT
Variable value	: C:\source\vcpkg

# Adding to Path
%VCPKG_ROOT%

Restart your computer.

# Same steps before the cmake invocation as above (Section: # Windows with cmake, generate Visual Studio project files)

# Install cmake (Windows)
# Download and install from https://cmake.org/download/
# Windows x64 Installer: cmake-3.30.2-windows-x86_64.msi (or version more recent and for your computer OS Specific)

# On CMake (cmake-gui) use these
	Where is the the source code 	: C:/source/UltraVNC/cmake
	Where to build the binaries 	: C:/source/UltraVNC/build
	Click on Configure for choose compiler version (Don't miss clic you can't go back to choose another).
	(If Error ZLIB not find : try to update environment and see VCPKG_README.txt doesn't work for me actually. Note: same error with Visual Studio 2022)

# Steps specific Qt Creator Community Edition below (In Progress)

