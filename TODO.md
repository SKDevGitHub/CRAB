- need to change git setting core.sshCommand to reflect non-standard ssh key name
    - git config --global core.sshCommand "ssh -i ~/.ssh/id_ed25519_eliot"
    - change setting in the .gitconfig volume mount (only Michael has access)

- get VNC working, viewing a sim should be as simple as running it in an xterm in the openbox WM in your pod

- document kubectl setup on client (laptop), how to do port-forwarding, how to setup iptables routing for G1
    - explain volume mount: location, purpose

- have a fresh pair of eyes try to replicate a basic sim/algorithm combination, including all the cluster setup steps, and identify the toughest parts of the setup

- need to standardize interface into G1 for testing
    - understand low-level control mechanism from a technical perspective
        - how exactly does control signal get transformed into motor torques with G1 low-level API?
        - document high-level overview of how this works
            - don't need to document all the control theory, if there's prerequisite knowledge that is necessary to read, don't be afraid to link it
    - need a python API that's easy to setup, and efficient under-the-hood
    - something that can take ML output representations commonly used in papers
        - check out papers at: https://github.com/YanjieZe/awesome-humanoid-robot-learning
            - need something more specific, contact Eliot/Stephen
    - high-level locomotion interface (like with controller)
    - low-level whole-body control
    - low-level upper body control while default locomotion controlls lower
    - include hands

- need secure container/job for running stuff on the actual robot
    - keep insecure setup for non-robot use case, root access is convenient for prototyping
    - document the difference between the secure and non secure container setup, and the necessity of both