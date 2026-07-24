pipelineJob('seed') {
    displayName('0-Init')
    description('Loads Jenkins Job DSL definitions from the jobs directory.')

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://github.com/abirall/jenkins.git')
                    }
                    branch('main')
                }
            }
            scriptPath('Jenkinsfile.seed')
        }
    }

    triggers {
        githubPush()
    }
}