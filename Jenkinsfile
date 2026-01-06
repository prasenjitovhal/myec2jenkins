pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'
    }

    stages {
        stage('Checkout from GitHub') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/prasenjitovhal/myec2jenkins.git'
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
