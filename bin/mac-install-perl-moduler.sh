#!/bin/bash
for i in Mojo::Base Role::Tiny;
do cpanm -i $i;
done

for j in Git::Repository ;
do cpanm -i $j --force;
done