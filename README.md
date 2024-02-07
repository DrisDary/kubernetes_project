#Step 1 - Build Infustructure

The folder called tf_k8_project_IaC contains the terraform copde to deploy all the resources required to run this solution.

Please refer to the https://github.com/DrisDary/terraform_project_IaC as an example guide to deploy this IaC.

Step 2 - Setup GitHub Actions

The folder called project contains a simple Django application that calls a azure sql server and extracts data from the database.

Also inside this application folder you will find inside the .github folder a workflow file which is part is part of our github actions worflow. It will be triggered everytime the application code is changed and it will use the docker file to rebuild the image.

The folder called k8_manifests contains the Kubernetes Manisfest which is a deployment manifest and two service manifests. 

In order for you workflow file to work you must you setup your GitHub secrets. Under repository settings you can create new secrets and please make sure that the secret name are spelt as in the workflow file. Setup the following four secrets 

DOCKERHUB_USERNAME 
DOCKERHUB_PASSWORD
GIT_USERNAME
GIT_PASSWORD

Step 3 - Setup ArgoCD

Hopefully, your AKS cluster is up and running in Azure from step 1. If so, then open an terminal and with your azure credentials log into azure CLI using:

az login


Choose the subcription you delpoyed your AKS cluster from step 1 using :

az account set --subscription XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX

In order to communication with your AKS cluster run the following command:

az aks get-credentials --resource-group django_project --name djangoappcluster --overwrite-existing

Remember that django_project is the recource group name set in the IaC files from step 1 and djangoappcluster is the name of your AKS cluster.

Please not that kube ctl should already be installed as part the CLI but if not then run the following command:

az aks install-cli

Now we are ready to install ArgoCD by running the following commands:

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

You can verify your installation using:

kubectl get pods -n argocd

Now that Argo CD is setup within your AKS cluster, please Download the Argo CD from  https://github.com/argoproj/argo-cd/releases/latest.

We are ready to add our project application from our git repository but before doing so, we must set the current namespace to argocd using:

kubectl config set-context --current --namespace=argocd

Then, using the argocd CLI add the project repo as such:

argocd app create django-app --repo https://github.com/DrisDary/kubernetes_project/k8_manifests.git --dest-server https://kubernetes.default.svc --dest-namespace default

Running this should complete your project and you should be able to make commits to applciation and see changes in your Kubernetes cluster.

NOTES:

Please set appropirate names for username, password, sqlservername, database_name found in:

k8_manifests\djangoapp.yaml

project\project\settings.py

tf_k8_project_IaC\main.tf

Please condsider using secrets for the password and sqlservername and database. 