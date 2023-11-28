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
            
        stage("docker build and push to Nexus repo"){                      
            steps{                
                script{
                    withCredentials([string(credentialsId: 'nexus_passwd', variable: 'nexus_creds')]) {
                        sh '''
                            docker build -t 18.232.94.107:8083/springapp:${VERSION} .
                            docker login -u admin -p $nexus_creds 18.232.94.107:8083
                            docker push 18.232.94.107:8083/springapp:${VERSION}
                            docker rmi 18.232.94.107:8083/springapp:${VERSION}

                        '''
                    }
                }                     
            }  
        } 
        // stage("Identifying miscofigs using datree in helm charts") {
        //     steps{
        //         script{
        //             dir('kubernetes/') {
        //                 withEnv(['DATREE_TOKEN=86993e25-ac27-4675-9e70-a47d96ab0c07']) {
        //                     sh 'helm datree test myapp/'                                
        //                 }
        //             }
        //         }
        //     }
        // }
        // stage("pushing the helm charts to nexus"){                      
        //     steps{                
        //         script{
        //             withCredentials([string(credentialsId: 'nexus_passwd', variable: 'nexus_creds')]) {
        //                 dir('kubernetes/') {
        //                     sh '''
        //                         helmversion=$(helm show chart myapp | grep version | cut -d: -f 2 | tr -d ' ')
        //                         tar -czvf myapp-${helmversion}.tgz myapp/
        //                         curl -u admin:$nexus_creds http://18.206.40.3:8081/repository/helm-hosted/ --upload-file myapp-${helmversion}.tgz -v

        //                     '''
        //                 }
        //             }
        //         }                     
        //     }  
        // }
        // stage('Deploying application on k8s cluster') {
        //     steps {
        //        script{
        //            kubeconfig(credentialsId: 'mykubeconfig', serverUrl: 'https://44.201.33.193:6443') {
        //                 dir('kubernetes/') {
        //                   sh 'helm upgrade --install --set image.repository="18.206.40.3:8083/springapp" --set image.tag="${VERSION}" mycicdapp myapp/ ' 
        //                 }
        //             }
        //        }
        //     }
        // }     
    }
    post {
		always {
			mail bcc: '', body: "<br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> URL de build: ${env.BUILD_URL}", cc: '', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: '', subject: "${currentBuild.result} CI: Project name -> ${env.JOB_NAME}", to: "sriramakku@gmail.com";  
		}
	}     
}
