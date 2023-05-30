pipeline{
    agent any 
    stages{
        stage("sonar quality check"){
            agent {
                docker {
                    image 'maven'
                }
            }
            steps{
                script{
                    withSonarQubeEnv(credentialsId: 'sonar-token') {
                            sh """
                                ${scannerHome}/bin/sonar-scanner \
                                -Dsonar.projectKey=sonar-token \
                                -Dsonar.sources=. \
                             """
                            sh 'mvn clean package sonar-server'

                    } 
                }  
            }
        }
    }
}