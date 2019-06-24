# Instalação do Shibboleth 3.4.4 por Ansible

Procedimento de utilização do pacote de Ansible para instalação do **Shibboleth 3.4.4**

## [Pré-requisitos](#pre-requisitos) ##

O primeiro passo a efectuar é instalar os pacotes ansible e *git* para obter o código de instalação do **Shibboleth 3.4.4** por código Ansible. 

```
shell> yum -y install ansible git
```

Efectuar o download do código Ansible a partir do repositório *git*.

```
shell> git clone https://gitlab.fccn.pt/dev-sid/shibboleth-3-4-4-centos7-org.git
```

Após ter-se efectuado o *download* do código, entre na nova pasta **shibboleth-3-4-3-centos7-org**:

```
shell> cd shibboleth-3-4-4-centos7-org
```

Editar o ficheiro de definições gerais sobre a instituição e da instalação em curso no seguinte ficheiro

```
shell> vi group_vars/general_definitions
```

Exemplo de um conjunto de configurações:

```
#
# Configurações Apache
######################
organization_domain: fccn.pt
server_name: idp-server.fccn.pt
server_admin: idp-server-admin@fccn.pt


#
# Certificados digitais
#######################
path_ssl_cert_key_file: /etc/pki/tls/private/idp-server_fccn_pt.key
path_ssl_cert_file: /etc/pki/tls/certs/idp/idp-server_fccn_pt.crt
path_ssl_cert_chain_file: /etc/pki/tls/certs/idp/DigiCertCA.crt


#
# Configurações de Base de Dados
postgresql_backup_dest: /var/lib/pgsql/backups


#
# Configurações Tomcat
######################
tomcat_version: 9.0.16
tomcat_xms: 512M
tomcat_xmx: 3072M


#
# Configurações LDAP
##########################
ip_range_access_control: '0.0.0.0/0'  # Tem de estar obrigatoriamente entre 'plicas'
idp_metadata: aaitest                 # No caso de testes aaitest, caso de produção recsaai
ldap_url: ip_servidor                 # Pode ser o endereco IP ou o FQDN do servidor da AD ou LDAP server
ldap_dn_format: dc=corp,dc=fccn,dc=pt
ldap_port: ldap_port                  # Porto de ligação à AD ou LDAP (standart 389)
ldap_username: ldap_username
ldap_password: ldap_password
ldap_type: sAMAccountName             # No caso de AD sAMAccountName, no caso de LDAP uid


#
# Configurações Shibboleth
##########################
IDP_VERSION: 3.4.4
source_directory: /usr/local/dist/shibboleth-identity-provider-3.4.4
installation_directory: /opt/shibboleth-idp
SAML_entityID: https://idp.fccn.pt/idp/shibboleth
attribute_scope:  fccn.pt
backchannel_PKCS12_password: password
cookie_Encryption_key_password: password

## Iniciar instalação do Shibboleth por código Ansible ##

A instalação do Shibboleth depende das parametrizações efectuadas no ficheiro **general_definitions**. Serão abordadas em baixo, as parametrizações necessárias a preencher relativas à sua instituição.
- **organization_domain**:  Indicar qual é o nome da organização da instituição, ex:. **fccn.pt**
- **server_name**: Nome da máquina ou FQDN onde está a ser instalado o Shibboleth, ex:. **idp.fccn.pt**
- **server_admin**: Endereço de email de administração da Instituição
- **path_ssl_cert_key_file**:  Caminho completo para o ficheiro que contem a chave (key) do certificado digital gerado no ponto [1.2.1 Instalação - Apache HTTP Server 2.4.] (https://confluence.fccn.pt/pages/viewpage.action?pageId=19431489#id-1.Instala%C3%A7%C3%A3odoShibbolethIdP3.3.0-1.2.1Instala%C3%A7%C3%A3o-ApacheHTTPServer2.4)
- **path_ssl_cert_file**: Caminho completo para o ficheiro que contem o certificado digital gerado no ponto [1.2.1 Instalação - Apache HTTP Server 2.4.] (https://confluence.fccn.pt/pages/viewpage.action?pageId=19431489#id-1.Instala%C3%A7%C3%A3odoShibbolethIdP3.3.0-1.2.1Instala%C3%A7%C3%A3o-ApacheHTTPServer2.4)
- **path_ssl_cert_chain_file**: Caminho completo para o ficheiro que contem o Chain Authority recebido no ponto [1.2.1 Instalação - Apache HTTP Server 2.4.] (https://confluence.fccn.pt/pages/viewpage.action?pageId=19431489#id-1.Instala%C3%A7%C3%A3odoShibbolethIdP3.3.0-1.2.1Instala%C3%A7%C3%A3o-ApacheHTTPServer2.4)
- **postgresql_backup_dest**: Caminho para a pasta onde ficaram alojados os backups da base de dados. Os backups serão lançados automaticamente todos dias durante a madrugada.
- **tomcat_xms**: Definir o tamanho de heap size inicial em memória no arranque do Tomcat. Exemplo, **512M**
- **tomcat_xmx**: Definir o tamanho de heap size máximo em memória do Tomcat. Exemplo, **3072M**
- **ip_range_access_control**: Indicar a rede e o domínio em que é permitido visualizar o estado do IdP. É obrigatório a rede estar entre plicas. Por defeito pode-se deixar durante
- **idp_metadata**: Activar a metadata a utilizar.
- **ldap_url**: Indicar qual é o endereço do servidor da AD ou LDAP da instituição.
- **ldap_dn_format**: Devem ser indicados os objectos a consultar na AD da instituição. Exemplo, **dc=corp,dc=fccn,dc=pt**
- **ldap_port**: Indicar qual o porto de comunicação com o AD ou LDAP. Exemplo: **389**
- **ldap_username**: Representa o utilizador que irá efetuar a ligação à AD ou LDAP da instituição. Exemplo, **ldap_user@corp.fccn.pt**
- **ldap_password**: Indicar qual é a password de acesso à AD utilizada pelo o utilizador definido para **ldap_bind_dn**.
- **ldap_type**: Atributo de AD ou LDAP a utilizar:
  - quando AD: **sAMAccountName**
  - quando LDAP: **uid**

## Instalação do Shibboleth por código Ansible ##

Após as configurações básicas do Ansible deve ser executado o *playbook* de instalação do Shibboleth da seguinte forma:

```
[root@idp-server shibboleth-3-4-4-centos7-org]# ansible-playbook -i "localhost," --connection=local ~/shibboleth-3-4-4-centos7-org/main.yml
```

PLAY [all] *****************************************************************************************
TASK [Gathering Facts] *****************************************************************************
ok: [localhost]
```

Quando termina a execução do Ansible espera-se que termina da seguinte forma:

```
RUNNING HANDLER [httpd : restart httpd] ************************************************************
changed: [localhost]
 
RUNNING HANDLER [tomcat : restart tomcat] **********************************************************
changed: [localhost]
 
PLAY RECAP ****************************************************************
localhost                  : ok=163  changed=124  unreachable=0    failed=0
```

## Após execução do código Ansible ##

Após a instalação com sucesso do Ansible, deve ser realizado um reboot à máquina para validar que os seguintes serviços arrancam com sucesso.

```
shell> reboot
```

## Validar serviços ##

### Validar Apache ###

```
shell> systemctl status httpd
● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled; vendor preset: disabled)
   Active: active (running) since Thu 2017-09-21 12:29:45 WEST; 3min 38s ago
     Docs: man:httpd(8)
           man:apachectl(8)
 Main PID: 666 (httpd)
   Status: "Total requests: 0; Current requests/sec: 0; Current traffic:   0 B/sec"
   CGroup: /system.slice/httpd.service
           ├─666 /usr/sbin/httpd -DFOREGROUND
           ├─763 /usr/sbin/httpd -DFOREGROUND
           ├─764 /usr/sbin/httpd -DFOREGROUND
           ├─765 /usr/sbin/httpd -DFOREGROUND
           ├─766 /usr/sbin/httpd -DFOREGROUND
           └─768 /usr/sbin/httpd -DFOREGROUND
Sep 21 12:29:45 idp-server.fccn.pt systemd[1]: Starting The Apache HTTP Server...
Sep 21 12:29:45 idp-server.fccn.pt httpd[666]: AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using idp-server.fccn.pt. Set the 'Server...his message
Sep 21 12:29:45 idp-server.fccn.pt systemd[1]: Started The Apache HTTP Server.
Hint: Some lines were ellipsized, use -l to show in full.
```

### Validar Tomcat ###

```
shell> systemctl status tomcat
● tomcat.service - Apache Tomcat 8 Web Application Container
   Loaded: loaded (/etc/systemd/system/tomcat.service; enabled; vendor preset: disabled)
   Active: active (running) since Thu 2017-09-21 12:29:45 WEST; 3min 24s ago
  Process: 665 ExecStart=/opt/tomcat/bin/startup.sh (code=exited, status=0/SUCCESS)
 Main PID: 704 (java)
   CGroup: /system.slice/tomcat.service
           └─704 /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.144-0.b01.el7_4.x86_64/jre/bin/java -Djava.util.logging.config.file=/opt/tomcat/conf/logging.properties -Djava.util.logging.man...
Sep 21 12:29:45 idp-server.fccn.pt systemd[1]: Starting Apache Tomcat 8 Web Application Container...
Sep 21 12:29:45 idp-server.fccn.pt startup.sh[665]: Existing PID file found during start.
Sep 21 12:29:45 idp-server.fccn.pt startup.sh[665]: Removing/clearing stale PID file.
Sep 21 12:29:45 idp-server.fccn.pt systemd[1]: Started Apache Tomcat 8 Web Application Container.
```

### Validar Postgresql ###

```
shell> systemctl status postgresql
● postgresql.service - PostgreSQL database server
   Loaded: loaded (/usr/lib/systemd/system/postgresql.service; enabled; vendor preset: disabled)
   Active: active (running) since Thu 2017-09-21 12:29:46 WEST; 3min 30s ago
  Process: 685 ExecStart=/usr/bin/pg_ctl start -D ${PGDATA} -s -o -p ${PGPORT} -w -t 300 (code=exited, status=0/SUCCESS)
  Process: 663 ExecStartPre=/usr/bin/postgresql-check-db-dir ${PGDATA} (code=exited, status=0/SUCCESS)
 Main PID: 715 (postgres)
   CGroup: /system.slice/postgresql.service
           ├─ 715 /usr/bin/postgres -D /var/lib/pgsql/data -p 5432
           ├─ 748 postgres: logger process  
           ├─ 758 postgres: checkpointer process  
           ├─ 759 postgres: writer process  
           ├─ 760 postgres: wal writer process  
           ├─ 761 postgres: autovacuum launcher process  
           ├─ 762 postgres: stats collector process  
           └─1722 postgres: shibboleth shibboleth 127.0.0.1(50602) idle
Sep 21 12:29:45 idp-server.fccn.pt systemd[1]: Starting PostgreSQL database server...
Sep 21 12:29:46 idp-server.fccn.pt systemd[1]: Started PostgreSQL database server.
```

### Validar Selinux ###

```
shell> sestatus
SELinux status:                 disabled
```

### Validar iptables ###

Nos casos em que a firewall tem de estar activa, devemos validar que está a ser permitidas ligações ao **HTTP** e **HTTPS**:

```
iptables -L IN_public_allow
Chain IN_public_allow (1 references)
target     prot opt source               destination        
ACCEPT     tcp  --  anywhere             anywhere             tcp dpt:ssh ctstate NEW
ACCEPT     tcp  --  anywhere             anywhere             tcp dpt:http ctstate NEW
ACCEPT     tcp  --  anywhere             anywhere             tcp dpt:https ctstate NEW
```

## Concluir a configuração do Layout ##

Após a execução do código Ansible é necessário actualizar o layout das paginas apresentadas pelo Shibboleth. As alterações a efetuar estão descritas neste link [2.10 Atualizar o Layout do IdP e Mensagens](https://confluence.fccn.pt/pages/viewpage.action?pageId=19431518#id-2.ConfiguraçãoShibbolethIdP3.3.0-2.10AtualizaroLayoutdoIdPeMensagens), a partir do ponto "**3 - Deve ser actualizado o seguinte de acordo com a instituição**".

## Finalizar ##

No final das configurações se pretender limpar os ficheiros auxiliares colocados no servidor, pode apagar a pasta **shibboleth-3-4-3-centos7** que contem o respositorio git assim como os pacotes de sistema operativo git e ansible.

```
shell> rm -rf shibboleth-3-4-3-centos7/
shell>  yum remove ansible git
Loaded plugins: fastestmirror
Resolving Dependencies
--> Running transaction check
---> Package ansible.noarch 0:2.3.2.0-2.el7 will be erased
---> Package git.x86_64 0:1.8.3.1-12.el7_4 will be erased
--> Processing Dependency: git = 1.8.3.1-12.el7_4 for package: perl-Git-1.8.3.1-12.el7_4.noarch
--> Running transaction check
---> Package perl-Git.noarch 0:1.8.3.1-12.el7_4 will be erased
--> Finished Dependency Resolution
Dependencies Resolved
==============================================================================================================
 Package                          Arch                 Version                      Repository           Size
==============================================================================================================
Removing:
 ansible                          noarch               2.3.2.0-2.el7                @extras              27 M
 git                              x86_64               1.8.3.1-12.el7_4             @updates             22 M
Removing for dependencies:
 perl-Git                         noarch               1.8.3.1-12.el7_4             @updates             57 k
Transaction Summary
==============================================================================================================
Remove  2 Packages (+1 Dependent package)
Installed size: 49 M
Is this ok [y/N]: y
Downloading packages:
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Erasing    : ansible-2.3.2.0-2.el7.noarch                                                                1/3
  Erasing    : perl-Git-1.8.3.1-12.el7_4.noarch                                                            2/3
  Erasing    : git-1.8.3.1-12.el7_4.x86_64                                                                 3/3
  Verifying  : git-1.8.3.1-12.el7_4.x86_64                                                                 1/3
  Verifying  : ansible-2.3.2.0-2.el7.noarch                                                                2/3
  Verifying  : perl-Git-1.8.3.1-12.el7_4.noarch                                                            3/3
Removed:
  ansible.noarch 0:2.3.2.0-2.el7                                   git.x86_64 0:1.8.3.1-12.el7_4
Dependency Removed:
  perl-Git.noarch 0:1.8.3.1-12.el7_4
Complete!
```
