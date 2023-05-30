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
                environment {
                    SCANNER_HOME = tool 'sonar-scanner'
                }
                script{
                    withSonarQubeEnv(credentialsId: 'sonar-token') {
                            sh """
                                ${scanner_Home}/bin/sonar-scanner \
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