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
            steps {
                sh 'docker build -t war:$BUILD_ID .'
            }
        }
        stage('Test') {
            steps {
                sh 'docker rm -f tomcat || true'
                sh 'docker run -d --rm --name tomcat -p 8080:8080 war:$BUILD_ID .'
                sh 'sleep 10'
                sh "curl -s http://localhost:8080/hello-world-war-1.0.0"
                sh "docker stop tomcat"
                sh 'docker rmi -f war:$BUILD_ID'
            }
        }
    }
    post {
        always {
             chuckNorris()  
              
            }
        success {
             sh 'curl -X POST -H "Content-type: application/json" --data "{'text':'Zvi Maven Project build: $BUILD_ID'}" https://hooks.slack.com/services/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'
         }
         }

}

