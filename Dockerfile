FROM mcr.microsoft.com/windows/servercore:ltsc2022

# Install Python (example with Chocolatey)
RUN powershell -Command \
    Set-ExecutionPolicy Bypass -Scope Process -Force; \
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; \
    Invoke-WebRequest -Uri https://chocolatey.org/install.ps1 -UseBasicParsing | Invoke-Expression; \
    choco install python --version=3.10.0 -y; \
    refreshenv

# Install pip and additional Python packages
RUN python -m ensurepip && python -m pip install --upgrade pip PyYAML

# Copy scripts
COPY feed.py C:\feed.py
COPY entrypoint.sh C:\entrypoint.sh

# Set entrypoint
ENTRYPOINT ["C:\\entrypoint.sh"]