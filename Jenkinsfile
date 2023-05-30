pipeline{
    agent any 
     
    stages{
        stage("sonar quality check"){
            agent {
                docker {
                    image 'maven'
                    args '-v $HOME/.m2:/root/.m2'
                }
            }
            steps{
                
                script{
                    withSonarQubeEnv('sonar-token', envOnly: true) {                            
                            sh 'mvn clean package sonar:sonar'
                            println ${env.SONAR_HOST_URL} 
                    } 
                }  
            }
        }
    }
}