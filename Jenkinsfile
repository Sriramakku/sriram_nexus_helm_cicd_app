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
                    withSonarQubeEnv(credentialsId: 'sonar-token'){   
                        sh """                           
                            -Dsonar.projectKey=sriram_nexus_helm_cicd_app \
                            -Dsonar.sources=. \
                            """
                         
                        sh 'mvn clean package sonar:sonar'            
                        //sh 'mvn clean install'                                    
                    }                     
                }  
            }
        }
    }
}