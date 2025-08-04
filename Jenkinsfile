pipeline {
  agent any

  environment {
    SNYK_TOKEN = credentials('snyk-api-token')
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Install App Deps') {
      steps {
        dir('app') {
          sh 'npm install'
        }
      }
    }

    stage('Snyk Open Source Scan') {
      steps {
        dir('app') {
          // Generate JSON report
          sh(script: 'snyk test --json > snyk-report.json || true', returnStatus: true)
          // Jenkins UI display
          recordIssues tools: [snyk(pattern: 'app/snyk-report.json')]
        }
      }
    }

    // Snyk Code Scan is disabled for now
    // stage('Snyk Code Scan') {
    //   steps {
    //     dir('app') {
    //       sh(script: 'snyk code test', returnStatus: true)
    //     }
    //   }
    // }

    stage('Build Docker Image') {
      steps {
        dir('app') {
          sh 'docker build -t snyk-demo-app .'
        }
      }
    }

    stage('Snyk Container Scan') {
      steps {
        sh(script: 'snyk container test snyk-demo-app', returnStatus: true)
      }
    }

    stage('Snyk IaC Scan') {
      steps {
        dir('terraform') {
          sh(script: 'snyk iac test main.tf', returnStatus: true)
        }
      }
    }

    stage('Monitor Deployment') {
      steps {
        dir('app') {
          sh(script: 'snyk monitor', returnStatus: true)
        }
      }
    }
  }

  post {
    always {
      // Save the Snyk JSON report as a build artifact
      archiveArtifacts artifacts: 'app/snyk-report.json', onlyIfSuccessful: false
    }
  }
}
