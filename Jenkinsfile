pipeline {
  agent any

  stages {

    stage('push image') {
      steps {
        script {
          docker.withRegistry('http://172.18.31.33:5000') {
            def customImage = docker.build("ant-home-page:${env.BUILD_ID}")
            customImage.push()
          }
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
