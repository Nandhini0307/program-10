# program-10
Manage simple web application using Kubernetes
1. Set Up Kubernetes Environment
Make sure you have:
•	A Kubernetes cluster (local or cloud-based).
•	kubectl installed and configured to interact with your cluster.
2. Dockerize Your Web Application
If you haven’t already, you need to containerize your web application. Here’s a simple example using an NGINX web server.
Create index.html for your Web Application:
<!DOCTYPE html>
<html>
<head>
    <title>My Web App</title>
</head>
<body>
    <h1>Welcome to My Web Application</h1>
</body>
</html>

Create a Dockerfile:

# Use the official NGINX image from Docker Hub
FROM nginx:alpine

# Copy the content of the current directory to NGINX's static files directory
COPY . /usr/share/nginx/html

Build and Tag the Docker Image:
docker build -t mywebapp:1.0 .

3. Push Docker Image to Container Registry (Optional)
If using a cloud Kubernetes service, you may need to push your image to Docker Hub or another registry.
docker tag mywebapp:1.0 <your-dockerhub-username>/mywebapp:1.0
docker push <your-dockerhub-username>/mywebapp:1.0

4. Create a Kubernetes Pod
A Pod is the smallest deployable unit in Kubernetes. Create a YAML configuration file for your Pod.
pod.yaml:
apiVersion: v1
kind: Pod
metadata:
  name: mywebapp-pod
  labels:
    app: mywebapp
spec:
  containers:
  - name: mywebapp-container
    image: <your-dockerhub-username>/mywebapp:1.0
    ports:
    - containerPort: 80
Deploy the Pod:
kubectl apply -f pod.yaml
Verify the Pod:
kubectl get pods
5. Create a Kubernetes Deployment
Deployments manage the desired state of your application, including scaling and updates.
Create deployment.yaml:
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mywebapp-deployment
  labels:
    app: mywebapp
spec:
  replicas: 3
  selector:
    matchLabels:
      app: mywebapp
  template:
    metadata:
      labels:
        app: mywebapp
    spec:
      containers:
      - name: mywebapp-container
        image: <your-dockerhub-username>/mywebapp:1.0
        ports:
        - containerPort: 80
Deploy the Deployment:
kubectl apply -f deployment.yaml
Verify the Deployment:
kubectl get deployments
kubectl get pods
6. Expose the Web Application
To access your web application outside the cluster, create a Service.
Create service.yaml:
apiVersion: v1
kind: Service
metadata:
  name: mywebapp-service
spec:
  selector:
    app: mywebapp
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: LoadBalancer

Deploy the Service:
kubectl apply -f service.yaml
Verify the Service:
kubectl get services

7. Access the Web Application
After exposing the service, get the external IP address and access your web application.
kubectl get services mywebapp-service
