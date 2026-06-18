
pipeline {
    agent {
    label 'built-in'
        }

    stages {

        stage('Clone Repository') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/abirall/Python-App.git'
            }
        }

        stage('Verify Workspace') {
            steps {
                sh 'pwd'
                sh 'ls -la'
            }
        }

        stage('Deploy Application') {
            steps {
                sh 'docker compose up -d'
            }
        }

        stage('Validate Deployment') {
            steps {
                sh 'docker ps'
            }
        }
    }
        post {
        success {
            echo 'Python application deployed successfully.'
        }

        failure {
            echo 'Deployment failed.'
        }
    }
}
