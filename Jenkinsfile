/* import shared library */
@Library('jenkins-shared-library')_

pipeline {
    agent any

    parameters {

        string(defaultValue: '', description: 'This is for docker image tag', name: 'IMAGE_TAG')
        string(defaultValue: '', description: 'This is for docker image tag', name: 'TAG_NAME')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']],
                    userRemoteConfigs: [[url: 'https://github.com/ashokmnr/first-warexample.git']]])
            }
        }
        stage('Gradle Build') {
            steps {
                echo 'Gradle Building'
                sh """
                pwd
                ls
                chmod +x gradlew
                ./gradlew build
                # mv $WORKSPACE/first-warexample/build/libs/first-warexample.war
                """
            }
        }
        stage("Build Image") {
            steps {
                sh """
                    ls
                    docker build -t 393492168443.dkr.ecr.us-east-1.amazonaws.com/dev-images:${IMAGE_TAG} .
                """
            }
        }
        stage("Docker images push to ecr") {
            steps {
                sh """#!/bin/bash
                    export PATH="/usr/local/bin:$PATH"
                    # Retrieve an authentication token and authenticate your Docker client to your registry.
                    eval \$(aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 393492168443.dkr.ecr.us-east-1.amazonaws.com/dev-images)
                    # Pushing docker tagged image to us-east-1 ecr
                    docker push 393492168443.dkr.ecr.us-east-1.amazonaws.com/dev-images:${IMAGE_TAG}
                    # Remove docker image after pushing to us-east-1 ecr
                    docker rmi -f 393492168443.dkr.ecr.us-east-1.amazonaws.com/dev-images:${IMAGE_TAG}
                """
            }
        }
    }
    post {
        always {
            script {
                manager.addShortText("${params.IMAGE_TAG}")
                manager.addShortText("${params.TAG_NAME}")
            }
            echo 'Sending Slack Notification'
            slackNotifierv1(currentBuild.currentResult)
            echo 'Deleting workspace'
            deleteDir()
        }
    }
}
