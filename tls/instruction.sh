#!/bin/bash

# Generate a new Private Key and Certificate Signing Request
# Out: server.csr, server.key
openssl req -new -sha256 -nodes -out server.csr -newkey rsa:2048 -keyout server.key -config cert.cnf

# Generate a self-signed Private Key
# Out: ca.key
openssl genrsa -passout pass:1111 -des3 -out ca.key 4096

# Generate a self-signed Certificate for clients
# Out: ca.crt
openssl req -passin pass:1111 -new -x509 -days 365 -key ca.key -out ca.crt -subj "/CN=TLS_SERVER"

# Generate Certificate for servers
# Out: server.crt
# openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt -extensions v3_req -extfile cert.cnf
openssl x509 -req -passin pass:1111 -days 365 -in server.csr -CA ca.crt -CAkey ca.key -set_serial 01 -out server.crt -extensions v3_ca -extfile cert.cnf

openssl pkcs8 -topk8 -nocrypt -passin pass:1111 -in server.key -out server.pem