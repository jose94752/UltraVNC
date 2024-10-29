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

# Conan install sample of zlib:x86-windows
# Create profile x86-windows
conan profile new x86-windows --detect
conan profile update settings.arch=x86_64 x86-windows
conan profile update settings.os=Windows x86-windows
conan profile update settings.compiler.runtime=MT x86-windows  # For a library
conan profile update options.*:shared=False x86-windows  # Ensures static libraries
# Set zlib in the conanfile.txt files need it
# Install with x86-windows profile
conan install . --profile x86-windows

# Conan install sample of zstd:x86-windows-static
# Create Conan Build Profile for x64-windows-static
conan profile new x86-windows-static --detect
conan profile update settings.arch=x86_64 x86-windows-static
conan profile update settings.os=Windows x86-windows-static
conan profile update settings.compiler.runtime=MT x86-windows-static  # For a static library
conan profile update options.*:shared=False x86-windows-static  # Ensures static libraries
# Set zstd in the conanfile.txt files need it
# Install with x86-windows-static profile
conan install . --profile x86-windows-static

..

# Run Conan to install the dependencies (last command)
conan install . --build=missing