from typing import override

from ImageDefinitionBase import getToken, processRun
from 

class UbuntuVcpkgQt6(UbuntuVcpkg):
    
    @override
    @property
    def tag(self):
        return 'ubuntu-vcpkg'
    
    @override
    def build(self):
        super().build()

        processRun(['docker', 'build', '--build-arg', 'GITHUB_TOKEN=' + self.GITHUB_TOKEN, 'BASE_IMAGE=' + super().tag, '.'])

def main():
    definition = UbuntuVcpkgQt6()
    definition.GITHUB_TOKEN = getToken()
    definition.build()

if __name__ == "__main__":
    main()