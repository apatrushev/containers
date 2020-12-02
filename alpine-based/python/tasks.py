import invoke

from spherical.dev import docker
from spherical.dev.tasks import flake, isort  # noqa: F401


@invoke.task(pre=[
    invoke.call(
        docker.install,
        image='python:2',
        args={'PYTHON_VERSION': '2'}
    ),
    invoke.call(
        docker.install,
        image='python:3',
        args={'PYTHON_VERSION': '3'}
    ),
])
def install(ctx):
    pass
