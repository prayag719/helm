# python demo application

## image

```bash

# build the image
> docker image build -t pythoncpp/backend .

# login to docker hub account
# > docker login
> echo <docker token> | /usr/local/bin/docker login -u <username> --password-stdin

# push the image to docker hub
> docker image push pythoncpp/backend

# add the user jenkins in docker group
> sudo usermod -aG docker jenkins

```

## create service

```bash

# create a docker service
> docker service create --name backend -p 4000:4000 --replicas 2 pythoncpp/backend

# verify the application
> curl http://localhost:4000

# remove the service
> docker service rm backend

```

## kubernetes

```bash

# create a helm chart
> helm create backend-chart

# remove all default template files from backend-chart
> cd backend-chart/templates
> rm -rf *

# clean the values.yaml file and keep only following content
replicaCount: 2
image:
  tag: ''

# create deployment.yaml under backend-chart/templates
apiVersion: apps/v1
kind: Deployment
metadata:
  name: backend
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      type: backend
  template:
    metadata:
      labels:
        type: backend
    spec:
      containers:
        - name: container1
          image: pythoncpp/backend
          ports:
            - containerPort: 4000

# create service.yaml under backend-chart/templates
apiVersion: v1
kind: Service
metadata:
  name: backend
spec:
  type: NodePort
  selector:
    type: backend
  ports:
    - port: 4000
      targetPort: 4000


# install the helm chart
> helm install backend ./backend-chart

# get the minikube ip
> minikube ip

# verify if the application is running on port 4000
# > curl http://<minikube-ip>:<service node port>

# get the list of helm charts installed
> helm list

# uninstall the chart
> helm uninstall backend

```

## jenkins for docker service

```bash

# build the docker image
/usr/bin/docker image build -t <username>/backend .

# login on docker hub
# echo <token> | /usr/local/bin/docker login -u <username> --password-stdin

# push image to docker hub
/usr/bin/docker image push <username>/backend

# remove the running service
/usr/bin/docker service rm backend

# create service with latest version of image
/usr/bin/docker service create --name backend -p 4000:4000 --replicas 2 <username>/backend


```

## jenkins for kubernetes

```bash

# build the docker image
/usr/bin/docker image build -t <username>/backend .

# login on docker hub
# echo <token> | /usr/local/bin/docker login -u <username> --password-stdin

# push image to docker hub
/usr/bin/docker image push <username>/backend

# uninstall existing chart
/snap/bin/helm uninstall

# install chart
/snap/bin/helm install backend ./backend-chart

```

## configure jenkins to send email

```bash

# create a new app password
> https://myaccount.google.com/apppasswords

# smtp server: smtp.gmail.com
# smtp port: 465
# use SSL: true


```
