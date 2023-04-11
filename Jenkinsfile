pipeline {
    agent {label 'ansible'}
    stages {
        stage('Build') {
            steps {
                git url: 'https://github.com/sagilechaitanya/azureterraformansible.git',
                   branch: 'master'

            }
        }
            stage(build1) {
            steps {
                sh 'terraform init' 
                sh 'terraform validate'
                sh 'terraform apply -auto-approve'
            }
        }
    }
}