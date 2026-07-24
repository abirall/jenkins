pipelineJob('python-app') {
    displayName('Python App')
    description('Builds and deploys the Python application with Docker Compose.')

    definition {
        cps {
            sandbox(true)
            script('''pipeline {
    agent {
        label 'built-in'
    }

    options {
        disableConcurrentBuilds(abortPrevious: true)
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/abirall/Python-App.git'
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
}''')
        }
    }
}