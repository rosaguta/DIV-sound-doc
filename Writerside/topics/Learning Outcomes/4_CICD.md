# CI/CD

>**Learning outcome**
>
>You implement a (semi)automated software release process that matches the needs of the project context.
>
>**Clarification**
>
>Implement: You implement a continuous integration and delivery solution (using e.g. Gitlab CI and Docker).

## GitHub Actions
For early testing purposes, I've configured a GitHub Actions workflow to test a C# application and push it to Docker Hub.

![GitHub Actions](github_actions.png)

Here's the YAML configuration behind the GitHub Actions:

```yaml
name: .NET Core Desktop

on:
  push:
    branches: [ "main" ]
  pull_request:
    branches: [ "main" ]

jobs:

  build:

    strategy:
      matrix:
        configuration: [Debug, Release]

    runs-on: ubuntu-latest

    env:
      Solution_Name: testwebapp.sln
      Test_Project_Path: TestProject1\TestProject1.csproj

    steps:
    - name: Checkout
      uses: actions/checkout@v3
      with:
        fetch-depth: 0

    - name: Execute unit tests
      run: dotnet test

    - name: Login to Docker Hub
      uses: docker/login-action@v3
      with:
        username: ${{ secrets.DOCKER_USERNAME }}
        password: ${{ secrets.DOCKER_PASSWORD }}

    - name: Build and push Docker image
      run: |
        docker build . -t testwebapp:latest -f ./testwebapp/Dockerfile
        docker tag testwebapp:latest digitalroseuwu/testwebapp:latest
        docker push digitalroseuwu/testwebapp:latest
```
# Backend(API)

## Gitlab Pipelines
After transitioning from GitHub to Gitlab (not the Fontys one), I've set up Gitlab pipelines with the following configuration:

![gitlab_dependency2.png](gitlab_dependency2.png)
#### Unittest
In the following piece of YAML, a job is configured to download a Docker image, run it, and execute the `dotnet test` command inside that container.

```yaml
stages:
  - build
  - merge
  - final_test


test:
  tags:
    - backend
  stage: build
  script:
    - dotnet test
  only:
    - master
  image: mcr.microsoft.com/dotnet/nightly/sdk:7.0
```

If the unittest succeeds without an error, a job is triggered to build an image from the current repository and push it to Docker Hub. Here's the relevant part of the YAML:

```yaml
build:
  tags:
    - backend
  image: docker:20.10.16
  stage: build
  services:
    - docker:20.10.16-dind
  script:
    - echo "super_secret_password" | docker login $DOCKERHUB_URL -u digitalroseuwu --password-stdin     
    - docker build . -t digitalroseuwu/div-sound-backend:latest -f ./DIV-SOUND-backend/Dockerfile
    - docker push digitalroseuwu/div-sound-backend:latest
  only:
    - master
  needs:
    - test
```

If that job also completes without failure, the following job gets ran:

```yaml
push_to_main:
  tags:
    - backend
  stage: merge
  script:
    - apk update
    - apk add git
    - git config --global user.email "rvleeuwen@DigitalIndividuals.com"
    - git config --global user.name "Rose van Leeuwen"
    - cd $TMPDIR || exit 1
    - credentials=$(echo -n ":$pat" | base64)
    - git clone https://r.vanleeuwen:<PAT>@git.digitalindividuals.com/rvleeuwen/div-sound-backend.git || exit 1
    - cd div-sound-backend || exit 1
    - git branch
    - echo "$CI_COMMIT_MESSAGE"
    - echo "merging from Development to main"
    - git pull -a
    - git merge origin/master -X theirs -m "$CI_COMMIT_MESSAGE"
    - git push origin main
    - echo $mergeMessage
  only:
    - master
  needs:
    - build
```

This job is responsible for merging the ``master`` branch to the main branch
(the ``master`` branch is my development branch, but I'm too lazy to change it)

I also have the following job in the main branch:

```yaml
main_test:
  tags:
    - backend
  stage: final_test
  only:
    - main
  script:
    - apt-get update
    - apt-get install -y openjdk-21-jdk
    - ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64
    - ENV PATH $PATH:$JAVA_HOME/bin
    - export PATH="$PATH:/root/.dotnet/tools"
    - dotnet tool install --global dotnet-sonarscanner
    - export SONAR_TOKEN=0ee26b65d77314b8c278ecd08863e68764f6a247
    - dotnet sonarscanner begin /o:digitialindividuals /k:digitialindividuals_digitialindividuals /d:sonar.host.url=https://sonarcloud.io
    - dotnet test
    - dotnet sonarscanner end
  image: mcr.microsoft.com/dotnet/nightly/sdk:7.0
```

This job ensures that the last available code in the main branch viable is to clone / run


# Frontend

For the frontend I wrote a simple pipeline that executes the tests i wrote in the CI/CD

Here follows the `gitlab.yml` config

```yaml
stages:
  - test


e2efirefox:
    tags:
        - backend
    image: cypress/browsers:node-20.9.0-chrome-118.0.5993.88-1-ff-118.0.2-edge-118.0.2088.46-1
    stage: test
    script:
    # install dependencies
    - npm ci
    # start the server in the background
    - echo -e "NEXT_PUBLIC_AUDIO_API=http://138.201.52.251:9999\nNEXT_PUBLIC_SOCKET=http://138.201.52.251:9997" > .env.local

    - npm run build; npm start &
    # run Cypress tests
    - npx cypress run --browser firefox
```


Normally I would write something that would build a docker image of the frontend based on the results of the tests but i am not able to write a docker image for the frontend. If i want to create a docker image for my frontend i would need to make a docker in docker image.

I do have a `dockerfile` that builds the frontend

```yaml
# Use the official Node.js image as the base image
FROM node:latest

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install project dependencies
RUN npm install

# Copy the entire project to the working directory
COPY . .
ARG NEXT_PUBLIC_AUDIO_API
ARG NEXT_PUBLIC_SOCKET
# Build the Next.js project
RUN npm run build

# Expose the port that the Next.js app will run on
EXPOSE 3000

# Command to start the Next.js app
CMD ["npm", "run", "start"]

```

There are indeed some `ARG`'s for specifying some API's but these arnt used 