#FROM registry.redhat.io/rh-sso-7/sso74-openshift-rhel8:latest
FROM registry.redhat.io/rh-sso-7/sso75-openshift-rhel8:7.5

COPY extensions/* /opt/eap/extensions/

USER root
RUN chmod 774 -R /opt/eap/
USER jboss

CMD ["/opt/eap/bin/openshift-launch.sh"]
