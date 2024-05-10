#!/bin/sh
podman machine ssh 'sudo rpm-ostree upgrade --bypass-driver'
