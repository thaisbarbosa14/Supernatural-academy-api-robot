*** Settings ***
Documentation  O objetivo deste arquivo é armazenar todos os recursos para os testes
Library   RequestsLibrary
Library   String
Library   Collections
Library   OperatingSystem


*** Keywords ***
Desativar Avisos TLS
     ${result}=    Evaluate    urllib3.disable_warnings()    urllib3
     Log    Avisos de TLS/SSL desativados: ${result}
     RETURN    ${result}

#Realização do Login e obter Token
Criar sessão
    ${headers}    Create Dictionary    accept=application/json    Content-Type=application/json
    Create Session    alias=Develop    url=https://supernatural.qacoders-academy.com.br    headers=${headers}

Entrar com usuario sysadmin
    ${body}    Create Dictionary  mail=sysadmin@qacoders.com  password=1234@Test
    Log    ${body}  
    Criar sessão
    ${resposta}     POST On Session    alias=Develop    url=/api/login    json=${body}
    Log    ${resposta.json()}
    Set Test Variable    ${TOKEN}    ${resposta.json()["token"]}

Validar o token e gravar em um header de autorização
    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}
    ${resposta}   GET On Session       alias=Develop    url=/api/validateToken    headers=${headers}
    Run Keyword And Ignore Error    Log    Resposta da Solicitação: ${resposta.content}
    Log   ${TOKEN}

#Criar Massa de Dados
Criar massa de dados Diretoria
    ${palavra_randomica}    Generate Random String    length=8    chars=[LETTERS]
    ${palavra_randomica_lowercase}    Convert To Lower Case    ${palavra_randomica} 
    Set Test Variable    ${BOARD_RANDOM}    ${palavra_randomica_lowercase}
    Log    ${BOARD_RANDOM}

Criar massa de dados Centro de Custo
    ${palavra_randomica_2}    Generate Random String    length=8    chars=[LETTERS]
    ${palavra_randomica_lowercase_2}    Convert To Lower Case    ${palavra_randomica_2} 
    Set Test Variable    ${CENTER_RANDOM}    ${palavra_randomica_lowercase_2}
    Log    ${CENTER_RANDOM}

Criar massa de dados Departamento
    ${palavra_randomica_3}    Generate Random String    length=8    chars=[LETTERS]
    ${palavra_randomica_lowercase_3}    Convert To Lower Case    ${palavra_randomica_3} 
    Set Test Variable    ${DEPARTMENT_RANDOM}    ${palavra_randomica_lowercase_3}
    Log    ${CENTER_RANDOM}

#Inicio dos Testes
Cadastrar Diretoria
    ${headers}=    Create Dictionary    Authorization=${TOKEN}
    ${body_board}        Create Dictionary    boardName=${BOARD_RANDOM}
    Log            ${body_board}
    ${resposta_board}    POST On Session     alias=Develop    url=/api/board    headers=${headers}    json=${body_board}   
    Log            ${resposta_board.json()}
    Set Test Variable    ${ID_BOARD}     ${resposta_board.json()["newBoard"]["_id"]}
    Set Test Variable    ${RESPOSTA_CREATE_BOARD}     ${resposta_board.json()}

Conferir se o cadastro da diretoria foi realizado com sucesso
    Log    ${RESPOSTA_CREATE_BOARD}
    Dictionary Should Contain Item    ${RESPOSTA_CREATE_BOARD}    msg    Cadastro realizado com sucesso!
  

Cadastrar Centro de Custo
    ${headers}=    Create Dictionary    Authorization=${TOKEN}
    ${body_center}        Create Dictionary    costCenterName=${CENTER_RANDOM}    boardId=${ID_BOARD}
    Log            ${body_center}
    ${resposta_center}    POST On Session     alias=Develop    url=/api/costCenter    headers=${headers}    json=${body_center}   
    Log            ${resposta_center.json()}
    Set Test Variable    ${ID_CENTER}     ${resposta_center.json()["newCostCenter"]["_id"]}
    Set Test Variable    ${RESPOSTA_CREATE_CENTER}     ${resposta_center.json()}

Conferir se o cadastro do Centro de Custo foi realizado com sucesso
    Log    ${RESPOSTA_CREATE_CENTER}
    Dictionary Should Contain Item    ${RESPOSTA_CREATE_CENTER}    msg    Cadastro realizado com sucesso.


Cadastrar Departamento
    ${headers}=    Create Dictionary    Authorization=${TOKEN}
    ${body_department}        Create Dictionary    departmentName=${DEPARTMENT_RANDOM}    costCenterId=${ID_CENTER}
    Log            ${body_department}
    ${resposta_department}    POST On Session     alias=Develop    url=/api/department    headers=${headers}    json=${body_department}   
    Log            ${resposta_department.json()}
    Set Test Variable    ${ID_DEPARTMENT}     ${resposta_department.json()["newDepartment"]["_id"]}
    Set Test Variable    ${RESPOSTA_CREATE_DEPARTMENT}     ${resposta_department.json()}

Conferir se o cadastro do Departamento foi realizado com sucesso
    Log    ${RESPOSTA_CREATE_DEPARTMENT}
    Dictionary Should Contain Item    ${RESPOSTA_CREATE_DEPARTMENT}    msg    Cadastro realizado com sucesso.


Inativar um departamento ativo
    ${headers}=    Create Dictionary    Authorization=${TOKEN}
    ${body_status_1}        Create Dictionary    status=false
    Log            ${body_status_1}
    ${resposta_status_1}    PUT On Session     alias=Develop    url=/api/department/status/${ID_DEPARTMENT}  headers=${headers}    json=${body_status_1}   
    Log            ${resposta_status_1.json()}
    Log            ${ID_DEPARTMENT}
    Set Test Variable    ${RESPOSTA_STATUS_1}     ${resposta_status_1.json()}

Conferir se o departamento foi inativado com sucesso
    Log    ${RESPOSTA_STATUS_1}
    Dictionary Should Contain Item    ${RESPOSTA_STATUS_1}    msg    Departamento inativado com sucesso!

Confirmando se o status está como inativo - GET
    ${headers}=    Create Dictionary    Authorization=${TOKEN}
    ${resposta_status_4}    GET On Session     alias=Develop    url=/api/department/${ID_DEPARTMENT}  headers=${headers}    
    Log            ${resposta_status_4.json()}
    Log            ${ID_DEPARTMENT}
    Set Test Variable    ${RESPOSTA_STATUS_4}     ${resposta_status_4.json()}
