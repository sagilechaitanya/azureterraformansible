pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'terraform init' 
                sh 'terraform validate'
                sh 'terraform apply -auto-approve'
            }
        }
    }
}