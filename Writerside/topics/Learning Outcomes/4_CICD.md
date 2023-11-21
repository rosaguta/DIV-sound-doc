# CI/CD

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

## Gitlab Pipelines
After transitioning from GitHub to Gitlab (not the Fontys one), I've set up Gitlab pipelines with the following configuration:

![Gitlab Pipelines](gitlab_dependency.png)

#### Unittest
In the following piece of YAML, a job is configured to download a Docker image, run it, and execute the `dotnet test` command inside that container.

```yaml
stages:
  - build

variables:
  Solution_Name: "DIV-SOUND-backend.sln"
  Test_Project_Path: UnitTest/UnitTest.csproj

test:
  tags:
    - backend
  stage: build
  script:
    - ls DIV-SOUND-backend
    - pwd
    - dotnet test $Test_Project_Path
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

These improvements aim to provide clearer explanations and enhance readability.