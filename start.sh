#!/bin/bash
docker run -u root -d -p 10022:22 -p 18080:8080 --name jenkins -v ~/.docker/jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock beyondspider/jenkins:latest
