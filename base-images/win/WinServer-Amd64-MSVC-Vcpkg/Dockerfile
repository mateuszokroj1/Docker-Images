FROM mcr.microsoft.com/windows/server:ltsc2025

LABEL description="Microsoft Windows Server LTSC 2025 with installed: \n\
       - MS Visual Studio 2026 Community \n\
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

RUN Invoke-WebRequest https://aka.ms/vs/stable/vs_community.exe -OutFile vs_community.exe
RUN ./vs_community.exe --quiet --wait --norestart \
        --add Microsoft.Component.MSBuild \
        --add Microsoft.VisualStudio.Component.CoreEditor \
        --add Microsoft.VisualStudio.Component.CppBuildInsights \
        --add Microsoft.VisualStudio.Component.Debugger.JustInTime \
        --add Microsoft.VisualStudio.Component.Graphics.Tools \
        --add Microsoft.VisualStudio.Component.NuGet \
        --add Microsoft.VisualStudio.Component.Roslyn.Compiler \
        --add Microsoft.VisualStudio.Component.TextTemplating \
        --add Microsoft.VisualStudio.Component.VC.14.44.17.14.ATL \
        --add Microsoft.VisualStudio.Component.VC.14.44.17.14.x86.x64 \
        --add Microsoft.VisualStudio.Component.VC.ASAN \
        --add Microsoft.VisualStudio.Component.VC.ATL \
        --add Microsoft.VisualStudio.Component.VC.CMake.Project \
        --add Microsoft.VisualStudio.Component.VC.CoreIde \
        --add Microsoft.VisualStudio.Component.VC.DiagnosticTools \
        --add Microsoft.VisualStudio.Component.VC.Redist.14.Latest \
        --add Microsoft.VisualStudio.Component.VC.TestAdapterForGoogleTest \
        --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 \
        --add Microsoft.VisualStudio.Component.Windows10SDK \
        --add Microsoft.VisualStudio.Component.Windows11SDK.26100 \
        --add Microsoft.VisualStudio.Component.Windows11Sdk.WindowsPerformanceToolkit \
        --add Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Core \
        --add Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions.CMake \
        --add Microsoft.Net.Component.4.8.SDK \
        --add Microsoft.Net.Component.4.8.TargetingPack \
        --add Microsoft.Net.ComponentGroup.DevelopmentPrerequisites \
        --add Microsoft.Net.ComponentGroup.TargetingPacks.Common \
        --add Microsoft.NetCore.Component.Runtime.10.0 \
        --add Microsoft.VisualStudio.Workload.CoreEditor \
        --add Microsoft.VisualStudio.Workload.NativeDesktop \
        --add Microsoft.VisualStudio.Workload.NativeGame
    # Cleanup
    
RUN Remove-Item -Path vs_community.exe

USER ContainerUser

# Define the entry point for the docker container.
# This entry point starts the developer command prompt and launches the PowerShell shell.
ENTRYPOINT ["C:\\Program Files\\Microsoft Visual Studio\\18\\Community\\VC\\Auxiliary\\Build\\vcvars64.bat", "&&", "powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]
