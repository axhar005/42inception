# Inception

## Summary
This document outlines an Administration System project that primarily focuses on using Docker to create a virtualized environment on your personal virtual machine.

## Preamble
The goal of this project is to deepen your technical skills in system administration by engaging with Docker technology. You will learn how to effectively manage and deploy multiple Docker containers, simulating a network of services on a single virtual machine.

## General Instructions
- The project must be completed on a Virtual Machine.
- All configuration files necessary for your project must be contained within a `srcs` folder.
- A Makefile located at the root of your directory is required. It should be capable of setting up your entire application, i.e., building Docker images through `docker-compose.yml`.
- This project might introduce new concepts, so extensive research and documentation reading on Docker and related technologies are recommended.

## Mandatory Part
You are required to set up a mini-infrastructure of different services using docker-compose, with each Docker image named after the service it represents. Containers must run independently and be built using either the penultimate stable version of Alpine or Debian. They should each have their own Dockerfile and not rely on pre-made images from external services like DockerHub (except for Alpine and Debian).

Specifically, you must configure:
- A Docker container for NGINX with TLSv1.2 or TLSv1.3 only.
- A Docker container for WordPress + php-fpm without nginx.
- A Docker container for MariaDB without nginx.
- Two volumes for your WordPress database and files.
- A docker-network to link your containers, ensuring they restart on crash without resorting to 'hacky patch' methods.

## Submission and Peer Evaluation
Submit your work to your Git repository as usual. Only the contents of your repository will be considered during evaluation. Ensure that all directory and file names are in accordance with project specifications.
