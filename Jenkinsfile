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
                            sh" ${SCANNER_HOME**}/bin/sonar-scanner \
                                -Dsonar.projectKey=sonar-server \
                                -Dsonar.sources=. "
                            sh 'mvn clean package sonar-server'
                    } 
                }  
            }
        }
    }
}