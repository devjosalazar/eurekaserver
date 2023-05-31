pipeline {
    agent any
    environment {
        PROJECT_ID = 'poetic-avenue-387315'
                CLUSTER_NAME = 'cluster-jenkins-project'
                LOCATION = 'us-central1'
                CREDENTIALS_ID = 'MyFirstProject'
    }
    
    stages {
        stage('Check Git...') {
            steps{
                checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/devjosalazar/eurekaserver.git']])
            }
        }
        stage('Building image...') {
            environment {
                def imageName = "josalazar/microservicio_eurekaserver:${env.BUILD_ID}"
            }
            steps {
                script {
                    sh "docker build -t ${imageName} ."
                    }
            }
        }
        
        stage('Pushing image...') {
            environment {
                def imageName = "josalazar/microservicio_eurekaserver:${env.BUILD_ID}"
            }
            steps {
                script {
                    withCredentials([string(credentialsId: 'dockerhub', variable: 'dockerhub')]) {
                        sh 'docker login -u josalazar -p ${dockerhub}'
                        sh "docker push ${imageName}"
                    }
                }
            }
        }
    
        stage('Deploying to K8s') {
            steps{
                echo "Deployment started ..."
                sh 'ls -ltr'
                sh 'pwd'
                sh "sed -i 's/pipeline:latest/pipeline:${env.BUILD_ID}/g' eurekaserver.yaml"
                step([$class: 'KubernetesEngineBuilder', \
                  projectId: env.PROJECT_ID, \
                  clusterName: env.CLUSTER_NAME, \
                  location: env.LOCATION, \
                  manifestPattern: 'eurekaserver.yaml', \
                  credentialsId: env.CREDENTIALS_ID, \
                  verifyDeployments: true])
                }
            }
        }    
}