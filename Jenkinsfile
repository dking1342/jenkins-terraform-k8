pipeline {
  agent any
  stages {
    // stage('Tests') {
    //   steps {
    //     sh '''
    //       doctl version
    //       helm version
    //       python3 --version
    //       pip --version
    //       ansible --version
    //       ansible-galaxy --version
    //       terraform --version
    //       ls -la
    //     '''
    //   }
    // }



    stage('Terraform Format') {
      steps {
        sh 'cd terraform && terraform fmt -check'
      }
    }

    stage('Terraform Inits') {
      steps {
        sh 'cd terraform && terraform init'
      }
    }

    stage('Terraform Validate') {
      steps {
        sh 'terraform validate -no-color'
      }
    }

    stage('Terraform Plan') {
      steps {
        sh '''
          cd terraform 
          terraform plan -var "do_token=${DO_PAT}" -var "pvt_key=~/.ssh/do_key_01" -var "pub_key=~/.ssh/do_key_01.pub"
        '''
      }
    }

    // stage('Terraform Apply') {
    //   steps {
    //     sh '''
    //       cd terraform 
    //       terraform apply -auto-approve -var "do_token=${DO_PAT}" -var "pvt_key=~/.ssh/do_key_01" -var "pub_key=~/.ssh/do_key_01.pub"
    //     '''
    //   }
    // }
    
    // stage('File Removal') {
    //     steps {
    //         sh '''
    //           if test -f "./ansible/hosts.ini"; then
    //             rm ./ansible/hosts.ini
    //           fi
    //           if test -f "./ansible/ws.json"; then
    //             rm ./ansible/ws.json
    //           fi
    //           if test -f "./ansible/outputs.json"; then
    //             rm ./ansible/outputs.json
    //           fi
    //         '''
    //     }
    // }
    
    // stage('TF Token') {
    //     steps {
    //         sh '''
    //           curl --header "Authorization: Bearer ${TF_TOKEN}" --header "Content-Type: application/vnd.api+json" "https://app.terraform.io/api/v2/organizations/kavooce1/workspaces/" > ./ansible/ws.json
    //         '''
    //     }
    // }
    
    // stage('Cloud Output') {
    //     steps {
    //         script {
    //             project=""
    //         }
    //         sh '''
    //             project=$(cat ./ansible/ws.json | jq '.data[0].id' | sed 's/\"//g')
    //             curl --header "Authorization: Bearer ${TF_TOKEN}" --header "Content-Type: application/vnd.api+json" "https://app.terraform.io/api/v2/workspaces/${project}/current-state-version?include=outputs" > ./ansible/outputs.json
    //         '''
    //     }
    // }

    // stage('Host File') {
    //     steps {
    //         sh '''
    //             touch ./ansible/hosts.ini
    //             chmod 777 ./ansible/hosts.ini
    //             echo "[droplets]" > ./ansible/hosts.ini
    //         '''
    //     }
    // }

    // stage('Host Inventory') {
    //     steps {
    //         script {
    //             project=""
    //         }
    //         sh '''
    //             project=$(cat ./ansible/ws.json | jq '.data[0].id' | sed 's/\"//g')
    //             curl --header "Authorization: Bearer ${TF_TOKEN}" --header "Content-Type: application/vnd.api+json" "https://app.terraform.io/api/v2/workspaces/${project}/current-state-version?include=outputs" | grep -Eo "[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}" >> ./ansible/hosts.ini
    //         '''
    //     }
    // }

    // stage('Host IPs') {
    //   steps {
    //     sh 'cat ./ansible/hosts.ini'
    //   }
    // }
    
    // stage('Sleep') {
    //   steps {
    //     sh '''
    //       sleep 10
    //     '''
    //   }
    // }

    // stage('Application Playbook') {
    //   steps {
    //     sh 'ansible-playbook -i ./ansible/hosts.ini -e "pub_key=~/.ssh/do_key_01.pub" ./ansible/apache-install.yaml'
    //   }
    // }
  }
}