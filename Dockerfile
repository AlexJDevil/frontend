# Specify our base image to be used on BUILD phase
FROM node:16-alpine as builder

# Specify the working dir for my application
WORKDIR '/usr/frontend'

# Copy the node server dependencies
COPY ./package.json /usr/frontend/

# Install node server
RUN npm install

# Copy all my source code
COPY ./ /usr/frontend/

# Builds a production version of the application
RUN npm run build

# Specify an image to be used on RUN phase
FROM nginx

# Way to expose a port in Elastic Beanstalk
EXPOSE 80

# Copy over the build folder into this nginx image
COPY --from=builder /usr/frontend/build /usr/share/nginx/html

# There is no need to start nginx, it starts when container is created