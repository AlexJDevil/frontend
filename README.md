# React Application inside Docker container deployed into AWS Elastic Beanstalk

<br />

## Project Overview
* Creating a React Application
```yaml
   npx create-react-app frontend
```
* Running the app in the development mode
```yaml
   npm start
```
* Accessing the app from your a browser
```yaml
   http://localhost:3000
```
* Running tests on the app
```yaml
   npm run test
```
* Stop the app by pressing `ctrl-c`
* Wrap it inside a Docker container, using `Dockerfile.dev`
* When building our image we don't copy `node_module` dependencies from local folder, by adding to `.dockerignore`  
```yaml
   docker image build . -t alexjdevil/frontend-dev:v1.0 -f Dockerfile.dev
   docker image ls
```
* Creating a container from the image and access the app from your browser
```yaml
   docker container run --rm --name frontend-dev --publish 3000:3000 alexjdevil/frontend-dev:v1.0
```
* Configuring Docker volumes to reduce the number of builds, after changes to source code, any change to source code will be instantly reflected in the app
```yaml
   docker container run --rm --name frontend-dev --publish 3000:3000 --volume /usr/frontend/node_modules --volume $(pwd):/usr/frontend
```
* Another way of doing all the above by using Docker Compose, `docker-compose-dev.yaml`
```yaml
   docker compose -f ./docker-compose-dev.yaml up --build
   docker compose -f ./docker-compose-dev.yaml down
```
* Accessing the app from a browser
```yaml
   http://localhost:3000
```
* Moving the app to Production environment, where we will use `nginx` as webserver, and multi-stage `Dockerfile`
```yaml
   docker build . -t alexjdevil/frontend-prod:v1.0 -f Dockerfile
```
* Starting the container in Production
```yaml
   docker container run --name frontend-prod --rm --detach --publish 8080:80 alexjdevil/frontend-prod:v1.0
```
* Accessing our app from a browser
```yaml
   http://localhost:8080
```
* Using GitHub Actions to test and upload our app into Docker Hub
```yaml
   .github/workflows/build_test_app.yaml
   .github/workflows/build_push_app_docker_hub.yaml 
```
* Using GitHub Actions to Deploy our app into AWS Elastic Beanstalk
```yaml
   .github/workflows/deploy_aws_ebs.yaml
```
<br />

## Application manifest files
```yaml
   .dockerignore
   docker-compose.yaml
   Dockerfile.dev
   Dockerfile
   package.json
   package-lock.json
   README.md
```
<br />
<br />

## Links
* Create React App: (https://github.com/facebook/create-react-app).
* Create App documentation: https://facebook.github.io/create-react-app/docs/getting-started 
* frontend image on Docker Hub: https://hub.docker.com/repository/docker/alexjdevil/frontend/general

