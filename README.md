# *interpn* 

a multi-dimensional linear interpolation in R based on the Scilab function [linear_interpln](https://help.scilab.org/docs/6.0.2/en_US/linear_interpn.html)

# Licence

[GNU GPL](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html) v2


## Exécution des tests

Possibilité de tester des développements, utiliser les outils du paquets `devtools` en exécutant, depuis la racine du paquet :
```
`$ Rscript -e 'devtools::load_all(".")' -e 'testthat::test_dir("tests/testthat")'
```

Pour tester un seul fichier de test :
```
`$ Rscript -e "devtools::load_all('.')" -e "testthat::test_file('tests/testthat/<nom_test>.R')"
```
