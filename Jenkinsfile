pipeline {
  agent any

  environment {
    TF_IN_AUTOMATION = "true"
  }

  stages {
    stage('Checkout Code') {
      steps {
        git 'https://github.com/yourname/esxi-deploy.git'
      }
    }

    stage('Initialize Terraform') {
      steps {
        dir('terraform') {
          sh 'terraform init'
        }
      }
    }

    stage('Validate Terraform Config') {
      steps {
        dir('terraform') {
          sh 'terraform validate'
        }
      }
    }

    stage('Plan Infrastructure') {
      steps {
        dir('terraform') {
          sh 'terraform plan -out=tfplan'
        }
      }
    }

    stage('Apply Infrastructure') {
      steps {
        dir('terraform') {
          sh 'terraform apply -auto-approve tfplan'
        }
      }
    }
  }
}
