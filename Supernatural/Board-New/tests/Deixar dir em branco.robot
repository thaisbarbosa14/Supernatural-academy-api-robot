*** Settings ***

Resource    ../resources/frontend.resource

*** Test Cases ***
Cenário 8: Deixar campo nome diretoria em branco e Salvar
  Abrir navegador e acessar site
  Fazer login
  Deixar campo nome diretoria em branco e Salvar