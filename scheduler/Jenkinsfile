pipeline {
    agent { label 'nodejs' }
    parameters {
        string(name: 'image', defaultValue: 'v2.0.9-occ', description: 'Docker image to use')
        //string(name: 'root_cert', defaultValue: '', description: 'Root certificate to inject')
    }
    stages {
		stage('build Image'){
		    steps{
				sh label: '', script: 'docker build -t vvp-appmanager:2.0.9-occ .'
			}
		}
         }
}
