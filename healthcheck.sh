#!/bin/sh

if [ $# -ne 2 ]; then
	echo "err: health_check.sh application_name revision"
	exit 2
fi
x=0
/tmp/argocd app diff $1 --revision $2 1>> /dev/null 2>>/dev/null
while [[ $? -ne 0 && $x -le 10 ]];
do
	let x=x+1
	sleep 30
	/tmp/argocd app diff $1 --revision $2 1>> /dev/null 2>>/dev/null
done

if [ $? -eq 0 ]; then
	hst=`/tmp/argocd app get $1  |awk '/^Health Status/' | awk '{print $3}'`
	if [ $hst == 'Healthy' ]; then
    		exit 0
	fi
	exit 1
fi
exit 1