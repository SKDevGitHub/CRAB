from gymnasium import Env
from abc import ABC, abstractmethod

class Simulator(Env, ABC):
    '''
    All simulators in the CRAB.sim namespace must inherit from this class.

    If you want true compatibility with gymnasium.Env, you will have to make sure
    your funcion overrides use the exact types required in the Gymnasium docs:
    https://gymnasium.farama.org/api/env/
    '''
    def __init__(self, headless: bool):
        self.headless = headless

    @abstractmethod
    def step(self, action):
        pass

    @abstractmethod
    def reset(*, seed, options):
        pass

    def render():
        '''Not always required: see Gymnasium docs'''
        pass

    @abstractmethod
    def close():
        pass