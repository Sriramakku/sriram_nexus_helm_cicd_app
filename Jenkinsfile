pipeline{
    agent any 
     
    stages{
        stage("sonar quality check"){
            agent {
                docker {
                    image 'maven'
                    args '-v $HOME/.m2:root/.m2'
                }
            }
            steps{
                
                script{
                   withSonarQubeEnv() {                            
                            sh 'mvn sonar:sonar'            
                            sh 'mvn clean install'                                    
                    } 
                    
                }  
            }
        }
    }
}