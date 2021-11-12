#!groovy

pipeline {
    agent any 
    
    environment {
        IMAGE_NAME = "rbarrett89/funprojectideas"
        IMAGE_TAG = "latest"
        tag = sh(returnStdout: true, script: "git rev-parse --short=10 HEAD").trim()
    }

    stages {
        stage("Build FunProjectIdeas Core Image") {
            steps {
                sh "make funprojectideas"
            }
        }
        stage("Push FunProjectIdeas to DockerHub") {
            steps {
                script {
                    docker.withRegistry("https://registry.hub.docker.com", "common-dockerhub-up") {
                        docker.image("${IMAGE_NAME}:${IMAGE_TAG}").push()
                    }
                }
            }
        }
    }
}