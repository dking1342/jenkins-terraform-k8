pipeline {
  agent any
  stages {
    stage('Terraform Init') {
      steps {
        sh '''
          cd terraform
          terraform init
        '''
      }
    }

    stage('Terraform Format') {
      steps {
        sh 'cd terraform && terraform fmt -check'
      }
    }

    stage('Terraform Validate') {
      steps {
        sh 'cd terraform && terraform validate -no-color'
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

    stage('Terraform Apply') {
      steps {
        sh '''
          cd terraform 
          terraform apply --auto-approve -var "do_token=${DO_PAT}" -var "pvt_key=~/.ssh/do_key_01" -var "pub_key=~/.ssh/do_key_01.pub"
        '''
      }
    }
    
    stage('doctl init') {
        steps {
            sh '''
              cd terraform 
              if test -f "clusterid.txt"; then 
                rm clusterid.txt
              fi 
              terraform output | grep -Eo '\w{1,}-\w{1,}-\w{1,}-\w{1,}-\w{1,}' > clusterid.txt 
              sed -i '1,2d' clusterid.txt 
              export CLUSTER_ID=$(cat clusterid.txt) 
              doctl kubernetes cluster kubeconfig save $CLUSTER_ID 
              rm clusterid.txt
            '''
        }
    }
    
    stage('remove helm charts') {
        steps {
            sh '''
              helm uninstall mongodb-exporter && \
              helm uninstall nginx-exporter && \
              helm uninstall kube-prom-stack -n monitoring && \
              helm uninstall loki -n loki-stack
            '''
        }
    }
    
    stage('ansible playbook') {
        steps {
            sh '''
              ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i k8s.yaml ./ansible/cluster-install.yaml
            '''
        }
    }
  }
}