pipeline {
    agent { label 'linux' }
    parameters {
        string(name: 'image', defaultValue: '2.0.9-occ', description: 'Docker image to use')
        //string(name: 'root_cert', defaultValue: '', description: 'Root certificate to inject')
    }
    stages {
		stage('build Image'){
		    steps{
				docker build -t vvp-appmanager-${params.image} -f scheduler/Dockerfile .
			}
		}
  }
