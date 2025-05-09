#! /bin/bash

. $(dirname ${BASH_SOURCE[0]})/doit-preamble.bash

# ------------------------------------------------------------------------
# Finalize the metadata
# ------------------------------------------------------------------------

echo 1>&2 "# Finalize the metadata"

head -n1 data/metadata.1.tsv > data/metadata.tsv

# ugly-hack: This is really ugly ($O(n^2)$ and can be greatly improved.
for FNA in ${GENOMES}/*.fna ; do
    NAME="$(basename $FNA .fna)"
    grep '^'"$NAME"$'\t' data/metadata.1.tsv >> data/metadata.tsv
done

# ------------------------------------------------------------------------
# Generating metadata file...
# ------------------------------------------------------------------------

echo 1>&2 '# print version numbers...'

(
    set -x
    mash --version
)


# ------------------------------------------------------------------------
# Done.
# ------------------------------------------------------------------------

echo 1>&2 '# Done.'

