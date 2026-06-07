pipelineJob('sample-pipeline') {

    definition {

        cps {

            script('''
pipeline {
    agent any

    stages {

        stage('Git Code Clone') {
            steps {
                git url: 'https://github.com/abirall/Python-App.git', branch: 'main'
            }
        }

        stage('Check Files') {
            steps {
                sh 'pwd'
                sh 'ls -la'
            }
        }

        stage('Deploy With Docker') {
            steps {
                sh 'docker compose up -d'
            }
        }

        stage('Final Check') {
            steps {
                sh 'docker ps'
            }
        }

    }
}
''')

            sandbox()
        }
    }
}