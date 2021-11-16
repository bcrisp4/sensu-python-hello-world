from distutils.core import setup

setup(
    name='hello_world',
    version='0.1.0',
    description='Hello, World!',
    author='Ben Crisp',
    author_email='ben@thecrisp.io',
    packages=['hello_world'],
    entry_points={
        'console_scripts': [
            'hello-world = hello_world.main:main'
        ]
    },
)

