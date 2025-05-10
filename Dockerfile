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
