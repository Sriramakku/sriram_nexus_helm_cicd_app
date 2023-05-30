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
                    withSonarQubeEnv(credentialsId: 'squ_9641b07762c4f82003ea37d84b53dce3b4b00557', installationName: 'sonar-server') {                            
                            sh 'mvn org.sonarsource.scanner.maven:sonar-maven-plugin:3.7.0.1746:sonar'
                            //sh 'mvn clean package sonar:sonar'                            
                    } 
                }  
            }
        }
    }
}