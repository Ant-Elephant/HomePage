def projectName = 'ant-home-page'
def buildId = 'test'
def deployIP = '120.77.254.178'
def projectPath = '/home/ubuntu/zc/zczc/prod/Group-collect'
def remoteUser = 'root'
def containerName = "${projectPath}:${buildId}"
def imageName = "${containerName}/${projectName}:${buildId}"

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
      agent any
      steps {
        input message: "是否部署？若部署，将部署 release-${env.BUILD_ID} 分支至 ${deployIP}。"
        sshagent(credentials : ['120.77.254.178']) {
          sh "ssh -o StrictHostKeyChecking=no ${remoteUser}@${deployIP};docker stop ${containerName};(docker rm ${containerName} || true);docker run -p 3111:80 -d --name ${containerName} ${imageName}"
        }
      }
    }
  }
}
