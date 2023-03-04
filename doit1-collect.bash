#! /bin/bash

. $(dirname ${BASH_SOURCE[0]})/doit-preamble.bash

# ------------------------------------------------------------------------

rm -rf ${EXCLUDED}
rm -rf ${GENOMES}

# ------------------------------------------------------------------------
# Collect qualifying genomes
# ------------------------------------------------------------------------

echo 1>&2 '# Collect qualifying genomes'

mkdir -p ${EXCLUDED}

for GENOMES_DIR in ${GENOMES_DIRS} ; do
    echo 1>&2 "## ${GENOMES_DIR}"

    if [ -e "${GENOMES_DIR}/metadata.tsv" ] ; then
	: noop
    elif [ -e "${GENOMES_DIR}/data/metadata.tsv" ] ; then
	GENOMES_DIR="${GENOMES_DIR}/data"
    else
	echo 1>&2 "Cannot find metadata.tsv in ${GENOMES_DIR}"
	exit 1
    fi

    if [ -e ${DATA}/metadata.0.tsv ] ; then
	tail -n+2 ${GENOMES_DIR}/metadata.tsv >> ${DATA}/metadata.0.tsv
    else
	cp --archive ${GENOMES_DIR}/metadata.tsv ${DATA}/metadata.0.tsv
    fi

    for EXT in fna faa gff ; do
	cp --archive --no-clobber ${GENOMES_DIR}/genomes/*.${EXT} ${EXCLUDED}/
    done
done
    
# ------------------------------------------------------------------------
# Rename everthing according to metadata
# ------------------------------------------------------------------------

echo 1>&2 '# Rename everthing according to metadata'

cat ${DATA}/metadata.0.tsv \
    | ${PIPELINE}/scripts/make-filenames-from-metadata \
		 ${COLLECT_NAME_ARGS} ${COLLECT_EXCLUDE} ${COLLECT_ABBREVS} \
		 > ${DATA}/metadata.1.tsv

mkdir -p ${GENOMES}

# ugly-hack: if IFS=$'\t', when Bash treats _sequences_ of tabs as
# field separators and blank fields are lost.

cat ${DATA}/metadata.1.tsv | tr '\t' '\a' | (
    while IFS=$'\a' read NAME ACCESSION IGNORED ; do
	if [ "${NAME}" = Name ] ; then
	    continue
	fi
	if [ "${ACCESSION}" = "${NAME}" ] ; then
	    echo 1>&2 "## ${ACCESSION} unchanged"
	else
	    echo 1>&2 "## ${NAME} <- ${ACCESSION}"
	fi
	for ext in fna faa gff ; do
	    if [ -e ${EXCLUDED}/${ACCESSION}.${ext} ] ; then
		if [ -e ${GENOMES}/${NAME}.${ext} ] ; then
		    echo 1>&2 "${GENOMES}/${NAME}.fna already exists."
		fi
		mv ${EXCLUDED}/"${ACCESSION}.${ext}" ${GENOMES}/"${NAME}.${ext}"
	    fi
	done
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

