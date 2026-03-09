pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                git 'https://github.com/Ajaybhukya/ci-demo-project.git'
            }
        }

        stage('Compile') {
            steps {
                sh 'mvn clean compile -DskipTests'
            }
        }

    }
}