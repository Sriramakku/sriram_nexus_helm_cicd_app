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
                                -Dsonar.projectKey=your_project_key_created_in_sonarqube_as_project \
                                -Dsonar.sources=. \
                             """
                            sh 'mvn clean package sonar-server'

                    } 
                }  
            }
        }
    }
}