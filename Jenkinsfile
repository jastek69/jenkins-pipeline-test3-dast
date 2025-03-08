pipeline {
    agent any
    environment {
        AWS_REGION = 'us-west-1' 
    }
    stages {
        stage('Set AWS Credentials') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'jenkins' 
                ]]) {
                    sh '''
                    echo "AWS_ACCESS_KEY_ID: $AWS_ACCESS_KEY_ID"
                    aws sts get-caller-identity
                    '''
                }
            }
        }
        
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/jastek69/jenkins-pipeline-test3-dast.git'
            }
        }
        
        // DAST
        stage('Dastardly') {
      agent {         
       docker {          
         image 'public.ecr.aws/portswigger/dastardly:latest'         
     }       
    }       
    steps {
        cleanWs()
        sh '''
            docker run --user $(id -u) -v ${WORKSPACE}:${WORKSPACE}:rw \
            -e BURP_START_URL=https://ginandjuice.shop/ \
            -e BURP_REPORT_FILE_PATH=${WORKSPACE}/dastardly-report.xml \
            public.ecr.aws/portswigger/dastardly:latest
        '''
    }


        stage('Initialize Terraform') {
            steps {
                sh '''
                terraform init
                '''
            }
        }

        stage('Plan Terraform') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'jenkins'
                ]]) {
                    sh '''
                    export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
                    export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
                    terraform plan -out=tfplan
                    '''
                }
            }
        }

        stage('Apply Terraform') {
            steps {
                input message: "Approve Terraform Apply?", ok: "Deploy"
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'jenkins'
                ]]) {
                    sh '''
                    export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
                    export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
                    terraform apply -auto-approve tfplan
                    '''
                }
            }
        }
    } // END Stages

    post {
        always {
            junit testResults: 'dastardly-report.xml', skipPublishingChecks: true
        }

        success {
            echo 'Terraform deployment completed successfully!'
        }
        failure {
            echo 'Terraform deployment failed!'
        }
    } // END post
} // END pipeline
