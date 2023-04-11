pipeline {
    agent any
    stages {
        stage('Build') {
            steps{
                git url: 'https://github.com/sagilechaitanya/azureterraformansible.git',
                   branch: 'master'

            }
        }
            stage{
            steps {
                sh 'terraform init' 
                sh 'terraform validate'
                sh 'terraform apply -auto-approve'
            }
        }
    }
}