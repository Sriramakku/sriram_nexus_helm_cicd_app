pipeline{
    agent any 
     
    stages{
        // stage("sonar quality check"){
        //     agent {
        //         docker {
        //             image 'maven'
        //         }
        //     }
        //     steps{
                
        //         script{
        //             withSonarQubeEnv('sonar-server') {                            
        //                     //sh 'mvn org.sonarsource.scanner.maven:sonar-maven-plugin:3.7.0.1746:sonar'
        //                     //sh 'mvn clean verify sonar:sonar'       
        //                     sh 'mvn clean verify sonar:sonar'                    
        //             } 
                    
        //         }  
        //     }
        // }
        stage('SonarQube Analysis') {
            def mvn = tool 'Maven';
            withSonarQubeEnv() {
            sh "${mvn}/bin/mvn clean verify sonar:sonar -Dsonar.projectKey=test -Dsonar.projectName='test'"
            }
        }
    }
}