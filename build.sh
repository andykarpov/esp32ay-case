#!/usr/bin/env bash

openscad-nightly -o release/v3_lid.stl -p v3.json -P "Print Lid" v3.scad
openscad-nightly -o release/v3_base.stl -p v3.json -P "Print Base" v3.scad

