FROM mcr.microsoft.com/windows/servercore:ltsc2022

LABEL description="Microsoft Windows Server Core LTSC 2022 with installed: \n\
       - MS Visual Studio 2022 Build Tools \n\
       - Git \n\
       - Git LFS \n\
       - Powershell \n\
       - vcpkg \n\
       Entry point is set to PowerShell with pre-configured MSVC build tools"

USER ContainerAdministrator

SHELL [ "PowerShell", "-Command" ]

RUN Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Get Git for Windows
RUN choco install git -y

# Get Git LFS
RUN choco install git-lfs.install -y

WORKDIR C:/Users/ContainerUser

# Clone vcpkg repo
RUN git clone https://github.com/microsoft/vcpkg.git

# Configure vcpkg
RUN ./vcpkg/bootstrap-vcpkg.bat
ENV VCPKG_ROOT="C:/Users/ContainerUser/vcpkg"

# Install MSVC Build Tools
SHELL ["cmd", "/S", "/C"]
RUN \
    # Download the Build Tools bootstrapper.
    curl -SL --output vs_buildtools.exe https://aka.ms/vs/17/release/vs_buildtools.exe \
    \
    # Install Build Tools with the Microsoft.VisualStudio.Workload.AzureBuildTools workload, excluding workloads and components with known issues.
    && (start /w vs_buildtools.exe --quiet --wait --norestart --nocache \
        --installPath "%ProgramFiles(x86)%\Microsoft Visual Studio\2022\BuildTools" \
        --add Microsoft.VisualStudio.Workload.AzureBuildTools \
        --remove Microsoft.VisualStudio.Component.Windows10SDK.10240 \
        --remove Microsoft.VisualStudio.Component.Windows10SDK.10586 \
        --remove Microsoft.VisualStudio.Component.Windows10SDK.14393 \
        --remove Microsoft.VisualStudio.Component.Windows81SDK \
        || IF "%ERRORLEVEL%"=="3010" EXIT 0) \
    \
    # Cleanup
    && del /q vs_buildtools.exe

USER ContainerUser

# Define the entry point for the docker container.
# This entry point starts the developer command prompt and launches the PowerShell shell.
ENTRYPOINT ["C:\\Program Files (x86)\\Microsoft Visual Studio\\2022\\BuildTools\\Common7\\Tools\\VsDevCmd.bat", "&&", "powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]