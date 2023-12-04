pipeline{
    agent any 
    // parameters {
    //     booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    //     choice(name: 'action', choices: ['apply', 'destroy'], description: 'Select the action to perform')
    // }
    environment {
        VERSION = "Pipeline sriram_java_app_cicd_"+"${env.BUILD_ID}"
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
        AWS_DEFAULT_REGION    = 'us-east-1'
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
                            docker build -t 54.210.71.16:8083/springapp:${VERSION} .
                            docker login -u admin -p $nexus_creds 54.210.71.16:8083
                            docker push 54.210.71.16:8083/springapp:${VERSION}
                            docker rmi 54.210.71.16:8083/springapp:${VERSION}

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
        stage('Terraform init and plan ') {
            steps {
                sh 'terraform init'
                sh 'terraform plan -out tfplan'
                sh 'terraform show -no-color tfplan > tfplan.txt'
            }
        }
        stage('Apply / Destroy') {
            steps {
                script {
                    // if (params.action == 'apply') {
                    //     if (!params.autoApprove) {
                    //         def plan = readFile 'tfplan.txt'
                    //         input message: "Do you want to apply the plan?",
                    //         parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                    //     }

                        sh 'terraform apply -input=false tfplan'
                    // } else if (params.action == 'destroy') {
                    //     sh 'terraform ${action} --auto-approve'
                    // } else {
                    //     error "Invalid action selected. Please choose either 'apply' or 'destroy'."
                    // }
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
