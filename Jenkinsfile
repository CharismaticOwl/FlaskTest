pipeline{
    agent any
    environment {
        USER = 'ubuntu'
        EC2_INSTANCE_IP = '52.66.209.115'
        KEY_PAIR = 'ec2.pem'
    }
    stages{
        stage('Fetch code'){
            steps{
                git branch: 'main', url: 'https://github.com/CharismaticOwl/FlaskTest.git'
            }
        }

        stage('Running test case'){
            steps{
                sh 'chmod +x test_app.py'
                sh 'python test_app.py'
            }
        }
        stage('Build docker image'){
           steps{
             sh 'docker build -t narsss1234/python-app:latest .'
           }
        }
        stage('push to dockerhub'){
           steps{
             sh 'docker push narsss1234/python-app:latest'
           }
        }
        stage('Deploy') {
            steps {
                script {
                    sshagent(['satya_ec2']) {
                        sh "scp -o StrictHostKeyChecking=no -i ${KEY_PAIR}.pem Dockerfile ${USER}@${EC2_INSTANCE_IP}:~/"
                        sh "scp -o StrictHostKeyChecking=no -i ${KEY_PAIR}.pem -r * ${USER}@${EC2_INSTANCE_IP}:~/"
                        sshCommand remote: "ec2-user@${EC2_INSTANCE_IP}", command: "docker build -t narsss1234/python-app:latest -f Dockerfile ."
                        sshCommand remote: "ec2-user@${EC2_INSTANCE_IP}", command: "docker run -d -p 3000:3000 narsss1234/python-app:latest"
                    }
                }
            }
        }
    }
}