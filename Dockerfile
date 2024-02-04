FROM node:14-alpine

# Install bash to use 'wait-for-it'
RUN apk update && apk add bash && apk add --no-cache coreutils

# Set an environment variable to store where the app is installed to inside
# of the Docker image.
ENV APP_HOME /app

# This sets the context of where commands will be ran in and is documented
# on Docker's website extensively.
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

# Copy code from working directory outside Docker to working directory inside Docker
COPY . .
# Install packages
RUN yarn install

# Set stop signal to SIGQUIT for graceful shutdown
STOPSIGNAL SIGQUIT

EXPOSE 5000

CMD ["yarn", "dev"]
