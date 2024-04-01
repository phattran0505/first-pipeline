pipeline {
    agent any
    tools {
      jdk 'openJDK11'
      maven 'Maven3'
    }
    environment {
	    APP_NAME = "first-pipeline"
        RELEASE = "1.0.0"
        DOCKER_USER = "phattran0123"
        DOCKER_PASS = 'dockerhub'   // credentials: dockerhub-token
        IMAGE_NAME = "${DOCKER_USER}" + "/" + "${APP_NAME}"
        IMAGE_TAG = "${RELEASE}-${BUILD_NUMBER}"
    }
    stages {
        stage("Build Application"){
            steps {
                sh "mvn clean package"
            }

        }

        stage("Test Application"){
            steps {
                sh "mvn test"
            }
        }
        stage('check out') {
            steps {
                git branch: 'main', changelog: false, poll: false, url: 'https://github.com/phattran0505/first-pipeline.git'
            }
        }
        stage("Build Application"){
            steps {
                sh "mvn clean package"
            }
        }

        stage("Test Application"){
            steps {
                sh "mvn test"
            }
        }
        stage("Build & Push Docker Image") {
            steps {
                script {
                    docker.withRegistry('',DOCKER_PASS) {
                        docker_image = docker.build "${IMAGE_NAME}"
                    }
                    docker.withRegistry('',DOCKER_PASS) {
                        docker_image.push("${IMAGE_TAG}")
                        docker_image.push('latest')
                    }
                }
            }
        }
    }
}