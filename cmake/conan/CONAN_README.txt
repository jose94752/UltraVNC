zlib:x64-windows-static                           1.3                 A compression library
zlib:x86-windows                                  1.3                 A compression library
zlib:x86-windows-static                           1.3                 A compression library
zlib:x64-windows
zstd:x64-windows-static                           1.5.5#1             Zstandard - Fast real-time compression algorithm
zstd:x86-windows                                  1.5.5#1             Zstandard - Fast real-time compression algorithm
zstd:x86-windows-static                           1.5.5#1             Zstandard - Fast real-time compression algorithm
zstd:x64-windows 
libjpeg-turbo:x64-windows-static                  3.0.0#1             libjpeg-turbo is a JPEG image codec that uses SI...
libjpeg-turbo:x86-windows                         3.0.0#1             libjpeg-turbo is a JPEG image codec that uses SI...
libjpeg-turbo:x86-windows-static                  3.0.0#1             libjpeg-turbo is a JPEG image codec that uses SI...
libjpeg-turbo:x64-windows  
liblzma:x64-windows-static                        5.4.3#1             Compression library with an API similar to that ...
liblzma:x86-windows                               5.4.3#1             Compression library with an API similar to that ...
liblzma:x86-windows-static                        5.4.3#1             Compression library with an API similar to that ...
liblzma:x64-windows 

libsodium:x86-windows-static
libsodium:x86-windows
libsodium:x64-windows-static
libsodium:x64-windows


# Use Git Bash for these commands below

# Go to the directory /cmake/conan (Windows adapt for Linux and others)
cd /c/source/UltraVNC/cmake/conan/

# First create the Conan default profile (if you just install Conan and you have not set these one)
# Creating the Conan default profile
conan profile detect
# More information here https://docs.conan.io/2/reference/config_files/profiles.html
# Save the informations of the command on text file you can retrieve easily if you need it.

# Create Conan Build Profile for x64-windows-static
conan profile detect --name x64-windows-static

# Conan install sample of zlib:x86-windows
# Create profile x86-windows
conan profile detect --name x86-windows

# Conan v1 commands (we can't use them they are no logger support on Conan version 2!)
conan profile update settings.arch=x86_64 x86-windows
conan profile update settings.os=Windows x86-windows
conan profile update settings.compiler.runtime=MT x86-windows  # For a library Old V1
conan profile update options.*:shared=False x86-windows  # Ensures static libraries Old V1
# See that https://github.com/conan-io/conan/issues/13205
# You must edit and modify the Conan profile x64-windows-static with you favorite text editor
# Note for the compiler MT is doesn't allowed on Conan V2 you must use 'static' or 'dynamic' -> compiler.runtime=static
# For replace the "conan profile update options.*:shared=False" adding these 3 lines below to the x86-windows profile.
[options]
shared=False
[conf]

# Set zlib in the conanfile.txt files need it

# Install with x86-windows profile
conan install . -pr x86-windows


# Conan install sample of zstd:x86-windows-static
# Create Conan Build Profile for x86-windows-static
conan profile detect --name x86-windows-static

# Conan v1 commands (we can't use them they are no logger support on Conan version 2!)
conan profile update settings.arch=x86_64 x86-windows-static
conan profile update settings.os=Windows x86-windows-static
conan profile update settings.compiler.runtime=MT x86-windows-static  # For a static library Old V1
conan profile update options.*:shared=False x86-windows-static  # Ensures static libraries Old V1
# You must edit and modify the Conan profile x64-windows-static with you favorite text editor
# Note for the following values are not allowed on Conan V2
# Compiler MT you must use 'static' or 'dynamic' -> compiler.runtime=static
# For replace the "conan profile update options.*:shared=False" adding these 3 lines below to the x86-windows-static profile.
[options]
shared=False
[conf]



# Set zstd in the conanfile.txt files need it

# Install with x86-windows-static profile
conan install . -pr x86-windows-static

..

# Run Conan to install the dependencies (last command)
conan install . --build=missing