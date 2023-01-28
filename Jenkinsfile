// Uses Declarative syntax to run commands inside a container.
pipeline {

    agent {
        label 'ubuntu'
    }
    stages {
        stage('checkout code') {
            steps {
                checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: 'zvi-github', url: 'git@github.com:zvimosh/hello-world-war.git']])
                  }
        }
        stage('Build') {
            steps{
                dockerImage = docker.build("zvimosh/my-hello-world:$BUILD_ID")
            }
        }
        stage('Test') {
            steps {
                sh 'docker rm -f tomcat || true'
                sh 'docker run -d --rm --name tomcat -p 8080:8080 $dockerImage .'
                sh 'sleep 10'
                sh "curl -s http://localhost:8080/hello-world-war-1.0.0"
                sh "docker stop tomcat"
                sh 'docker rmi -f war:$BUILD_ID'
            }
        }
        stage('Push image'){
            steps{
                withDockerRegistry([ credentialsId: "dockerhubaccount", url: "" ]) 
                    {
                        dockerImage.push()
                    }
                }    
        }    
    }
    post {
        always {
             chuckNorris()  
              
            }
        success {
             slackSend message: "${custom_msg()}", color: 'good'
         }
         }

}
def custom_msg()
{
  def JOB_NAME = env.JOB_NAME
  def BUILD_ID= env.BUILD_ID
  def JENKINS_MSG= " build: [${BUILD_ID}] was a sucess! in job [${env.JOB_NAME}]"
  return JENKINS_MSG
}

