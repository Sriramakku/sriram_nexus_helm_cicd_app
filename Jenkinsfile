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
                    withSonarQubeEnv(credentialsId: 'sonar-server', installationName: 'sonar-server') {                            
                            //sh 'mvn org.sonarsource.scanner.maven:sonar-maven-plugin:3.7.0.1746:sonar'
                            //sh 'mvn clean verify sonar:sonar'       
                            sh 'mvn clean verify sonar:sonar'                    
                    } 
                }  
            }
        }
    }
}