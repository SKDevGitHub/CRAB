#!/bin/bash

if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
  echo "Usage: workspace-extend <pod-name> <duration> [namespace]"
  echo ""
  echo "Extends the deadline of a workspace pod by the specified duration."
  echo "The new deadline cannot exceed 24 hours from now."
  echo ""
  echo "Arguments:"
  echo "  pod-name     The name of the pod to extend"
  echo "  duration     How long to extend by (e.g. 1h, 30m, 2h30m)"
  echo "  namespace    The namespace the pod is in (default: kyverno-ttl-test)"
  echo ""
  echo "Examples:"
  echo "  workspace-extend my-workspace 4h"
  echo "  workspace-extend my-workspace 2h30m workspace-crab"
  exit 0
fi

POD=$1
DURATION=$2
NAMESPACE=${3:-default}

if [ -z "$POD" ] || [ -z "$DURATION" ]; then
  echo "Error: missing required arguments"
  echo "Run 'workspace-extend --help' for usage"
  exit 1
fi

if ! kubectl get pod $POD -n $NAMESPACE &>/dev/null; then
  echo "Error: pod '$POD' not found in namespace '$NAMESPACE'"
  exit 1
fi

kubectl annotate pod $POD workspace/extend=$DURATION --overwrite -n $NAMESPACE &>/dev/null

if [ $? -ne 0 ]; then
  echo "Error: failed to extend pod '$POD'"
  exit 1
fi

echo "Extension requested for '$POD' — new deadline:"
./workspace-remaining.sh $NAMESPACE | grep -E "^$POD|^POD|^---"
