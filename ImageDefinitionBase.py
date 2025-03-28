from abc import ABC, abstractmethod
import argparse
import subprocess

class ImageDefinitionBase(ABC):
    GITHUB_TOKEN: str = ''

    @abstractmethod
    @property
    def tag(self):
        raise NotImplementedError()
    
    @abstractmethod
    def build(self):
        raise NotImplementedError()
    
def processRun(cmd: subprocess._CMD, cwd: str | None = None):
    subprocess.run(args=cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, cwd=cwd)

def getToken():
    parser = argparse.ArgumentParser()
    parser.add_argument("--github_token")
    args = parser.parse_args()
    
    return args.github_token | "0"