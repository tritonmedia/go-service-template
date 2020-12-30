name: CI
on:
  pull_request: {}
  push:
    branches:
      - master
      - main

jobs:
  test:
    runs-on: ubuntu-latest
    container:
      image: golang:1.15-alpine
    steps:
      - name: Download OS Dependencies
        run: apk add --no-cache git make bash curl tar gcc libc-dev sudo
      - name: Checkout
        uses: actions/checkout@v2
      - name: Cache Go Dependencies
        uses: actions/cache@v2
        id: go-dep-cache
        with:
          path: /go
          key: v1-${{ "{{" }} runner.os {{ "}}" }}-go-${{ "{{" }} hashFiles('**/go.sum') {{ "}}" }}
          restore-keys: |
            v1-${{ "{{" }} runner.os {{ "}}" }}-go-${{ "{{" }} hashFiles('**/go.sum') {{ "}}" }}
            v1-${{ "{{" }} runner.os {{ "}}" }}-go-
      - name: Download Dependencies
        run: make dep
      - name: Run Tests
        run: make test

  build:
    runs-on: ubuntu-latest
    needs: test
    steps:
      - name: Checkout
        uses: actions/checkout@v2
      - name: Setup QEMU
        uses: docker/setup-qemu-action@v1
        with:
          platforms: all
      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v1
      - name: Cache Docker layers
        uses: actions/cache@v2
        id: buildx-cache
        with:
          path: /tmp/.buildx-cache
          key: v1-${{ "{{" }} runner.os {{ "}}" }}-buildx-${{ "{{" }} hashFiles('**/Dockerfile') {{ "}}" }}
          restore-keys: |
            v1-${{ "{{" }} runner.os {{ "}}" }}-buildx-${{ "{{" }} hashFiles('**/Dockerfile') {{ "}}" }}
            v1-${{ "{{" }} runner.os {{ "}}" }}-buildx-
      - name: Build and Push Docker Container
        env:
          IMAGE_PUSH_SECRET: ${{ "{{" }} secrets.DOCKER_IMAGE_PUSH {{ "}}" }}
        run: .ci/docker-builder.sh
      - name: Notify of Preview Image
        if: github.event_name == 'pull_request' && env.PREVIEW_IMAGE != ''
        uses: unsplash/comment-on-pr@master
        env:
          GITHUB_TOKEN: ${{ "{{" }} secrets.GITHUB_TOKEN {{ "}}" }}
        with:
          msg: "Preview image is available as: `${{ "{{" }} env.PREVIEW_IMAGE {{ "}}" }}`"
          check_for_duplicate_msg: true
