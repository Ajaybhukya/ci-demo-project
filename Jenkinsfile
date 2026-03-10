pipeline {
    agent any

    stages {
        
        stage('Load Environment') {
            steps {
                withCredentials([file(credentialsId: 'timesheet-env-file', variable: 'ENV_FILE')]) {
                     sh '''
                cat $ENV_FILE > .env
                    '''
                }
            }
        }

        stage('Checkout') {
            steps {
                git branch: 'main',
                url: 'https://github.com/Ajaybhukya/ci-demo-project.git'
            }
        }

        stage('Compile') {
            steps {
                sh 'mvn clean compile -DskipTests'
            }
        }

         stage('Parallel Checks') {
            parallel {

                stage('Unit Tests') {
                    steps {
                        sh 'mvn test'
                    }
                }

                stage('Static Analysis - SonarQube') {
                    steps {
                        withSonarQubeEnv('SonarQube') {
                            sh 'mvn sonar:sonar'
                        }
                    }
                }
            }
        }

        stage('Quality Gate') {
            steps {
                timeout(time: 2, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }

        stage('Package') {
            steps {
                sh 'mvn package -DskipTests'
                archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
            }
        }


    }
}