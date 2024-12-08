from conan import ConanFile
from conan.tools.files import save, load
from conan.tools.gnu import AutotoolsToolchain, AutotoolsDeps
from conan.tools.microsoft import unix_path, VCVars, is_msvc
from conan.errors import ConanInvalidConfiguration
from conan.errors import ConanException

class repeater(ConanFile):
    generators = "CMakeToolchain", "CMakeDeps"
    settings = "os", "compiler", "build_type", "arch"
    
    def requirements(self):
        pass
        #self.requires("libjpeg-turbo/[~3.0.4]")
        #self.requires("libsodium/[~cci.20220430]")
        #self.requires("xz_utils/[~5.4.5]") # LibLZMA
        #self.requires("zlib/[~1.3.1]")
        #self.requires("zstd/[~1.5.6]")
        #self.requires("qt/[>=6.7 <6.8]") #sample line

    def build_requirements(self):
        self.tool_requires("cmake/[>3.30]")
        
    def configure(self):
        pass
        #self.options["qt/*"].shared = False #sample line
        #self.options["qt/*"].multimedia = True #sample line

    def layout(self):
        self.folders.generators = ""


# Original from the conanfile.txt
## Section for required dependencies
#[requires]
##libjpeg-turbo/3.0.4
##libsodium/cci.20220430
##xz_utils/5.4.5 # LibLZMA
##zlib/1.3.1
##zstd/1.4.9
#
## Section for generators, here CMake to facilitate integration with CMake
#[generators]
#CMakeDeps
#CMakeToolchain
#
#[layout]
#cmake_layout
#
## Options section (optional) for customizing package configuration
#[options]
## For example, deactivate the shared option to obtain static libraries
##zlib:shared=False