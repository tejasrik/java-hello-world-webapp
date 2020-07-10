node {
    stage('scm'){
        git 'https://github.com/singaravellu/employeeManagement.git'
    }
    stage('build')
    {
        sh 'mvn package -DskipTests'
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
        sh 'docker image build -t dockersing/employee:1.0 .'
    }
    stage('Push the docker image to hub'){
        echo "login into docker hub "
        withCredentials([usernamePassword(credentialsId: 'DockerCred', passwordVariable: 'passwd', usernameVariable: 'username')]) {
         sh 'docker login -u ${username} -p ${passwd} '   
    // some block
      }
      sh 'docker push dockersing/employee:1.0'
    }
    stage('Deployment in cluster')
    {
       // echo "deploying into k8's"
        withKubeConfig(  credentialsId: 'kubernetes') {

       /* sh 'kubectl apply -f Deployment.yml'
       sh 'kubectl apply -f Service.yml'
       sh 'kubectl apply -f Deployment-mysql.yml'
       sh 'kubectl apply -f Service-mysql.yml' */
       sh script: """
       kubectl delete -f Deployment.yml
       kubectl delete -f Service.yml
       kubectl delete -f Deployment-mysql.yml
       kubectl delete -f Service-mysql.yml
       """
        }
    }
}
