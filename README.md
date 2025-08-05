# Snyk DevSecOps Integration with Jenkins

This repository contains a **DevSecOps Proof-of-Concept (PoC)** that integrates **Snyk security tools** with a **Jenkins CI/CD pipeline**. The PoC automates the detection of vulnerabilities across multiple areas including open-source dependencies, application code, Docker containers, and Infrastructure as Code (IaC).

---

## Objectives

- Integrate **Snyk SaaS** into a Jenkins CI/CD pipeline
- Perform security scans in multiple stages of the SDLC:
  - Open source dependency scan (npm)
  - Static application code analysis
  - Docker container image scan
  - Terraform IaC security scan
- Visualize scan results within Jenkins UI using the **Warnings Next Generation Plugin**
- Archive Snyk JSON reports for historical view and auditing
- Enable policy-based pipeline failure (e.g., fail on High/Critical vulnerabilities)

---

## Tools & Technologies Used

| Tool              | Purpose                               |
|-------------------|----------------------------------------|
| **Jenkins**       | CI/CD orchestration                    |
| **Snyk CLI**      | Security scans (OSS, Code, Container, IaC) |
| **Node.js + NPM** | Sample vulnerable application stack     |
| **Docker**        | Build container image                  |
| **Terraform**     | Infrastructure-as-Code scanning        |
| **Warnings Next Generation Plugin** | View Snyk scan results in Jenkins UI |
| **Snyk SaaS**     | Centralized vulnerability management   |

---


## Jenkins Pipeline Stages

The `Jenkinsfile` is a **Declarative Pipeline** with the following stages:

1. **Checkout**  
   Clone this GitHub repository into Jenkins workspace.

2. **Install App Deps**  
   Run `npm install` in the `app/` directory.

3. **Snyk Open Source Scan**  
   Scan for known vulnerabilities in dependencies using `snyk test --json`.

4. **Build Docker Image**  
   Build Docker image of the app using `Dockerfile`.

5. **Snyk Container Scan**  
   Scan the built image using `snyk container test`.

6. **Snyk IaC Scan**  
   Run `snyk iac test` on `terraform/main.tf` to detect insecure configurations.

7. **Monitor Deployment**  
   Track application in Snyk dashboard via `snyk monitor`.

8. **Report Archiving**  
   JSON reports archived as artifacts for auditing.

---

##  Snyk SaaS Integration Steps

1. **Create Snyk Account**  
   - Sign up at [https://snyk.io](https://snyk.io)

2. **Generate API Token**  
   - Go to `Account Settings` → `API Token`

3. **Store API Token in Jenkins**  
   - Navigate to: `Jenkins → Manage Jenkins → Credentials`
   - Add a new Secret Text credential with ID: `snyk-api-token`

4. **Install Snyk CLI on Jenkins Host**  
   ```bash
   npm install -g snyk
   
## Jenkins Configuration Steps
### Install Jenkins Plugins

- Pipeline
- Warnings Next Generation
- *(Optional)* Docker and NodeJS plugins
---

### Pipeline Authentication

```groovy
environment {
  SNYK_TOKEN = credentials('snyk-api-token')
}

