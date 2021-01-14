# Python on Alpine

Builds on Alpine Python, creates a virtualenv in `/root/.venv`, and adds black, flake8, isort, pylint and psycopg2-binary into the final image.

## Building

```sh
make [ PYHTON_VERSION=<version> ]

# or simply
make
```

