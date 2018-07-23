# conda-recipes

The main idea of this repo is offer a place to store the recipes that will be upload to Quansight Anaconda.org account.

## Workflow

1. All recipes should be have their own branch in the repository (e.g. the package `cudatoolkit` should be created inside the branch `cudatoolkit`).
2. All branches should allow trigger CIs to test the recipes.
3. When you want to add your recipe to master and also want to upload your recipe to anaconda.org/quansight make a PR to `master`.

