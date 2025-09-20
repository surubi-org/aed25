#!/bin/bash

# Activa el entorno virtual
source ./.env/bin/activate

# Inicia el servidor de MkDocs
mkdocs gh-deploy

