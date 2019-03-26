#!/bin/bash
find /root -name "*.gz" -exec tar xf {} \;
find /root -name "*.gz" -exec rm -f {} \;

