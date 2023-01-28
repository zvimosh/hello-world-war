// Uses Declarative syntax to run commands inside a container.
pipeline {

    agent {
        label 'ubuntu'
    }

    triggers {
  pollSCM '* * * * *'
}
    stages {
        stage('checkout code') {
            steps {
                  checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: '>                //checkout scmGit(branches: [[name: '*/master']], extensions: [[$class: 'RelativeTargetDirectory', rela>
                  }
        }
        stage('Build') {
            steps {
                sh "docker build -t war:$BUILD_ID ."
            }
        }
        stage('Test') {
            steps {
                ||
                sh "docker run -d --rm --name tomcat -p 8080:8080 war:$BUILD_ID ."
                sh "sleep 10"
                sh "curl -s http://localhost:8080/ | grep 'Hello'"
            }
        }
    }
}

