node {
    stage('scm'){
        git 'https://github.com/singaravellu/java-hello-world-webapp.git'
    }
    stage('build')
    {
        sh 'mvn clean package'
    }
    /* stage('publishing the test results')
    {
        junit 'gameoflife-web/target/surefire-reports/*.xml'
        // archiveArtifacts 'gameoflife-web/target/*.war'
    }
    stage('SonarQube analysis') {
    withSonarQubeEnv('sonar-6.7') 
    { // You can override the credential to be used
      sh 'mvn org.sonarsource.scanner.maven:sonar-maven-plugin:3.6.0.1398:sonar'
    }
   } */
    stage ('building docker image')
    {
        echo "building the docker image  "
        sh 'docker image build -t dockersing/hello-world:1.1'
       
    }
    stage('Push the docker image to hub'){
        echo "login into docker hub "
        withCredentials([usernamePassword(credentialsId: 'DockerCred', passwordVariable: 'passwd', usernameVariable: 'username')]) {
         sh 'docker login -u ${username} -p ${passwd} '   
    // some block
      }
      sh 'docker push dockersing/hello-world'
    }
    stage('Deployment in cluster')
    {
       // echo "deploying into k8's"
        withKubeConfig(  credentialsId: 'kubernetes') {
            
        sh 'kubectl delete -f deployment.yml '
        sh 'kubectl delete -f service.yml'
       
        }
    }
}
