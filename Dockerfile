# Use the official NGINX image from Docker Hub
FROM nginx:alpine

# Copy the content of the current directory to NGINX's static files directory
COPY . /usr/share/nginx/html
