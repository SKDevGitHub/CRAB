# Guide to Managing Your Pods

This is a quick guide made to help you understand how to create a pod within your team's workspace.

Note: If you are revisiting this and already have an account, skip steps 0 and 1.

## Step 0: Before Anything

Ensure you have the `kubectl` binary installed locally, as this is the new primary way of accessing your containers, as ssh was removed as an entrypoint.

An easy way to verify is run the following.

```{bash}
kubectl version
```

If anything is returned back, you have the binary. Otherwise, please follow the instructions from [here](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/) to retrieve the binary.

## Step 1: Request An Account

You do not have an account by default to work in the namespace where all of your work is done. This is done manually, which involves contacting an active administrator of the cluster.

You will be provided an account and kube configuration file if the request is approved.

Move the file to the following directory on your home.

```{bash}
mv <Current File Location> ~/.kube/config
```
Note: Additional instructions will be provided by the administrator, which are not included here for the sake of privacy.

If all is done correctly, you should be able to run `kubectl` and interact with the cluster.

## Step 2: Request a Pod to Work in

You can think of Kubernetes as a system that takes in requests from users and handles them as it best sees fit. In your case, you want to be able to give yourself a working environment. Provided is a template file, which you can run the following to make a copy configured to your account name.

```{bash}
sed 's/<USERNAME>/<YOURNAMEHERE>/g' pod-template.yaml > pod-<YOURNAMEHERE>.yaml
```

Note: Do not change the `<USERNAME>` part of that command, as that is what gets substituted out.

Apply the pod yaml with the following command.

```{bash}
kubectl apply -f pod-<YOURNAMEHERE>.yaml
```
And view it with the following.

```{bash}
kubectl get pods -n <NAMESPACE>
```


Note: If you request resources that are unavailable at the moment, the pod may show being stuck in `PENDING`. For more information, you can run the following to diagnoise it manually.

```{bash}
kubectl describe pod -n <NAMESPACE> <PODNAME>
```

Note: You can always ask the administrator if you have any questions regarding your pod.

## Step 3: Dealing With Pod Lifetime

Pods within your environment do not last forever if left unattended for too long. Two shell scripts have been provided to better know how long your pod has and how to extend its lifetime.

To see how much time is left for pods in your namespace, run the following script.

```bash
bash workspace-remaining.sh [NAMESPACE]
```

You will be provided how much time is left for your pod before the deletionpolicy may potentially take it.

To extend the time of your pod, let's say by 6 hours, you can run the following.

```bash
bash workspace-extend.sh <PODNAME> 6h [NAMESPACE]
```

It may not provide the full 6 hours on top of the existing time, as it has an upper limit on how much time the pod itself can be extended to.

If you have any further questions, you can run both shell scripts with `--help` to get more info regarding them.

## Extra

These instructions are subject to change overtime, consider them more like a basic tutorial to get yourself going rather than the absolute guidebook for Kubernetes.