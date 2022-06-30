echo "@@@@@@@@@@@@@@@ Executing postconfigure.sh"
$JBOSS_HOME/bin/jboss-cli.sh --file=/opt/eap/extensions/actions.cli
echo "@@@@@@@@@@@@@@@ Finish postconfigure.sh"
