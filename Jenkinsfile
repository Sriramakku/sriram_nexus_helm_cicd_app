pipeline{
    agent any 
      
    stages{
        stage("sonar quality check"){   
            agent {
                docker {
                    image 'maven'
                    args '-u root'
                }
            }         
            steps{                
                script{
                    withSonarQubeEnv(credentialsId: 'sonar-token'){ 
                                         
                        sh 'mvn sonar:sonar'            
                        sh 'mvn clean package'                                    
                    }                     
                }  
            }            
        }
        stage("Quality gat status"){                      
            steps{                
                script{
                    withSonarQubeEnv(credentialsId: 'sonar-token'){ 
                        waitForQualityGate abortPipeline: false, credentialsId: 'sonar-token' 
                    }                                  
                }                     
            }  
        }      
        // stage("Quality Gate"){
        //     timeout(time: 1, unit: 'HOURS') { // Just in case something goes wrong, pipeline will be killed after a timeout
        //         def qg = waitForQualityGate() // Reuse taskId previously collected by withSonarQubeEnv
        //         if (qg.status != 'OK') {
        //         error "Pipeline aborted due to quality gate failure: ${qg.status}"
        //         }
        //     }
        // }
            
        // stage("docker build and push to Nexus repo"){                      
        //     steps{                
        //         script{
                                                     
        //         }                     
        //     }  
        // }       
    }
}
