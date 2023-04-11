#! /bin/bash

. $(dirname ${BASH_SOURCE[0]})/doit-preamble.bash

# ------------------------------------------------------------------------
# Cull redundant and poor-quality genomes
# ------------------------------------------------------------------------

echo 1>&2 '# Cull redundant and poor-quality genomes'

rm -rf ${CULLED}
mv ${GENOMES} ${CULLED}
mkdir ${GENOMES}

# ugly-hack: if IFS=$'\t', when Bash treats _sequences_ of tabs as
# field separators and blank fields are lost.

cat ${DATA}/metadata.1.tsv | tr '\t' '\a' | (
    while IFS=$'\a' read NAME ACCESSION SOURCE ORGANISM STRAIN LEVEL STATUS DATE \
	     CATEGORY TYPECODE \
	     SEQS BASES MEDIAN MEAN N50 L50 MIN MAX \
	     BUSCO_DB BUSCO_C BUSCO_S BUSCO_D BUSCO_F BUSCO_M BUSCO_N
    do
	if [ "${NAME}" = "Name" ] ; then
	    if [ ${BUSCO_N} != "n" ] ; then
		echo 1>&2 "Something is wrong with header"
		exit 1
	    fi
	    continue
	fi

	if [ "${REMOVE_REDUNDENT}" ] ; then
	    case "$NAME" in
		*~)
		    echo 1>&2 "## skipping $NAME (redundent)"
		    continue
	    esac
	fi

	if [ "${REMOVE_DRAFT}" ] ; then
	    if [ "$LEVEL" != "Complete Genome" ] ; then
		echo 1>&2 "## skipping $NAME (draft)"
		continue
	    fi
	fi

	if [ "${REQUIRE_BUSCO_DB}" ] ; then
	    if [ "${REQUIRE_BUSCO_DB}" != "${BUSCO_DB}" ] ; then
		echo 1>&2 "## skipping $NAME (BUSCO_DB=${BUSCO_DB})"
		continue
	    fi
	fi
	if [ "${REQUIRE_BUSCO_C}" ] ; then
	    BUSCO_C="$(echo "${BUSCO_C}" | sed -e 's/%$//')"
	    if perl -e "exit !(${REQUIRE_BUSCO_C} <= ${BUSCO_C})" ; then
		: ok
	    else
		echo 1>&2 "## skipping $NAME (BUSCO_C=${BUSCO_C}%)"
		continue
	    fi
	fi
	if [ "${REQUIRE_BUSCO_D}" ] ; then
	    BUSCO_D="$(echo "${BUSCO_D}" | sed -e 's/%$//')"
	    if perl -e "exit !(${REQUIRE_BUSCO_D} >= ${BUSCO_D})" ; then
		: ok
	    else
		echo 1>&2 "## skipping $NAME (BUSCO_D=${BUSCO_D}%)"
		continue
	    fi
	fi

	#echo 1>&2 "## $NAME ($ACCESSION)"
	mv ${CULLED}/${NAME}.* ${GENOMES}/
    done
)
    
shopt -s nullglob

if [ $(ls ${GENOMES}/*.fna /dev/null | wc -l) = 1 ] ; then
    echo 1>&2 "# nothing in ${GENOMES}"
    exit 1
fi

# ------------------------------------------------------------------------
# Done.
# ------------------------------------------------------------------------

echo 1>&2 '# Done.'

