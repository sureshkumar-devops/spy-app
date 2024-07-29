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
      stage('Unit Testing')
      {
        steps
        {
            sh 'mvn test -DskipTests=true'
        }
      }
      stage('Trivy File Scan')
      {
        steps
        {
            sh 'trivy --version'
            sh 'trivy fs --format table -o trivy-fs-report.html .'
        }
      }
      stage('SonarQube Analysis')
      {
        steps
        {
            //withSonarQubeEnv(sonar-server)
            {
            withSonarQubeEnv(credentialsId: 'cred-sonar-token')
            {
                sh ''' $SCANNER_HOME/bin/sonar-scanner\
                -Dsonar.projectName=SpyApp-Dev\
                -Dsonar.projectKey=SpyApp-Dev\
                -Dsonar.java.binaries=. '''
            }
        }
      }
    }
    post
    {
      always
      {
          echo 'One Way or another, I have finished..'
          //cleanWs()
      }
      success
      {
          echo 'I Successed..!'
      }
      unstable
      {
          echo 'I am Unstable :/'
      }
      failure
      {
          echo 'I failed :('
      }
      changed
      {
           echo 'Things were different before...'
      }
    }
}