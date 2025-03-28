from typing import override

from ImageDefinitionBase import ImageDefinitionBase, getToken, processRun

class UbuntuVcpkg(ImageDefinitionBase):
    
    @override
    @property
    def tag(self):
        return 'ubuntu-vcpkg'
    
    @override
    def build(self):
        processRun(['docker build --build-arg GITHUB_TOKEN=' + self.GITHUB_TOKEN + '-t ' + self.tag + ' .'])

def main():
    definition = UbuntuVcpkg()
    definition.GITHUB_TOKEN = getToken()
    definition.build()

if __name__ == "__main__":
    main()