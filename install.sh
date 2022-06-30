#PRE-INSTALL
#A. Importo los templates
#https://raw.githubusercontent.com/jboss-container-images/redhat-sso-7-openshift-image/sso75-cpaas-dev/templates/sso75-ocp4-x509-https.json

for resource in sso75-ocp4-x509-https.json \
    sso75-image-stream.json \ 
    sso75-https.json sso75-postgresql.json \
    sso75-postgresql-persistent.json \ 
    sso75-x509-https.json \
    sso75-x509-postgresql-persistent.json
do
 oc replace -n openshift --force -f \
 https://raw.githubusercontent.com/jboss-container-images/redhat-sso-7-openshift-image/sso75-cpaas-dev/templates/${resource}
done

# EL QUE IMPORTA!
oc replace -n openshift --force -f \
 https://raw.githubusercontent.com/jboss-container-images/redhat-sso-7-openshift-image/sso75-cpaas-dev/templates/sso75-ocp4-x509-https.json


# 1. Creo proyecto
oc new-project sso75-giss-integ


#2. **Configurar credenciales del repositorio Git**
oc create secret -n sso75-giss-integ generic gitlab-basic-auth \
    --from-literal=username=splatas \
    --from-literal=password=glpat-ozhvqye3E6fwZDYVs1DM \
    --type=kubernetes.io/basic-auth

oc annotate -n sso75-giss-integ secret/gitlab-basic-auth \
    'build.openshift.io/source-secret-match-uri-1=https://gitlab.consulting.redhat.com/*'


#3. **Generar Imagen Docker**
oc -n sso75-giss-integ new-build https://gitlab.consulting.redhat.com/splatas/es-giss-docker.git  \
    --name rhsso-integracion --context-dir=. -lapp=sso -lcustom=sgr


#4. **Instanciar y/o Deployar Red Hat Single SignOn**
oc new-app -n sso75-giss-integ --template=sso74-ocp4-x509-https \
        --param=SSO_ADMIN_USERNAME=admin \
        --param=SSO_ADMIN_PASSWORD="redhat01"
