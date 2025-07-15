pipeline {
  agent any

  environment {
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
        withCredentials([usernamePassword(credentialsId: 'vsphere-creds', usernameVariable: 'TF_VAR_vsphere_user', passwordVariable: 'TF_VAR_vsphere_password')]) {
          sh 'terraform init'
        }
      }
    }

    stage('Validate Terraform Config') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'vsphere-creds', usernameVariable: 'TF_VAR_vsphere_user', passwordVariable: 'TF_VAR_vsphere_password')]) {
          sh 'terraform validate'
        }
      }
    }

    stage('Plan Infrastructure') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'vsphere-creds', usernameVariable: 'TF_VAR_vsphere_user', passwordVariable: 'TF_VAR_vsphere_password')]) {
          sh 'terraform plan -out=tfplan'
        }
      }
    }

    stage('Apply Infrastructure') {
      steps {
        input message: "Approve apply?"
        withCredentials([usernamePassword(credentialsId: 'vsphere-creds', usernameVariable: 'TF_VAR_vsphere_user', passwordVariable: 'TF_VAR_vsphere_password')]) {
          sh 'terraform apply -auto-approve tfplan'
        }
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

