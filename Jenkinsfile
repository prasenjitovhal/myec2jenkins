pipeline {
    agent any

    environment {
        // Latest stable Terraform as of January 2026
        TERRAFORM_VERSION = '1.14.3'
        AWS_REGION        = 'us-east-1'  // Change if needed
    }

    stages {
        stage('Checkout from GitHub') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/prasenjitovhal/myec2jenkins.git'  // Replace with your repo
            }
        }

        stage('Install Terraform') {
            steps {
                sh '''
                sudo dnf install -y unzip
                wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
                unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip
                sudo mv terraform /usr/local/bin/
                terraform --version
                '''
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -out=plan.tfplan'
            }
        }

        stage('Manual Approval') {
            steps {
                input message: 'Approve to apply Terraform changes?', ok: 'Apply'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve plan.tfplan'
            }
        }
    }

    post {
        success {
            echo 'EC2 instance successfully provisioned via Terraform!'
        }
        failure {
            echo 'Pipeline failed – check logs.'
        }
        always {
            cleanWs()
        }
    }
}
