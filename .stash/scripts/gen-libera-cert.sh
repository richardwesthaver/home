#!/bin/sh
openssl req -x509 -new -newkey rsa:4096 -sha256 -days 365 -nodes -out libera.pem -keyout libera.pem
