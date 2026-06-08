#!/bin/bash
if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
  echo "Usage: workspace-remaining [namespace]"
  echo ""
  echo "Lists all pods in a namespace with their workspace deadlines and remaining time."
  echo ""
  echo "Arguments:"
  echo "  namespace    The namespace to list pods from (default: workspace-crab)"
  echo ""
  echo "Examples:"
  echo "  workspace-remaining                    # uses default namespace"
  echo "  workspace-remaining workspace-crab     # uses specified namespace"
  exit 0
fi

NAMESPACE=${1:-workspace-crab}

PODS=$(kubectl get pods -n $NAMESPACE -o jsonpath='{.items[*].metadata.name}' 2>/dev/null)

if [ -z "$PODS" ]; then
  echo "No pods found in namespace '$NAMESPACE'"
  exit 0
fi

NOW=$(date -u +%s)

printf "%-40s %-35s %-15s\n" "POD" "DEADLINE" "REMAINING"
printf "%-40s %-35s %-15s\n" "---" "--------" "---------"

for POD in $PODS; do
  DEADLINE=$(kubectl get pod $POD -n $NAMESPACE -o jsonpath='{.metadata.annotations.workspace/delete-after}' 2>/dev/null)
  if [ $? -ne 0 ]; then
    printf "%-40s %-35s %-15s\n" "$POD" "N/A" "Error reading pod"
    continue
  fi
  if [ -z "$DEADLINE" ]; then
    printf "%-40s %-35s %-15s\n" "$POD" "N/A" "No deadline set"
    continue
  fi
  DEADLINE_EPOCH=$(date -d "$DEADLINE" +%s 2>/dev/null)
  if [ $? -ne 0 ]; then
    printf "%-40s %-35s %-15s\n" "$POD" "$DEADLINE" "Invalid deadline"
    continue
  fi
  REMAINING=$(( DEADLINE_EPOCH - NOW ))
  if [ $REMAINING -le 0 ]; then
    printf "%-40s %-35s %-15s\n" "$POD" "$DEADLINE" "Expired"
    continue
  fi
  HOURS=$(( REMAINING / 3600 ))
  MINUTES=$(( (REMAINING % 3600) / 60 ))
  printf "%-40s %-35s %-15s\n" "$POD" "$DEADLINE" "${HOURS}h ${MINUTES}m"
done