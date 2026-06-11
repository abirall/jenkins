pipelineJob('sample-pipeline') {

```
description('Clone Python application from GitHub and deploy using Docker Compose')

definition {
    cps {
        script("""
```
pipeline {
agent any

```
stages {

    stage('Clone Repository') {
        steps {
            git(
                branch: 'main',
                url: 'https://github.com/abirall/Python-App.git'
            )
        }
    }

    stage('Verify Workspace') {
        steps {
            sh 'echo "Current Directory:"'
            sh 'pwd'

            sh 'echo "Workspace Files:"'
            sh 'ls -la'
        }
    }

    stage('Deploy Application') {
        steps {
            sh '''
            docker compose up -d
            '''
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
```

}
""")
sandbox()
}
}
}

pipelineJob('homarr-deploy') {

```
description('Deploy Homarr dashboard using Docker Compose')

definition {
    cps {
        script("""
```

pipeline {
agent any

```
environment {
    HOMARR_DIR = '/opt/stacks/homar'
}

stages {

    stage('Verify Homarr Files') {
        steps {
            sh '''
            echo "Checking Homarr Directory"
            ls -la \$HOMARR_DIR
            '''
        }
    }

    stage('Pull Latest Images') {
        steps {
            sh '''
            cd \$HOMARR_DIR
            docker compose pull
            '''
        }
    }

    stage('Deploy Homarr') {
        steps {
            sh '''
            cd \$HOMARR_DIR
            docker compose up -d
            '''
        }
    }

    stage('Verify Deployment') {
        steps {
            sh '''
            docker ps
            '''
        }
    }
}

post {
    success {
        echo 'Homarr deployed successfully.'
    }

    failure {
        echo 'Homarr deployment failed.'
    }
}
```

}
""")
sandbox()
}
}
}
