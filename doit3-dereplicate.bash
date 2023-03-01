#! /bin/bash

. $(dirname ${BASH_SOURCE[0]})/doit-preamble.bash

# ------------------------------------------------------------------------
# Running dereplicator.py
# ------------------------------------------------------------------------

if [ "${RUN_DEREPLICATOR}" ] ; then

    echo 1>&2 '# Running dereplicator.py'

    rm -rf ${REPLICATES}
    mv ${GENOMES} ${REPLICATES}
    
    python ${PIPELINE}/Assembly-Dereplicator/dereplicator.py \
	   ${DEREPLICATOR_ARGS} \
	   ${REPLICATES} ${GENOMES}

    for FNA in ${GENOMES}/*.fna ; do
    	NAME=$(basename $FNA .fna)
    	mv ${REPLICATES}/${NAME}.faa ${REPLICATES}/${NAME}.gff ${GENOMES}/
    done

fi

# ------------------------------------------------------------------------
# Done.
# ------------------------------------------------------------------------

echo 1>&2 '# Done.'

