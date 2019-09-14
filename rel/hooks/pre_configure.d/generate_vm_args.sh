#!/usr/bin/env bash
# hooks/pre_configure.d/generate_vm_args.sh

echo "Started generate_vm_args.sh"

export SYNC_NODES_MANDATORY

if [ -z "$HOSTNAME" ]; then
  echo 'Expected $HOSTNAME to be set in the environment, unable to configure mandatory nodes!'
  exit 1
fi

if [ -z "$NODES" ]; then
  SYNC_NODES_MANDATORY=""
else
  for node in ${NODES//,/ }; do
    if [ -z "$SYNC_NODES_MANDATORY" ]; then
      SYNC_NODES_MANDATORY="\"${node}@${HOSTNAME}\""
    else
      SYNC_NODES_MANDATORY="${SYNC_NODES_MANDATORY},\"${node}@${HOSTNAME}\""
    fi
  done
fi