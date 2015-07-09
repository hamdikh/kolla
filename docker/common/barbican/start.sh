#!/bin/bash

set -o errexit

CMD="uwsgi"
ARGS="--master --emperor"

# Loading common functions.
source /opt/kolla/kolla-common.sh

# Config-internal script exec out of this function, it does not return here.
set_configs

# Bootstrap and exit if KOLLA_BOOTSTRAP variable is set. This catches all cases
# of the KOLLA_BOOTSTRAP variable being set, including empty.
if [[ "${!KOLLA_BOOTSTRAP[@]}" ]]; then
    su -s /bin/sh -c "barbican-manage db_sync" barbican
    exit 0
fi

exec $CMD $ARGS

