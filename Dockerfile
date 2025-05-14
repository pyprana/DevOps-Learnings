- Def: A Dockerfile(script file) consists of instructions to build a Docker image.

- When : When you want to package an app + dependencies into a portable container.

- Where : Written in project directory (Dockerfile file), built using docker build.

- Why : To automate creating consistent, repeatable, portable containers across environments.

- Dockerfile vs Docker Image: Dockerfile is instructions; Docker Image is the result.

- Usage : Build stateless microservices (e.g., API servers, backend apps) using Dockerfiles for scalable deployment across AWS ECS, Kubernetes, Azure AKS.

- Key components include:

Instruction Purpose
FROM - Base image (e.g., ubuntu, node, etc.)
RUN - Executes commands to install packages or configure system.
COPY / ADD - Copies files from host to image.
WORKDIR. - Sets working directory inside image.
CMD - Default command to run when container starts.
ENTRYPOINT - Sets executable for container start.
EXPOSE - Documents the port the app listens on.
ENVSets - Environment variables.
VOLUME - Creates mount point for volumes.

Example:
FROM node:18
WORKDIR /app
COPY . .
RUN npm install
EXPOSE 3000
CMD ["node", "server.js"]
Each line builds the image step-by-step.

[Dockerfile] 
 ↓ docker build
[Docker Image] 
 ↓ docker run
[Docker Container] 
 ↓ deploy
Production Environment (ECS / Kubernetes / On-prem)

- How to Use a Dockerfile:
- Create the Dockerfile: Write the Dockerfile with the desired instructions. 
- Build the Image: Use the docker build command to build the Docker image from the Dockerfile. 
- Run the Container: Use the docker run command to create and run a container based on the built image.

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

- Here is a basic Dockerfile for a .NET application (e.g., ASP.NET Core Web API):

- For ASP.NET Core Web API (multi-stage build):
- dockerfile

# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /app
COPY . ./
RUN dotnet publish -c Release -o out

# Stage 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "YourAppName.dll"]
Replace YourAppName.dll with your actual DLL name.

- For .NET Console App:
dockerfile
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY . .
RUN dotnet publish -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/runtime:6.0
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "YourAppName.dll"]

- Common Docker Commands:
- bash
- docker build -t yourapp:latest .
- docker run -d -p 8080:80 yourapp:latest

- Here’s a line-by-line explanation of the .NET Dockerfile using the ASP.NET Core Web API (multi-stage build) example:

- Full Dockerfile:
- dockerfile
# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /app
COPY . ./
RUN dotnet publish -c Release -o out

# Stage 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "YourAppName.dll"]

- Stage 1: Build the application
- dockerfile

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
- Base Image: Uses the .NET SDK image (includes build tools).

- sdk:6.0 → allows compiling and publishing the .NET project.

- AS build → labels this stage for reference in the next stage.

- dockerfile

WORKDIR /app
- Working Directory: Sets /app as the working directory inside the container.

All subsequent commands will run from here.

- dockerfile
COPY . ./
- Copy Source Code: Copies everything from your local project directory (.) to /app in the container.

- Includes .csproj, .cs, configs, etc.

- dockerfile
RUN dotnet publish -c Release -o out
- Build & Publish App:

-c Release: Build in Release configuration.

-o out: Output the compiled files into /app/out.

- Stage 2: Create the runtime image
dockerfile
FROM mcr.microsoft.com/dotnet/aspnet:6.0
- Runtime Base Image: A lighter image with only the .NET ASP.NET runtime (no SDK/build tools).

- Ideal for running apps in production.

- dockerfile
WORKDIR /app
- Sets the working directory in the runtime container.

dockerfile
Copy
Edit
COPY --from=build /app/out .
Copy Artifacts from Build Stage: Transfers the published output from the build stage into the runtime container.

dockerfile
Copy
Edit
ENTRYPOINT ["dotnet", "YourAppName.dll"]
Start Command:

Tells Docker to run the app when the container starts.

Replace YourAppName.dll with your actual DLL name (from dotnet publish output).


