pipeline{
    agent any 
    environment {
        VERSION = "${env.BUILD_ID}"
    }
      
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
        stage("Quality gate status"){                      
            steps{                
                 waitForQualityGate abortPipeline: true, credentialsId: 'sonar-token'                      
                                     
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
            
        stage("docker build and push to Nexus repo"){                      
            steps{                
                script{
                    withCredentials([string(credentialsId: 'nexus_passwd', variable: 'nexus_creds')]) {
                        sh '''
                            docker build -t 35.173.125.14:8083/springapp:${VERSION} .
                            docker login -u admin -p $nexus_creds 35.173.125.14:8083
                            docker push 35.173.125.14:8083/springapp:${VERSION}
                            docker rmi 35.173.125.14:8083/springapp:${VERSION}

                        '''
                    }
                }                     
            }  
        } 
        stage("Identifying miscofigs using datree in helm charts") {
            steps{
                script{
                    dir('kubernetes/') {
                        withEnv(['DATREE_TOKEN=86993e25-ac27-4675-9e70-a47d96ab0c07']) {
                            sh 'helm datree test myapp/'                                
                        }
                    }
                }
            }
        }      
    }
    post {
		always {
			mail bcc: '', body: "<br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> URL de build: ${env.BUILD_URL}", cc: '', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: '', subject: "${currentBuild.result} CI: Project name -> ${env.JOB_NAME}", to: "sriramakku@gmail.com";  
		}
	}     
}
