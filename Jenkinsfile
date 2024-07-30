pipeline
{
    agent any
    tools
    {
        jdk 'JAVA_HOME' 
        maven 'MAVEN_HOME'
    }
    environment
    {
        SCANNER_HOME= tool 'sonar-scanner'
    }
    triggers 
    {
        pollSCM('* * * * *') 
    }
    stages
    {
      stage('Git-CheckOut')
      {
        steps
        {
            git branch:'main',
                url: 'https://github.com/sureshkumar-devops/spy-app.git'
        }
      }
      stage('Compile-Code')
      {
        steps
        {
            sh 'mvn compile'
        }
      }                  
      stage('Build Application')
      {
        steps
        {
            sh 'mvn package -DskipTests=true'
        }
      }
      stage('Artifact to Nexus Repo')
      {
        steps
        {
            withMaven(globalMavenSettingsConfig: 'maven-settings',jdk: 'JAVA_HOME',maven:'MAVEN_HOME',mavenSettingsConfig: '',traceability:true)
            {
              sh 'mvn deploy -DskipTests=true'
            }
        }
      }
      stage('Build Image & Tag')
      {
        steps
        {
            script
            { 
              withDockerRegistry(credentialsId: 'cred-docker', toolName: 'docker')
              {
                 sh 'docker build -t lehardocker/spy-app-dev:latest .'
              }
            }
        } 
      }    
    }    
}