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
		checkout scmGit(branches: [[name: '*/master']], extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: 'mvnfiles']], userRemoteConfigs: [[credentialsId: 'zvi-github', url: 'git@github.com:zvimosh/hello-world-war.git']])
		  }
        }
        stage('Build') {
            steps {
                sh "docker build -t war:$BUILD_ID ."
            }
        }
    }
}
