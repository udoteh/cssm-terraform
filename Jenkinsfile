pipeline {
  agent any

  environment {
    TF_VAR_vsphere_user = credentials('root')
    TF_VAR_vsphere_password = credentials('P@ssw0rd')
    TF_VAR_vsphere_server = '192.168.1.87'
  }

  stages {
    stage('Checkout Code') {
      steps {
        git url: 'https://github.com/udoteh/cssm-terraform.git'
      }
    }

    stage('Initialize Terraform') {
      steps {
        sh 'terraform init'
      }
    }

    stage('Validate Terraform Config') {
      steps {
        sh 'terraform validate'
      }
    }

    stage('Plan Infrastructure') {
      steps {
        sh 'terraform plan -out=tfplan'
      }
    }

    stage('Apply Infrastructure') {
      steps {
        input message: "Approve apply?"
        sh 'terraform apply -auto-approve tfplan'
      }
    }
  }

  post {
    success {
      echo "✅ Infrastructure successfully deployed!"
    }
    failure {
      echo "❌ Build failed!"
    }
  }
}

