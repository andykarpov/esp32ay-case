#!/usr/bin/env bash

openscad-nightly -o release/v3_lid.stl -p v3.json -P "Print Lid" v3.scad
openscad-nightly -o release/v3_base.stl -p v3.json -P "Print Base" v3.scad

openscad-nightly -o release/v4_lid.stl -p v4.json -P "Print Lid" v4.scad
openscad-nightly -o release/v4_base.stl -p v4.json -P "Print Base" v4.scad

openscad-nightly -o release/v5_lid.stl -p v5.json -P "Print Lid" v5.scad
openscad-nightly -o release/v5_base.stl -p v5.json -P "Print Base" v5.scad
