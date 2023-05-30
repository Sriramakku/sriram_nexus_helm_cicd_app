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
                    withSonarQubeEnv('sonar-token', envOnly: true) {                            
                            println ${env.SONAR_HOST_URL} 
                            sh 'mvn clean package sonar:sonar'                            
                    } 
                }  
            }
        }
    }
}