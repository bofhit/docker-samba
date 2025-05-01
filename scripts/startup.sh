#!/bin/bash -ex

service nmbd start
service smbd start

# Keep alive after starting service(s).
sleep infinity

