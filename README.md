# sensu-python-hello-world
A proof-of-concept Sensu Go asset for Python-based checks with module dependencies.

`build_asset.sh` simply installs the `hello_world` module + any dependencies in `requirements.txt` to a temporary directory and wraps it all up in a tarball. The project must have a `setup.py` with the required script and/or endpoints declared

`python3` must be available in `$PATH` on any entity with checks that use this asset. e.g. by installing it with the system package manager, or with some kind of "python runtime" asset (like: https://github.com/jspaleta/sensu-python-runtime)

Checks must set `$PYTHONPATH` to include the asset `lib/` dir. See `example_definitions.yaml`.
