# CRAB Robotics Cluster Environment Setup

This repository is used by researchers at the CRAB Robotics Lab for sharing **resources** from the papers we read and write, organized for quick and easy access with a Python API.

What do we mean by **"resources"**? Basically, it's four things:

1. **Datasets** for training ML algorithms
2. **Algorithms** for controlling robots
3. **Simulation Setups** for testing and reinforcement learning
4. **Benchmarks** comparing algorithms across different tasks

The more **resources** are added, the easier it is to compare different approaches. By maintaining a convenient API, it becomes easy to build off other researchers' contributions. Hopefully, this system will help increase our quality and quanity of publications.

## Storage Partitioning Setup

Now obviously, ML datasets are too big to fit in a Git repository. This repo exists to back up all of our code and docs. In fact, the contents of the `datasets` directory is purposefully ignored in this repo's `.gitigore`.

This repo should be cloned onto our lab's GPU cluster. Everything in the repo lives on a shared volume mount accessible by all robotics researchers, except for the `datasets` directory. 

The `datasets` directory is stored on a separate volume mount from the rest of the repository. This serves as damage control for when someone inevitably downloads a huge dataset that takes up all available storage.

## How to Contribute

### Datasets

- Store datasets and large DNN ("AI") models in the `datasets` directory, but **don't `git commit` them**.
- TODO: Specify exactly how to use HF interface

### Algorithms

If you copy the format of `JanusVLN`, you are ~90% done already.
Here are the specific requirements:

1. Decide what you want the interface for accessing your algorithm to be called. Use `CamelCase`.

- For example, if I was integrating the Deep Q Network from Reinforcement Learning, I'd use a name like: `DeepQNetwork`

2. Make a directory in the `sim_and_algo_code` directory and name it using the interface name you created in the previous step.

- For example: `mkdir sim_and_algo_code/DeepQNetwork`

3. In the directory you just made, create a directory called `CRAB/algo/NAME` or `CRAB/algo/CATEGORY/NAME`, replacing `NAME` with the interface name from step 1, and `CATEGORY` with some category of algorithm for organization purposes.

- For example: `CRAB/algo/DeepQNetwork` or `CRAB/algo/RL/DeepQNetwork`

4. The directory you made in step 3 should store all the code necessary to implement the algorithm in question. Use a Git submodule if relying on somebody else's code. If not, then happy coding!

- Organize your implementation into subdirectories as needed.

- If you need to use large DNN-based models or large datasets which are too big to fit in a Git repo, put them in the `datasets` directory and make your algorithm load them from there.

- Keep track of any required dependencies. You will need to know them for steps 6 and 7.

5. Make an `__init__.py` file in the directory you created in step 3. In this file, wrap all of your algorithm's functionality inside a single class. This class should be named using the interface name you created in step 1.

- Document your wrapper class! Assume that the person reading your docs understands **what the algorithm does** but does not fully understand **why it works**. All they need to know from your docs is **how to use your implementation**.

6. Make a `README.md` file next to your `__init__.py` and link the relevant research papers, project page, github, HuggingFace datasets, etc. If there are any **extra steps** necessary to get your code working, document them here. By **extra steps**, we mean anything you couldn't specify in a `pyproject.toml` config file.

7. By this step you have created a `pip` package. In the folder you made in step 2, create a `pyproject.toml` for it, and specify package dependencies.