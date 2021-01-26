#!/bin/sh -x

if [ $# -ne 2 ]; then
	echo "err: health_check.sh application_name revision"
	exit 2
fi
x=0
echo -n "Waiting for argocd to synchronize updates ..."
/tmp/argocd app diff $1 --revision $2 1>> /dev/null 2>>/dev/null
while [[ $? -ne 0 && $x -le 9 ]];
do
	let x=x+1
	echo -n "..."
	sleep 30
	/tmp/argocd app diff $1 --revision $2 1>> /dev/null 2>>/dev/null
done

if [ $? -eq 0 ]; then
	x=0
	echo ""
	eccho "Argocd kubes-manifests sync completed successfully"
	echo -n "Waiting for deployed application to comeup and healthy ..."
	hst=`/tmp/argocd app get $1  |awk '/^Health Status/' | awk '{print $3}'`
	while [[ $hst != 'Healthy' && $x -le 9 ]];
	do
		let x=x+1
		hst=`/tmp/argocd app get $1  |awk '/^Health Status/' | awk '{print $3}'`
		sleep 30
		echo -n "..."
	done
	if [ $hst == 'Healthy' ]; then
		echo "$1 Successfully deployed by argocd"
		exit 0
	fi
	echo "ERR: Deployed Application not stable, please check and rollback ... "
	exit 1
fi
echo "ERR: Argocd Unable to sync latest changes, check argocd"
exit 1

## Ref : 
### argocd app set gh-actions-demo --sync-policy=none 
### argocd app  history gh-actions-demo  | tail -1 | awk '{print $1}' 
### argocd app  rollback gh-actions-demo 9 