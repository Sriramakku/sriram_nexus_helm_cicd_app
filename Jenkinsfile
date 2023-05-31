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
                    def mvn = tool 'Maven';
                    withSonarQubeEnv('sonar-server') {                            
                            //sh 'mvn org.sonarsource.scanner.maven:sonar-maven-plugin:3.7.0.1746:sonar'
                            //sh 'mvn clean verify sonar:sonar'       
                            //sh 'mvn clean verify sonar:sonar'       
                            sh "${mvn}/bin/mvn clean package sonar:sonar -Dsonar.projectKey=test -Dsonar.projectName='test'"             
                    } 
                    
                }  
            }
        }
        // stage('SonarQube Analysis') {
        //     def mvn = tool 'Maven';
        //     withSonarQubeEnv() {
        //     sh "${mvn}/bin/mvn clean verify sonar:sonar -Dsonar.projectKey=test -Dsonar.projectName='test'"
        //     }
        // }
    }
}