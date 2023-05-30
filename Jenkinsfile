pipeline{
    agent any 
    environment {
        SCANNER_HOME = tool 'sonar-scanner'
    }
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
                                ${SCANNER_HOME}/bin/sonar-scanner \
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