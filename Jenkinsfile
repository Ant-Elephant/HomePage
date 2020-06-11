pipeline {
  agent any

  stages {
    stage('test') {
      agent {
        docker { image 'node:10' }
      }
      steps {
        sh "npm run install"
        sh 'bash ./CI/test.sh'
      }
    }

    stage('push image') {
      steps {
        checkout scm
        docker.withRegistry('http://172.18.31.33:5000') {
          def customImage = docker.build("ant-home-page:${env.BUILD_ID}")
          customImage.push()
        }
      }
    }

    stage('deploy') {
      steps {
        sh 'echo \'Deploy\''
      }
    }

  }
}
