# Node API – CI/CD Pipeline Project

This project contains a Node.js API with a production-ready CI/CD pipeline built using GitHub Actions. The pipeline performs code analysis, security scans, builds the application, creates a Docker image, scans it for vulnerabilities, and pushes it to the GitHub Container Registry (GHCR).

---

## 1. Running the Application Locally

### Prerequisites

Ensure the following tools are installed:

* Node.js v16
* npm
* Docker (optional, if running via container)
* Git

Check installations:

    node -v
    npm -v
    docker -v

Clone the Repository:

    git clone https://github.com/<your-username>/<repository-name>.git
    cd <repository-name>/app

Install Dependencies:
    
    npm ci

Start the Application

    npm start

The application should start on:

    http://localhost:5000

## 2. Accessing the Application

Once running locally, you can access the API endpoints:

    http://localhost:5000

## 3. Running the Application with Docker

Build the Docker image:

    docker build -t node-api .

Run the container:

    docker run -p 5000:5000 node-api

The application will be accessible at:

    http://localhost:5000

## 4. CI/CD Pipeline Overview

This project includes a GitHub Actions pipeline that performs automated build, security scanning, and Docker image publishing.

The workflow is triggered when:

* Pull Request is opened against the prod branch

* Manual triggered via workflow_dispatch

Pipeline file is loacted in `.github/workflows/pipeline.yml`

Pipeline Stages

* Prepare Stage

    * Checkout repository
    * Setup Node.js
    * Install dependencies

* Static Code Analysis
    * Security and code quality checks: SonarQube scan
    * Gitleaks secret detection: GitLeaks
    * ESLint linting: ESLint

Build Stage

 * Install dependencies
 * Start the application
 * Verify the API responds on port 5000
 * Upload build artifacts

Docker Build and Security Scan

 * Builds a Docker image
 * Runs a vulnerability scan using Trivy
 * Tags the image with `commit hash` and `latest`
 * Pushes it to GitHub Container Registry (GHCR)

---
### Required GitHub Secrets
---

The following secrets must be configured in the repository:

* SONAR_TOKEN: SonarQube authentication
* SONAR_HOST_URL:	SonarQube server URL
* GITHUB_TOKEN: Used for pushing Docker images to GHCR

The pipeline fails if critical or high vulnerabilities are detected.

## 🔐 Security Considerations

* Application runs as a non-root user in the container
* No secret is hardcoded in the repository or passed unencrypted in the pipeline. 
* Environment isoaltion: prod is gated and merges happen only through approved PRs
* The repo is scanned before building the application for leaked secrets 
* Docker image is scanned for vulnerabilities before pushing to the image registry. 

---
### Manual Pipeline Execution
---

The pipeline can also be triggered manually from GitHub:

Actions → Build, Scan, Deploy node-api → Run workflow