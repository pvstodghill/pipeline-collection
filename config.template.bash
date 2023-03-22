# directory into which the results are written.
#DATA=.
#DATA=data # default

# ------------------------------------------------------------------------

# GENOMES_DIRS=  # Points to results of pipeline-genomes
# GENOMES_DIRS+=" ../genomes"
# GENOMES_DIRS+=" $HOME/lab/projects/our-genomes/Pantoea_allii_*"
GENOMES_DIRS=FIXME

# ------------------------------------------------------------------------

COLLECT_NAME_ARGS=
COLLECT_NAME_ARGS+=" -a" # Remove non-alphabetic chars from genome names
COLLECT_NAME_ARGS+=" -D" # Mark older redundent assemblies heuristically
COLLECT_NAME_ARGS+=" -S" # exclude "suppressed" assemblies
COLLECT_NAME_ARGS+=" -r -t" # add (T) and (R) prefixes
# COLLECT_NAME_ARGS+=" -d" # Throw error if dup names detected
# COLLECT_NAME_ARGS+=" -s" # Do not include genus/species in genome names
# COLLECT_NAME_ARGS+=" -u" # Make genome names uppercase

# # accessions to exclude
# COLLECT_EXCLUDE=GCF_002307475.1 # first Pantoea allii LMG 24248

#COLLECT_SUPPRESSED=yes
COLLECT_SUPPRESSED=no
#COLLECT_SUPPRESSED=only

# # abbrevations for genome names
# COLLECT_ABBREVS=
# COLLECT_ABBREVS+=" Pal_=Pantoea_allii_"
# COLLECT_ABBREVS+=" Pand_=Pantoea_ananatis_"

# ------------------------------------------------------------------------

# # Criteria for selecting genomes for analysis
# REMOVE_REDUNDENT=1
# REQUIRE_BUSCO_DB=enterobacterales
# REQUIRE_BUSCO_C=95
# REQUIRE_BUSCO_D=5

# ------------------------------------------------------------------------

# # Run <https://github.com/rrwick/Assembly-Dereplicator/>
# RUN_DEREPLICATOR=1
# DEREPLICATOR_ARGS="--distance 0.001" # prune slightly
# DEREPLICATOR_ARGS="--distance 0.025" # approx one assembly per species/subspecies
# DEREPLICATOR_ARGS="--count 100" # choose the distance adaptively

# ------------------------------------------------------------------------

# Uncomment to get packages from HOWTO
PACKAGES_FROM=howto

# # Uncomment to use conda
# PACKAGES_FROM=conda
# CONDA_ENV=pipeline-collection

#THREADS=$(nproc --all)

# ------------------------------------------------------------------------
