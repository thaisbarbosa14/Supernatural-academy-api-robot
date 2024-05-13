*** Settings ***
Resource  ../resources/supernatural.resource



*** Variables ***


*** Test Cases ***
Cenário: Realizando Login
    Desativar Avisos TLS
    Criar sessão
    Entrar com usuario sysadmin
    Validar o token e gravar em um header de autorização

Cenário: Cadastrando Diretoria
    Desativar Avisos TLS
    Criar sessão
    Entrar com usuario sysadmin
    Validar o token e gravar em um header de autorização
    Criar massa de dados Diretoria
    Cadastrar Diretoria
    Conferir se o cadastro da diretoria foi realizado com sucesso

Cenário: Cadastrando Centro de Custo
    Desativar Avisos TLS
    Criar sessão
    Entrar com usuario sysadmin
    Validar o token e gravar em um header de autorização
    Criar massa de dados Diretoria
    Cadastrar Diretoria
    Conferir se o cadastro da diretoria foi realizado com sucesso
    Criar massa de dados Centro de Custo
    Cadastrar Centro de Custo
    Conferir se o cadastro do Centro de Custo foi realizado com sucesso

Cenário: Cadastrando Departamento
    Desativar Avisos TLS
    Criar sessão
    Entrar com usuario sysadmin
    Validar o token e gravar em um header de autorização
    Criar massa de dados Diretoria
    Cadastrar Diretoria
    Conferir se o cadastro da diretoria foi realizado com sucesso
    Criar massa de dados Centro de Custo
    Cadastrar Centro de Custo
    Conferir se o cadastro do Centro de Custo foi realizado com sucesso
    Criar massa de dados Departamento
    Cadastrar Departamento
    Conferir se o cadastro do Departamento foi realizado com sucesso

Cenário: Inativar um departamento Ativo
   Desativar Avisos TLS
    Criar sessão
    Entrar com usuario sysadmin
    Validar o token e gravar em um header de autorização
    Criar massa de dados Diretoria
    Cadastrar Diretoria
    Conferir se o cadastro da diretoria foi realizado com sucesso
    Criar massa de dados Centro de Custo
    Cadastrar Centro de Custo
    Conferir se o cadastro do Centro de Custo foi realizado com sucesso
    Criar massa de dados Departamento
    Cadastrar Departamento
    Conferir se o cadastro do Departamento foi realizado com sucesso
    Inativar um departamento ativo
    Conferir se o departamento foi inativado com sucesso
   



    
  

