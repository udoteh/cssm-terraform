pipeline {
  agent any

  environment {
    VSPHERE_CREDS = credentials('vsphere-creds')
    TF_VAR_vsphere_user = "${VSPHERE_CREDS_USR}"
    TF_VAR_vsphere_password = "${VSPHERE_CREDS_PSW}"
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

