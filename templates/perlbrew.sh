pathmunge  {{ perlbrew_root }}/bin
export PERLBREW_ROOT={{ perlbrew_root }}
source ${PERLBREW_ROOT}/etc/bashrc
perlbrew switch {{ default_perl }}
