#!/bin/bash -ex

service cron start
service nmbd start
service smbd start

# Keep alive after starting service(s).
sleep infinity

