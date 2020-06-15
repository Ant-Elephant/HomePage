def projectName = 'ant-home-page'
def buildId = 'test'
def deployIP = '120.77.254.178'
def registryIP = '120.77.254.178:5000'
def remoteUser = 'root'
def containerName = "${projectName}:${buildId}"
def imageName = "${projectName}:${buildId}"

pipeline {
  agent any

  stages {

    stage('push image') {
      steps {
        script {
          docker.withRegistry('http://172.18.31.33:5000') {
            def customImage = docker.build("${imageName}")
            customImage.push()
          }
        }
      }
    }

    stage('deploy') {
      steps {
        sshagent(credentials : ['120.77.254.178']) {
          sh "ssh -o StrictHostKeyChecking=no ${remoteUser}@${deployIP};(docker stop ${containerName} || true);(docker rm ${containerName} || true);docker run -p 3111:80 -d --name ${containerName} ${registryIP}/${imageName}"
        }
      }
    }
  }
}
