#!/bin/bash
set -ev

cd travis/
./datomic-free-0.9.5394/bin/transactor $(pwd)/datomic_transactor.properties &
./minimesos up

cd ../../scheduler
# on travis, ports on 172.17.0.1 are bindable from the host OS, and are also
# available for processes inside minimesos containers to connect to
LIBPROCESS_IP=172.17.0.1 lein run ../simulator/travis/scheduler_config.edn &

cd ../simulator
lein run -c config/settings.edn setup-database -c travis/simulator_config.edn

set e
lein run -c config/settings.edn travis -c travis/simulator_config.edn
SIM_EXIT_CODE=$?

cat ../scheduler/log/cook.log | grep -C 5 "error\|exception"

echo "Printing out all executor logs..."
while read path; do
    cat "$path"
done <<< "$(find travis/.minimesos -name 'stdout' -o -name 'stderr' -o -name 'executor.log')"

exit $SIM_EXIT_CODE