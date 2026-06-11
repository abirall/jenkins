Jenkins CI/CD Project Documentation


Project Overview
This project demonstrates a Jenkins-based CI/CD environment running in Docker. The setup includes Jenkins, Job DSL, Pipeline DSL, Git integration, and Docker-based application deployment.


Architecture
Developer -> Git Repository -> Jenkins Seed Job -> Generated Pipeline Job -> Docker Build -> Application Deployment
Components
- Jenkins Server
- Job DSL Plugin
- Pipeline Plugin
- Git Repository
- Docker Engine
- Docker Images and Containers

Job DSL
The seed job reads Groovy DSL scripts from the repository and automatically creates Jenkins jobs.
Pipeline DSL
The generated pipeline jobs execute CI/CD stages such as checkout, build, test, and deployment.
Workflow
1. Push code to Git.
2. Run Seed Job.
3. Jenkins creates pipeline jobs.
4. Pipeline builds Docker image.
5. Application is deployed automatically.


**Troubleshooting
Common issue: 'no Job DSL script(s) found'. Ensure the DSL script path in Jenkins matches the repository structure.
