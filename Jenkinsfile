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
          sh 'snyk test'
        }
      }
    }

    stage('Snyk Code Scan') {
      steps {
        dir('app') {
          sh 'snyk code test'
        }
      }
    }

    stage('Build Docker Image') {
      steps {
        dir('app') {
          sh 'docker build -t snyk-demo-app .'
        }
      }
    }

    stage('Snyk Container Scan') {
      steps {
        sh 'snyk container test snyk-demo-app'
      }
    }

    stage('Snyk IaC Scan') {
      steps {
        dir('terraform') {
          sh 'snyk iac test main.tf'
        }
      }
    }

    stage('Monitor Deployment') {
      steps {
        dir('app') {
          sh 'snyk monitor'
        }
      }
    }
  }
}
