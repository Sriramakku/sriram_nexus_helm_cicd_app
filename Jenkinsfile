pipeline{
    agent {
        docker {
            image 'maven'
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