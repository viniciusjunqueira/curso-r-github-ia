#!/bin/bash

cd /Users/viniciusjunqueira/Library/CloudStorage/OneDrive-Pessoal/Cursos/curso-r-github-ia

cp -r materiais/_book/* docs/
rm docs/*pdf

touch .nojekyll
git add docs/ .nojekyll
git commit -m "Add rendered HTML book for GitHub Pages"
git push

