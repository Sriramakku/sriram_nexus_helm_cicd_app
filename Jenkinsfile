pipeline{
    agent {
        docker {
            image 'maven'
            args '-v $HOME/.m2:root/.m2'
        }
    }      
    stages{
        stage("sonar quality check"){            
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