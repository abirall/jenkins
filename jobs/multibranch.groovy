multibranchPipelineJob('python-app-multibranch') {
    displayName('Python App Multibranch')
    description('Builds branches and pull requests from the Python application repository.')

    branchSources {
        git {
            id('python-app')
            remote('https://github.com/abirall/Python-App.git')
            includes('*')
        }
    }

    orphanedItemStrategy {
        discardOldItems {
            numToKeep(10)
        }
    }
}