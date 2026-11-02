FROM mcr.microsoft.com/windows:ltsc2019

LABEL description="Microsoft Windows 11 LTSC 2019 with installed: \n\
       - MS Visual Studio 2026 Community (.NET 4.8, .NET 10, MSVC, CMake, Git) \n\
       - Powershell \n\
       - vcpkg \n\
       Entry point is set to PowerShell with pre-configured MSVC build tools"

USER ContainerAdministrator

# Install MSVC Build Tools
SHELL ["cmd", "/S", "/C"]
RUN \
    # Download the Build Tools bootstrapper.
    curl -SL --output vs_community.exe https://aka.ms/vs/stable/vs_community.exe \
    \
    # Install Build Tools with the Microsoft.VisualStudio.Workload.AzureBuildTools workload, excluding workloads and components with known issues.
    && (start /w vs_community.exe --quiet --wait --norestart \
        --add Microsoft.Component.MSBuild \
        --add Microsoft.VisualStudio.Component.CoreEditor \
        --add Microsoft.VisualStudio.Component.CppBuildInsights \
        --add Microsoft.VisualStudio.Component.Debugger.JustInTime \
        --add Microsoft.VisualStudio.Component.Graphics.Tools \
        --add Microsoft.VisualStudio.Component.Git \
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
        --add Microsoft.Net.Component.4.8.SDK \
        --add Microsoft.Net.Component.4.8.TargetingPack \
        --add Microsoft.Net.ComponentGroup.DevelopmentPrerequisites \
        --add Microsoft.Net.ComponentGroup.TargetingPacks.Common \
        --add Microsoft.NetCore.Component.Runtime.10.0 \
        --add Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Core \
        --add Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions.CMake \
        --add Microsoft.VisualStudio.Workload.CoreEditor \
        --add Microsoft.VisualStudio.Workload.NativeDesktop \
        --add Microsoft.VisualStudio.Workload.NativeGame \
        || IF "%ERRORLEVEL%"=="3010" EXIT 0) \
    \
    # Cleanup
    && del /q vs_community.exe

WORKDIR C:/Users/ContainerUser

# Clone vcpkg repo
RUN git clone https://github.com/microsoft/vcpkg.git

# Configure vcpkg
RUN vcpkg/bootstrap-vcpkg.bat
ENV VCPKG_ROOT="C:/Users/ContainerUser/vcpkg"

USER ContainerUser

# Define the entry point for the docker container.
# This entry point starts the developer command prompt and launches the PowerShell shell.
ENTRYPOINT ["C:\\Program Files\\Microsoft Visual Studio\\18\\Community\\VC\\Auxiliary\\Build\\vcvars64.bat", "&&", "powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]